create database HospitalDB;
go
use HospitalDB;
go

create table Departments
(
    DepartmentID int primary key identity (1,1) not null,
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
create table Specializations
(
    SpecializationID int primary key identity(1,1) not null,
    SpecializationName nvarchar(100) check(SpecializationName like '[A-Z]%') not null unique
);
go
create table DoctorSpecializations
(
    DoctorSpecializationID int primary key identity(1,1) not null,
    DoctorID int not null foreign key references Doctors(DoctorID),
    SpecializationID int not null foreign key references Specializations(SpecializationID),
);
go
create table Sponsors
(
    SponsorID int primary key identity(1,1) not null,
    SponsorName nvarchar(100) check(SponsorName like '[A-Z]%') not null,
);
go
create table Vacations
(
    VacationID int primary key identity(1,1) not null,
    VacationStart date check(VacationStart > '2000-01-01') not null,
    VacationEnd date check(VacationEnd > '2000-01-01') not null,
    DoctorID int not null foreign key references Doctors(DoctorID),
);
go
create table Donations
(
    DonationID int primary key identity(1,1) not null,
    DonationAmount money check(DonationAmount > 0 or DonationAmount != 0) not null,
    DonationDate date check(DonationDate < '2025-04-15') not null,
    DepartmentID int not null foreign key references Departments(DepartmentID),
    SponsorID int not null foreign key references Sponsors(SponsorID),
);
go
create table Wards
(
    WardID int primary key identity(1,1) not null,
    WardName nvarchar(20) check(WardName like '[A-Z]%') not null unique,
    DepartmentID int not null foreign key references Departments(DepartmentID),
);
go

insert into Departments (DepartmentName) values
('Cardiology'),
('Neurology'),
('Pediatrics'),
('Oncology'),
('Orthopedics'),
('Dermatology'),
('Radiology'),
('Psychiatry'),
('Gastroenterology'),
('Urology');
go
insert into Doctors (DoctorName, DoctorPremium, DoctorSalary, DoctorSurname) values
('John', 1000, 5000, 'Doe'),
('Jane', 1200, 6000, 'Smith'),
('Emily', 1500, 7000, 'Johnson'),
('Michael', 1300, 5500, 'Brown'),
('Sarah', 1100, 5200, 'Davis'),
('David', 1400, 5800, 'Miller'),
('Laura', 1600, 7200, 'Wilson'),
('James', 1700, 8000, 'Moore'),
('Linda', 1800, 9000, 'Taylor'),
('Robert', 1900, 9500, 'Anderson');
go
insert into Specializations (SpecializationName) values
('Cardiology'),
('Neurology'),
('Pediatrics'),
('Oncology'),
('Orthopedics'),
('Dermatology'),
('Radiology'),
('Psychiatry'),
('Gastroenterology'),
('Urology');
go
insert into DoctorSpecializations (DoctorID, SpecializationID) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
go
insert into Sponsors (SponsorName) values
('HealthCorp'),
('Wellness Inc.'),
('CarePlus'),
('MediAid'),
('HealthFirst'),
('LifeLine'),
('Wellbeing Ltd.'),
('CureAll'),
('Vitality Partners'),
('HealthGuard');
go
insert into Vacations (VacationStart, VacationEnd, DoctorID) values
('2023-06-01', '2023-06-15', 1),
('2023-07-01', '2023-07-15', 2),
('2023-08-01', '2023-08-15', 3),
('2023-09-01', '2023-09-15', 4),
('2023-10-01', '2023-10-15', 5),
('2023-11-01', '2023-11-15', 6),
('2023-12-01', '2023-12-15', 7),
('2024-01-01', '2024-01-15', 8),
('2024-02-01', '2024-02-15', 9),
('2024-03-01', '2024-03-15', 10);
go
insert into Donations (DonationAmount, DonationDate, DepartmentID, SponsorID) values
(10000, '2023-01-01', 1, 1),
(15000, '2023-02-01', 2, 2),
(20000, '2023-03-01', 3, 3),
(25000, '2023-04-01', 4, 4),
(30000, '2023-05-01', 5, 5),
(35000, '2023-06-01', 6, 6),
(40000, '2023-07-01', 7, 7),
(45000, '2023-08-01', 8, 8),
(50000, '2023-09-01', 9, 9),
(55000, '2023-10-01', 10, 10);
go
insert into Wards (WardName, DepartmentID) values
('Ward A', 1),
('Ward B', 2),
('Ward C', 3),
('Ward D', 4),
('Ward E', 5),
('Ward F', 6),
('Ward G', 7),
('Ward H', 8),
('Ward I', 9),
('Ward J', 10);
go

select d.DoctorName, d.DoctorSurname, s.SpecializationName
from Doctors d
         join DoctorSpecializations ds on d.DoctorID = ds.DoctorID
         join Specializations s on ds.SpecializationID = s.SpecializationID;

select d.DoctorSurname, (d.DoctorSalary + d.DoctorPremium) as TotalSalary
from Doctors d
where d.DoctorID not in (select DoctorID from Vacations);

select w.WardName
from Wards w
         join Departments d on w.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Oncology';

select distinct d.DepartmentName
from Departments d
         join Donations dn on d.DepartmentID = dn.DepartmentID
         join Sponsors s on dn.SponsorID = s.SponsorID
where s.SponsorName = 'HealthCorp';
