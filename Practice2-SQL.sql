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

insert into Departments(DepartmentBuilding, DepartmentFinancing, DepartmentName) values
('1', 1000000, 'Cardiology'),
('2', 2000000, 'Dermatology'),
('3', 3000000, 'Gynecology'),
('4', 4000000, 'Neurology'),
('5', 5000000, 'Oncology');
go
insert into Diseases(DiseaseName, DiseaseSeverity) values
('Heart Disease', 5),
('Skin Disease', 4),
('Reproductive Disease', 3),
('Nervous System Disease', 2),
('Cancer', 1);
go
insert into Doctors(DoctorName, DoctorPhone, DoctorSalary, DoctorSurname) values
('John', '1234567890', 5000, 'Doe'),
('Smith', '0987654321', 4000, 'Johnson'),
('Alex', '1122334455', 4500, 'Williams'),
('David', '5566778899', 5500, 'Brown'),
('Michael', '6677889900', 6000, 'Jones');
go
insert into Examinations(ExaminationDayOfWeek, ExaminationEndTime, ExaminationStartTime, ExaminationName) values
(1, '10:00:00', '08:00:00', 'Cardiology Checkup'),
(2, '11:00:00', '09:00:00', 'Dermatology Checkup'),
(3, '12:00:00', '10:00:00', 'Gynecology Checkup'),
(4, '13:00:00', '11:00:00', 'Neurology Checkup'),
(5, '14:00:00', '12:00:00', 'Oncology Checkup');
go

select * from Departments;
select * from Diseases;
select * from Doctors;
select * from Examinations;

drop database HospitalDB;