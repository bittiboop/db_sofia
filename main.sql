create database HospitalDB;
go
use HospitalDB;
go

create table Departments
(
    DepartmentID int primary key identity(1,1) not null,
    DepartmentBuilding int check(DepartmentBuilding between 1 and 5) not null,
    DepartmentName nvarchar(100) unique check (DepartmentName <> N'') not null,
);
go
create table Doctors
(
    DoctorID int primary key identity(1,1) not null,
    DoctorName nvarchar(max) check(DoctorName <> N'') not null,
    DoctorPremium money default 0.0 check(DoctorPremium >= 0.0) not null,
    DoctorSalary money check(DoctorSalary > 0.0) not null,
    DoctorSurname nvarchar(max) check(DoctorSurname <> N'') not null,
);
go
create table DoctorsExaminations
(
    DoctorsExaminationsId int primary key identity(1,1) not null,
    DoctorsExaminationsEndTime time not null,
    DoctorsExaminationsStartTime time check(DoctorsExaminationsStartTime between '08:00' and '18:00') not null,
    DoctorID int not null,
    ExaminationID int not null,
    WardID int not null,
    foreign key (DoctorID) references Doctors(DoctorID),
    foreign key (ExaminationID) references Examinations(ExaminationID),
    foreign key (WardID) references Wards(WardID)
);
go
create table Examinations
(
    ExaminationID int primary key identity(1,1) not null,
    ExaminationName nvarchar(100) unique check(ExaminationName <> N'') not null,
);
go
create table Wards
(
    WardID int primary key identity(1,1) not null,
    WardName nvarchar(20) unique check(WardName <> N'') not null,
    WardPlaces int check(WardPlaces >= 1) not null,
    DepartmentID int not null,
    add foreign key (DepartmentID) references Departments(DepartmentID)
);
go




insert into Departments (DepartmentBuilding, DepartmentName)
values (1,  N'Cardiology'),
       (2,  N'Neurology'),
       (3,  N'Gynecology'),
       (4,  N'Urology'),
       (5,  N'Orthopedics');
go

insert into Doctors (DoctorName, DoctorPremium, DoctorSalary, DoctorSurname)
values (N'John', 1000.0, 5000.0, N'Doe'),
       (N'Jane', 2000.0, 6000.0, N'Doe'),
       (N'Jack', 3000.0, 7000.0, N'Doe'),
       (N'Jill', 4000.0, 8000.0, N'Doe'),
       (N'Jim', 5000.0, 9000.0, N'Doe');
go
insert into DoctorsExaminations (DoctorsExaminationsEndTime, DoctorsExaminationsStartTime, DoctorID, ExaminationID, WardID)
values ('18:00', '08:00', 1, 1, 1),
       ('18:00', '08:00', 2, 2, 2),
       ('18:00', '08:00', 3, 3, 3),
       ('18:00', '08:00', 4, 4, 4),
       ('18:00', '08:00', 5, 5, 5);
go
insert into Examinations (ExaminationName)
values (N'Examination1'),
       (N'Examination2'),
       (N'Examination3'),
       (N'Examination4'),
       (N'Examination5');

go
insert into Wards (WardName, WardPlaces, DepartmentID)
values (N'CardioWard', 10, 1),
       (N'NeuroWard', 20, 2),
       (N'GynecoWard', 30, 3),
       (N'UroWard', 40, 4),
       (N'OrthopedWard', 50, 5);
go

select * from Departments;
select * from Doctors;
select * from DoctorsExaminations;
select * from Examinations;
select * from Wards;

select * from Wards
where WardPlaces > 10