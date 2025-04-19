create database HospitalDB;
go
use HospitalDB;
go

create table Departments
(
    DepartmentID int primary key identity (1,1) not null,
    DepartmentBuilding int check(DepartmentBuilding > 0 and DepartmentBuilding < 6) not null,
    DepartmentName nvarchar(100) check(DepartmentName like '[A-Z]%') not null unique
);
create table Examinations
(
    ExaminationID int primary key identity(1,1) not null,
    ExaminationName nvarchar(100) check(ExaminationName like '[A-Z]%') not null unique,
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
create table Sponsors
(
    SponsorID int primary key identity(1,1) not null,
    SponsorName nvarchar(100) check(SponsorName like '[A-Z]%') not null,
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
    WardPlaces int check(WardPlaces > 0) not null,
    DepartmentID int not null foreign key references Departments(DepartmentID),
);
go
create table DoctorsExaminations
(
    DoctorExaminationID int primary key identity(1,1) not null,
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
(5, 'Dermatology'),
(1, 'Gastroenterology'),
(2, 'General Surgery'),
(3, 'Oncology'),
(4, 'Psychiatry'),
(5, 'Radiology');
go
insert into Examinations (ExaminationName) values
('Blood Test'),
('X-Ray'),
('MRI'),
('CT Scan'),
('Ultrasound'),
('Endoscopy'),
('Colonoscopy'),
('Echocardiogram'),
('Electrocardiogram'),
('Blood Pressure Check');
go
insert into Doctors (DoctorName, DoctorPremium, DoctorSalary, DoctorSurname) values
('John', 1000, 5000, 'Doe'),
('Jane', 1500, 6000, 'Smith'),
('Emily', 1200, 5500, 'Johnson'),
('Michael', 1300, 5800, 'Brown'),
('Sarah', 1100, 5200, 'Davis'),
('David', 1400, 6200, 'Miller'),
('Laura', 1600, 7000, 'Wilson'),
('James', 1700, 7500, 'Moore'),
('Linda', 1800, 8000, 'Taylor'),
('Robert', 1900, 8500, 'Anderson');
go
insert into Sponsors (SponsorName) values
('Health Corp'),
('Wellness Inc'),
('Care Foundation'),
('Life Support'),
('Health Plus');
go
insert into Donations (DonationAmount, DonationDate, DepartmentID, SponsorID) values
(10000, '2023-01-15', 1, 1),
(15000, '2023-02-20', 2, 2),
(20000, '2023-03-10', 3, 3),
(25000, '2023-04-05', 4, 4),
(30000, '2023-05-12', 5, 5);
go
insert into Wards (WardName, WardPlaces, DepartmentID) values
('Cardiology Ward', 20, 1),
('Neurology Ward', 15, 2),
('Pediatrics Ward', 25, 3),
('Orthopedics Ward', 10, 4),
('Dermatology Ward', 30, 5);
go
insert into DoctorsExaminations (DoctorExaminationStartTime, DoctorExaminationEndTime, DoctorID, ExaminationID, WardID) values
('08:30:00', '09:30:00', 1, 1, 1),
('10:00:00', '11:00:00', 2, 2, 2),
('11:30:00', '12:30:00', 3, 3, 3),
('13:00:00', '14:00:00', 4, 4, 4),
('14:30:00', '15:30:00', 5, 5, 5);



select DepartmentName
from Departments
where DepartmentBuilding = (select TOP 1 DepartmentBuilding from Departments where DepartmentName = 'Cardiology' ORDER BY DepartmentID)
  and DepartmentName != 'Cardiology';

select DepartmentName
from Departments
where DepartmentBuilding = (select TOP 1 DepartmentBuilding from Departments where DepartmentName in ('Gastroenterology', 'General Surgery') ORDER BY DepartmentID)
  and DepartmentName not in ('Gastroenterology', 'General Surgery');

select DepartmentName
from Departments
where DepartmentID = (select TOP 1 DepartmentID from Donations group by DepartmentID ORDER BY SUM(DonationAmount) ASC)
  and DepartmentID != (select TOP 1 DepartmentID from Donations group by DepartmentID ORDER BY SUM(DonationAmount) DESC);
select DoctorSurname
from Doctors
where DoctorSalary > (select TOP 1 DoctorSalary from Doctors where DoctorName = 'John' and DoctorSurname = 'Doe' ORDER BY DoctorID)

select WardName
from Wards
where WardPlaces > (select AVG(WardPlaces) from Wards where DepartmentID = (select TOP 1 DepartmentID from Departments where DepartmentName = 'Dermatology' ORDER BY DepartmentID))

select DoctorName + ' ' + DoctorSurname as FullName
from Doctors
where (DoctorSalary + DoctorPremium) > ((select TOP 1 DoctorSalary + DoctorPremium from Doctors where DoctorName = 'Sarah' and DoctorSurname = 'Davis' ORDER BY DoctorID) + 100)

select DepartmentName
from Departments
where DepartmentID in (select DepartmentID from Wards where WardID in (select WardID from DoctorsExaminations where DoctorID = (select TOP 1 DoctorID from Doctors where DoctorName = 'James' and DoctorSurname = 'Moore' ORDER BY DoctorID)))

select SponsorName
from Sponsors
where SponsorID not in (select SponsorID from Donations where DepartmentID in (select DepartmentID from Departments where DepartmentName in ('Neurology', 'Oncology')))

select DoctorSurname
from Doctors
where DoctorID in (select DoctorID from DoctorsExaminations where DoctorExaminationStartTime >= '12:00:00' and DoctorExaminationEndTime <= '15:00:00')



drop database HospitalDB;