create database HospitalDB;
go
use HospitalDB;
go

create table Departments
(
    DepartmentID int primary key identity (1,1) not null,
    DepartmentBuilding int check(DepartmentBuilding > 0 and DepartmentBuilding < 6) not null,
    DepartmentName nvarchar(100) check(DepartmentName like '[A-Z]%') not null unique,
    DepartmentFinancing money check(DepartmentFinancing > 0) default 0 not null
);
create table Diseases
(
    DiseaseID int primary key identity(1,1) not null,
    DiseaseName nvarchar(100) check(DiseaseName like '[A-Z]%') not null unique
);
create table Examinations
(
    ExaminationID int primary key identity(1,1) not null,
    ExaminationName nvarchar(100) check(ExaminationName like '[A-Z]%') not null unique
);
go
create table Doctors
(
    DoctorID int primary key identity(1,1) not null,
    DoctorName nvarchar(max) check(DoctorName like '[A-Z]%') not null,
    DoctorSalary money check(DoctorSalary > 0 and DoctorSalary != 0) not null,
    DoctorSurname nvarchar(max) check(DoctorSurname like '[A-Z]%') not null
);
go
create table Professors
(
    ProfessorID int primary key identity(1,1) not null,
    DoctorID int not null foreign key references Doctors(DoctorID),
);
go
create table Interns
(
    InternID int primary key identity(1,1) not null,
    DoctorID int not null foreign key references Doctors(DoctorID),
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
    DoctorExaminationDate date check(DoctorExaminationDate < '2025-04-15') not null,
    DoctorID int not null foreign key references Doctors(DoctorID),
    DiseaseID int not null foreign key references Diseases(DiseaseID),
    ExaminationID int not null foreign key references Examinations(ExaminationID),
    WardID int not null foreign key references Wards(WardID),
);
go

insert into Departments (DepartmentBuilding, DepartmentName, DepartmentFinancing) values
(1, 'Cardiology', 100000),
(2, 'Neurology', 200000),
(3, 'Pediatrics', 300000),
(4, 'Surgery', 400000),
(5, 'Orthopedics', 500000),
(1, 'Oncology', 600000),
(2, 'Psychiatry', 700000),
(3, 'Dermatology', 800000),
(4, 'Radiology', 900000),
(5, 'Anesthesiology', 1000000);
go
insert into Diseases (DiseaseName) values
('Flu'),
('Cold'),
('COVID-19'),
('Cancer'),
('Diabetes'),
('Hypertension'),
('Asthma'),
('Allergy'),
('Heart Disease'),
('Stroke');
go
insert into Examinations (ExaminationName) values
('Blood Test'),
('X-Ray'),
('MRI'),
('CT Scan'),
('Ultrasound'),
('ECG'),
('Endoscopy'),
('Biopsy'),
('Physical Exam'),
('Vaccination');
go
insert into Doctors (DoctorName, DoctorSalary, DoctorSurname) values
('John', 50000, 'Doe'),
('Jane', 60000, 'Smith'),
('Emily', 70000, 'Johnson'),
('Michael', 80000, 'Williams'),
('Sarah', 90000, 'Brown'),
('David', 100000, 'Jones'),
('Laura', 110000, 'Garcia'),
('James', 120000, 'Martinez'),
('Linda', 130000, 'Hernandez'),
('Robert', 140000, 'Lopez'),
('Patricia', 150000, 'Gonzalez'),
('Charles', 160000, 'Wilson'),
('Barbara', 170000, 'Anderson'),
('Joseph', 180000, 'Thomas'),
('Susan', 190000, 'Taylor');
go
insert into Professors (DoctorID) values
(14),
(12),
(3),
(7),
(5);
go
insert into Interns (DoctorID) values
(6),
(4),
(8),
(9),
(10),
(11),
(2),
(13),
(1),
(15);
go
insert into Wards (WardName, WardPlaces, DepartmentID) values
('Cardiology Ward', 20, 1),
('Neurology Ward', 30, 2),
('Pediatrics Ward', 25, 3),
('Surgery Ward', 15, 4),
('Orthopedics Ward', 10, 5),
('Oncology Ward', 12, 6),
('Psychiatry Ward', 18, 7),
('Dermatology Ward', 22, 8),
('Radiology Ward', 28, 9),
('Anesthesiology Ward', 14, 10);
go
insert into DoctorsExaminations (DoctorExaminationDate, DoctorID, DiseaseID, ExaminationID, WardID) values
('2023-01-01', 1, 1, 1, 1),
('2023-02-01', 2, 2, 2, 2),
('2023-03-01', 3, 3, 3, 3),
('2023-05-01', 5, 5, 5, 5),
('2023-06-01', 6, 6, 6, 6),
('2023-07-01', 7, 7, 7, 7),
('2023-08-01', 8, 8, 8, 8),
('2023-09-01', 9, 9, 9, 9),
('2023-11-01', 11, 1, 1, 1),
('2023-12-01', 12, 2, 2, 2),
('2024-01-01', 13, 3, 3, 3),
('2024-02-01', 14, 4, 4, 4),
('2024-03-01', 15, 5, 5, 5);
go

select WardName, WardPlaces
from Wards
where DepartmentID = 5 and WardPlaces >= 5 and WardPlaces > 15;

select distinct DepartmentName
from Departments d
         join Wards w on d.DepartmentID = w.DepartmentID
         join DoctorsExaminations de on w.WardID = de.WardID
where DoctorExaminationDate >= dateadd(day, -7, getdate());

select DiseaseName
from Diseases
where DiseaseID not in (select distinct DiseaseID from DoctorsExaminations);

select DoctorName + ' ' + DoctorSurname as FullName
from Doctors
where DoctorID not in (select distinct DoctorID from DoctorsExaminations);

select DepartmentName
from Departments
where DepartmentID not in (select distinct DepartmentID from Wards w
                                                                 join DoctorsExaminations de on w.WardID = de.WardID);

select DoctorSurname
from Doctors
where DoctorID in (select DoctorID from Interns);

select DoctorSurname
from Doctors
where DoctorID in (select DoctorID from Interns)
  and DoctorSalary > (select min(DoctorSalary) from Doctors where DoctorID not in (select DoctorID from Interns));

select WardName
from Wards
where WardPlaces > (select max(WardPlaces) from Wards where DepartmentID = 3);

select DoctorSurname
from Doctors
where DoctorID in (select DoctorID from DoctorsExaminations de
                                            join Wards w on de.WardID = w.WardID
                                            join Departments d on w.DepartmentID = d.DepartmentID
                   where d.DepartmentName in ('Orthopedics', 'Anaesthesiology'));

select DepartmentName
from Departments
where DepartmentID in (select DepartmentID from Wards w
                                                    join Doctors d on w.WardID = d.DoctorID
                       where d.DoctorID in (select DoctorID from Interns)
                          or d.DoctorID in (select DoctorID from Professors));

select DoctorName + ' ' + DoctorSurname as FullName, DepartmentName
from Doctors d
         join DoctorsExaminations de on d.DoctorID = de.DoctorID
         join Wards w on de.WardID = w.WardID
         join Departments dp on w.DepartmentID = dp.DepartmentID
where DepartmentFinancing > 20000;

-- Вивести назву відділення, в якому проводить обстеження лікар із найбільшою ставкою.
select DoctorName + ' ' + DoctorSurname as FullName, DepartmentName
from Doctors d
         join DoctorsExaminations de on d.DoctorID = de.DoctorID
         join Wards w on de.WardID = w.WardID
         join Departments dp on w.DepartmentID = dp.DepartmentID
where DoctorSalary = (select max(DoctorSalary) from Doctors);

select DiseaseName, count(ExaminationID) as ExaminationCount
from Diseases d
         join DoctorsExaminations de on d.DiseaseID = de.DiseaseID
group by DiseaseName;

drop database HospitalDB;