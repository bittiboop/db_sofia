go
use HospitalDB;
go
create table Departments
(
    DepartmentID int primary key identity (1,1) not null,
    DepartmentBuilding int check(DepartmentBuilding > 0 and DepartmentBuilding < 6) not null,
    DepartmentName nvarchar(100) check(DepartmentName like '[A-Z]%') not null unique
);
go
create table Doctors
(
    DoctorID int primary key identity(1,1) not null,
    DoctorName nvarchar(max) check(DoctorName like '[A-Z]%') not null,
    DoctorPremium money check(DoctorPremium > 0) default 0 not null,
    DoctorSalary money check(DoctorSalary > 0 and DoctorSalary != 0) not null,
    DoctorSurname nvarchar(max) check(DoctorSurname like '[A-Z]%') not null
);
go
create table Examinations
(
    ExaminationID int primary key identity(1,1) not null,
    ExaminationName nvarchar(100) check(ExaminationName like '[A-Z]%') not null unique
);
go
create table Wards
(
    WardID int primary key identity(1,1) not null,
    WardName nvarchar(20) check(WardName like '[A-Z]%') not null unique,
    WardPlaces int check(WardPlaces > 1) not null,
    DepartmentID int not null foreign key references Departments(DepartmentID),
);
go
create table DoctorsExaminations
(
    DoctorExaminationsID int primary key identity(1,1) not null,
    DoctorExaminationStartTime time check(DoctorExaminationStartTime > '08:00:00' and DoctorExaminationStartTime < '18:00:00') not null,
    DoctorExaminationEndTime time check(DoctorExaminationEndTime > '08:00:00' and DoctorExaminationEndTime < '18:00:00') not null,
    DoctorID int not null foreign key references Doctors(DoctorID),
    ExaminationID int not null foreign key references Examinations(ExaminationID),
    WardID int not null foreign key references Wards(WardID),
);
go
insert into Departments (DepartmentBuilding, DepartmentName) values
                                                                 (1, 'Cardiology'),
                                                                 (2, 'Neurology'),
                                                                 (3, 'Pediatrics'),
                                                                 (4, 'Orthopedics'),
                                                                 (5, 'Dermatology');
go
insert into Doctors (DoctorName, DoctorPremium, DoctorSalary, DoctorSurname) values
                                                                                 ('John', 1000, 5000, 'Doe'),
                                                                                 ('Jane', 1500, 6000, 'Smith'),
                                                                                 ('Emily', 1200, 5500, 'Johnson'),
                                                                                 ('Michael', 1300, 5800, 'Brown'),
                                                                                 ('Sarah', 1100, 5200, 'Davis');
go
insert into Examinations (ExaminationName) values
                                               ('Blood Test'),
                                               ('X-Ray'),
                                               ('MRI Scan'),
                                               ('CT Scan'),
                                               ('Ultrasound');
go
insert into Wards (WardName, WardPlaces, DepartmentID) values
                                                           ('Ward A', 10, 1),
                                                           ('Ward B', 15, 5),
                                                           ('Ward C', 20, 3),
                                                           ('Ward D', 12, 4),
                                                           ('Ward E', 8, 5),
                                                           ('Ward F', 25, 1),
                                                           ('Ward G', 30, 3),
                                                           ('Ward H', 18, 3),
                                                           ('Ward I', 22, 1),
                                                           ('Ward J', 14, 5);
go
insert into DoctorsExaminations (DoctorExaminationStartTime, DoctorExaminationEndTime, DoctorID, ExaminationID, WardID) values
                                                                                                                            ('08:01:00', '10:00:00', 1, 1, 1),
                                                                                                                            ('10:00:00', '12:00:00', 2, 2, 2),
                                                                                                                            ('12:00:00', '14:00:00', 3, 3, 3),
                                                                                                                            ('14:00:00', '16:00:00', 4, 4, 4),
                                                                                                                            ('16:00:00', '17:59:00', 5, 5, 5);
go


select count(WardID) as NumberOfWards
from Wards
where WardPlaces > 10;

select DepartmentBuilding as Building, count(WardID) as NumberOfWards
from Wards as W, Departments as D
where W.DepartmentID = D.DepartmentID
group by DepartmentBuilding;

select DepartmentName as Name, count(WardID) as NumberOfWards
from Wards as W, Departments as D
where W.DepartmentID = D.DepartmentID
group by DepartmentName;

select DepartmentName as Name, sum(DoctorPremium) as TotalPremium
from Departments as D, Doctors as Doc, Wards as W
where D.DepartmentID = W.DepartmentID and Doc.DoctorID = W.WardID
group by DepartmentName;

select DepartmentName as Name, count(Doc.DoctorID) as NumberOfDoctors
from Departments as D, Doctors as Doc, Wards as W, DoctorsExaminations as DE
where D.DepartmentID = W.DepartmentID and Doc.DoctorID = DE.DoctorID and W.WardID = DE.WardID
group by DepartmentName
having count(Doc.DoctorID) >= 5;

select count(DoctorID) as NumberOfDoctors, sum(DoctorSalary+DoctorPremium) as TotalSalary
from Doctors;

select sum(DoctorSalary+DoctorPremium)/count(DoctorID) as AverageSalary
from Doctors;

select WardName as Name, WardPlaces as Places
from Wards
where WardPlaces = (select min(WardPlaces) from Wards);

select DepartmentBuilding as Building, sum(WardPlaces) as TotalPlaces
from Wards as W, Departments as D
where W.DepartmentID = D.DepartmentID and DepartmentBuilding in (1, 6, 7, 8) and WardPlaces > 10
group by DepartmentBuilding
having sum(WardPlaces) > 100;


drop database HospitalDB;