create database HospitalDB;
go
use HospitalDB;
go
create table Departments
(
    DepartmentID int primary key identity (1,1) not null,
    DepartmentBuilding varchar(50) check(DepartmentBuilding > 0 and DepartmentBuilding < 6) not null,
    DepartmentFinancing money check(DepartmentFinancing > 0) default 0 not null,
    DepartmentName nvarchar(100) check(DepartmentName like '[A-Z]%') not null unique
);
go
create table Diseases
(
    DiseaseID int primary key identity (1,1) not null,
    DiseaseName nvarchar(100) check(DiseaseName like '[A-Z]%') not null unique,
    DiseaseSeverity int check(DiseaseSeverity > 0 and DiseaseSeverity < 6) default 1 not null
);
go
create table Doctors
(
    DoctorID int primary key identity(1,1) not null,
    DoctorName nvarchar(max) check(DoctorName like '[A-Z]%') not null,
    DoctorPhone char(10) not null,
    DoctorPremium money check(DoctorPremium > 0) default 0 not null,
    DoctorSalary money check(DoctorSalary > 0 and DoctorSalary != 0) not null,
    DoctorSurname nvarchar(max) check(DoctorSurname like '[A-Z]%') not null
);
go
create table Examinations
(
    ExaminationID int primary key identity(1,1) not null,
    ExaminationDayOfWeek int check(ExaminationDayOfWeek > 0 and ExaminationDayOfWeek < 8) not null,
    ExaminationEndTime time not null,
    ExaminationStartTime time not null,
    CONSTRAINT chk_ExaminationStartTime CHECK (ExaminationStartTime > '07:59:59' AND ExaminationStartTime < '18:00:00' AND ExaminationStartTime < ExaminationEndTime),
    ExaminationName nvarchar(100) check(ExaminationName like '[A-Z]%') not null unique
);
go
create table Wards
(
    WardID int primary key identity(1,1) not null,
    WardBuilding int check(WardBuilding > 0 and WardBuilding < 6) not null,
    WardFloor int check(WardFloor > 0 and WardFloor < 6) not null,
    WardName nvarchar(20) check(WardName like '[A-Z]%') not null unique,
);
go

insert into Departments(DepartmentBuilding, DepartmentFinancing, DepartmentName) values
                                                                                     ('5', 10000, 'Cardiology'),
                                                                                     ('2', 20000, 'Dermatology'),
                                                                                     ('3', 30000, 'Gynecology'),
                                                                                     ('4', 40000, 'Neurology'),
                                                                                     ('5', 50000, 'Oncology');
go
insert into Diseases(DiseaseName, DiseaseSeverity) values
                                                       ('Heart Disease', 5),
                                                       ('Skin Disease', 4),
                                                       ('Reproductive Disease', 3),
                                                       ('Nervous System Disease', 2),
                                                       ('Cancer', 1);
go
insert into Doctors(DoctorName, DoctorPhone, DoctorPremium, DoctorSalary, DoctorSurname) values
('John', '1234567890', 250, 1600, 'Doe'),
('Smith', '0987654321', 40, 1400, 'Johnson'),
('Alex', '1122334455', 245, 1500, 'Williams'),
('David', '5566778899', 150, 1500, 'Brown'),
('Michael', '6677889900', 260, 1600, 'Jones');
go
insert into Examinations(ExaminationDayOfWeek, ExaminationEndTime, ExaminationStartTime, ExaminationName) values
                                                                                                              (1, '10:00:00', '08:00:00', 'Cardiology Checkup'),
                                                                                                              (2, '11:00:00', '09:00:00', 'Dermatology Checkup'),
                                                                                                              (3, '12:00:00', '10:00:00', 'Gynecology Checkup'),
                                                                                                              (4, '13:00:00', '11:00:00', 'Neurology Checkup'),
                                                                                                              (5, '14:00:00', '12:00:00', 'Oncology Checkup');
go
insert into Wards (WardBuilding, WardFloor, WardName) values
('1', 1, 'Cardiology Ward'),
('2', 2, 'Dermatology Ward'),
('3', 3, 'Gynecology Ward'),
('4', 4, 'Neurology Ward'),
('5', 5, 'Oncology Ward');

select * from Wards;
select DoctorSurname, DoctorPhone
from Doctors;
select distinct WardFloor from Wards;
select 'Name of Disease: ' +  DiseaseName, 'Severity of Disease: ' + cast(DiseaseSeverity as varchar)from Diseases;

select * from Departments d;
select * from Diseases dis;
select * from Doctors doc;

select DepartmentName from Departments
where DepartmentBuilding = 5 and DepartmentFinancing < 30000;

select DepartmentName from Departments
where DepartmentBuilding = 3 and DepartmentFinancing > 120000 and DepartmentFinancing < 15000;

select WardName from Wards
where WardBuilding = 4 and WardBuilding = 5 and WardFloor = 1;

select DepartmentName, DepartmentBuilding, DepartmentFinancing from Departments
where DepartmentBuilding = 3 or DepartmentBuilding = 6 and DepartmentFinancing < 11000 and DepartmentFinancing > 25000;

select DoctorSurname from Doctors
where Doctors.DoctorSalary + Doctors.DoctorPremium > 1500;

select DoctorSurname from Doctors
where (Doctors.DoctorSalary / 2) > (Doctors.DoctorPremium * 3);

select distinct ExaminationName from Examinations
where ExaminationDayOfWeek = 1 or ExaminationDayOfWeek = 2 or ExaminationDayOfWeek = 3 and ExaminationStartTime > '12:00:00' and ExaminationEndTime < '15:00:00';

drop database HospitalDB;