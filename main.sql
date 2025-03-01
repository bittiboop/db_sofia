create database Airport;
go
use Airport;
go

create table Airplanes
(
    AirplaneID int primary key identity(1,1),
    AirplaneType varchar(50) not null,
    AirplaneModel varchar(50) not null,
    AirplaneCapacity int not null,
    AirplaneStatus varchar(50) default 'active' check(AirplaneStatus IN ('active', 'maintenance', 'in-flight'))
);
go
create table PlaneFlights
(
    FlightID int primary key identity(1,1),
    AirplaneID int,
    FlightDate date not null,
    FlightTime time not null,
    FlightDuration int not null,
    FlightDestination varchar(50) not null,
    FlightOrigin varchar(50) not null,
    FlightPrice int not null,
    FlightStatus varchar(50) default 'scheduled' check(FlightStatus IN ('scheduled', 'cancelled', 'completed')),
    foreign key (AirplaneID) references Airplanes(AirplaneID)
);
go

create table Tickets
(
    TicketID int primary key identity(1,1),
    FlightID int not null,
    TicketPrice int not null,
    TicketClass varchar(50) not null,
    TicketStatus varchar(50) default 'booked' check(TicketStatus IN ('booked', 'cancelled', 'completed')),
    foreign key (FlightID) references PlaneFlights(FlightID)
);
go

create table Passengers
(
    PassengerID int primary key identity(1,1),
    PassengerName varchar(50) not null,
    PassengerSurname varchar(50) not null,
    PassengerBirthdate date not null,
    PassengerPassport varchar(20) unique not null,
    PassengerEmail varchar(50) not null,
    PassengerPhone varchar(50) not null,
);
go

create table FlightStatusNotifications
(
    NotificationID int primary key identity(1,1),
    FlightID int not null,
    NotificationDate date not null,
    NotificationTime datetime default current_timestamp,
    NotificationMessage varchar(50) not null,
    foreign key (FlightID) references PlaneFlights(FlightID)
);
go
create table LoyaltyPoints
(
    LoyaltyID int primary key identity(1,1),
    PassengerID int not null,
    TotalPoints int default 0,
    Tier varchar(50) default 'standard',
    lastUpdate datetime,
    foreign key (PassengerID) references Passengers(PassengerID)
);
go

insert into Airplanes(AirplaneType, AirplaneModel, AirplaneCapacity) values
                                                                         ('Boeing', '737', 150),
                                                                         ('Airbus', 'A320', 180),
                                                                         ('Boeing', '747', 400),
                                                                         ('Airbus', 'A380', 500);
go

insert into PlaneFlights(AirplaneID, FlightDate, FlightTime, FlightDuration, FlightDestination, FlightOrigin, FlightPrice) values
                                                                                                                               (1, '2021-12-01', '12:00', 120, 'Istanbul', 'Ankara', 100),
                                                                                                                               (2, '2021-12-02', '13:00', 120, 'Istanbul', 'Izmir', 150),
                                                                                                                               (3, '2021-12-03', '14:00', 120, 'Istanbul', 'Antalya', 200),
                                                                                                                               (4, '2021-12-04', '15:00', 120, 'Istanbul', 'Trabzon', 250);
go

insert into Tickets(FlightID, TicketPrice, TicketClass) values
                                                            (1, 100, 'economy'),
                                                            (1, 150, 'business'),
                                                            (2, 150, 'economy'),
                                                            (2, 200, 'business'),
                                                            (3, 200, 'economy'),
                                                            (3, 250, 'business'),
                                                            (4, 250, 'economy'),
                                                            (4, 300, 'business');

insert into Passengers(PassengerName, PassengerSurname, PassengerBirthdate, PassengerPassport, PassengerEmail, PassengerPhone) values
                                                                                                                                   ('John', 'Doe', '1990-01-01', '1234567890', 'johndoe@email.com', '1234567890'),
                                                                                                                                   ('Jane', 'Doe', '1995-01-01', '0987654321', 'janedoe@email.com', '0987654321'),
                                                                                                                                   ('Alice', 'Smith', '2000-01-01', '1357924680', 'alicesmith@email.com', '1357924680'),
                                                                                                                                   ('Bob', 'Smith', '2005-01-01', '2468135790', 'bobsmith@email.com', '2468135790');
go

insert into FlightStatusNotifications(FlightID, NotificationDate, NotificationMessage) values
                                                                                           (1, '2021-11-30', 'Flight is scheduled'),
                                                                                           (2, '2021-12-01', 'Flight is cancelled'),
                                                                                           (3, '2021-12-02', 'Flight is completed'),
                                                                                           (4, '2021-12-03', 'Flight is scheduled');
go

insert into LoyaltyPoints(PassengerID, TotalPoints, Tier, lastUpdate) values
                                                                          (1, 100, 'gold', '2021-11-30'),
                                                                          (2, 200, 'silver', '2021-12-01'),
                                                                          (3, 300, 'gold', '2021-12-02'),
                                                                          (4, 400, 'silver', '2021-12-03');
go

select * from Airplanes;
select * from PlaneFlights;
select * from Tickets;
select * from Passengers;
select * from FlightStatusNotifications;
select * from LoyaltyPoints;


create trigger flight_status_changed
    on PlaneFlights
    after update
    as
begin
    if exists(SELECT * FROM inserted i JOIN deleted d ON i.FlightID = d.FlightID WHERE i.FlightStatus != d.FlightStatus)
        begin
            update a
            set a.AirplaneStatus = 'maintenance'
            from Airplanes a
                     join inserted i on a.AirplaneID = i.AirplaneID
            where i.FlightStatus = 'cancelled';

            update a
            set a.AirplaneStatus = 'in-flight'
            from Airplanes a
                     join inserted i on a.AirplaneID = i.AirplaneID
            where i.FlightStatus = 'completed';
        end
end;
go

create trigger before_ticket_cancelled
    on Tickets
    instead of insert
    as
begin
    declare @FlightID int;
    declare @TicketID int;
    declare @TicketStatus varchar(50);
    declare @TicketClass varchar(50);
    declare @TicketPrice int;
    declare @PassengerID int;

    select @FlightID = FlightID, @TicketID = TicketID, @TicketStatus = TicketStatus, @TicketClass = TicketClass, @TicketPrice = TicketPrice
    from inserted;

    if @TicketStatus = 'cancelled'
        begin
            select @PassengerID = p.PassengerID
            from Tickets t
                     join Passengers p on t.FlightID = p.PassengerID
            where t.TicketID = @TicketID;

            update LoyaltyPoints
            set TotalPoints = TotalPoints - @TicketPrice
            where PassengerID = @PassengerID;

            delete from Tickets
            where TicketID = @TicketID;
        end
end;
go

create trigger business_class_ticket_price
    on Tickets
    after insert
    as
begin
    declare @TicketID int;
    declare @TicketClass varchar(50);
    declare @TicketPrice int;

    select @TicketID = TicketID, @TicketClass = TicketClass, @TicketPrice = TicketPrice
    from inserted;

    if @TicketClass = 'business'
        begin
            update Tickets
            set TicketPrice = @TicketPrice + 50
            where TicketID = @TicketID;
        end
end;
go

create trigger flight_status_notification
    on PlaneFlights
    after update
    as
begin
    declare @FlightID int;
    declare @NotificationMessage varchar(50);
    declare @FlightStatus varchar(50);

    select @FlightID = FlightID, @FlightStatus = FlightStatus
    from inserted;

    if @FlightStatus = 'scheduled'
        set @NotificationMessage = 'Flight is scheduled';
    else if @FlightStatus = 'cancelled'
        set @NotificationMessage = 'Flight is cancelled';
    else if @FlightStatus = 'completed'
        set @NotificationMessage = 'Flight is completed';

    insert into FlightStatusNotifications(FlightID, NotificationDate, NotificationMessage)
    values(@FlightID, getdate(), @NotificationMessage);
end;
go

create trigger loyalty_points_update
    on Tickets
    after update
    as
begin
    declare @TicketID int;
    declare @TicketStatus varchar(50);
    declare @TicketPrice int;
    declare @PassengerID int;


end;
go

drop database Airport;