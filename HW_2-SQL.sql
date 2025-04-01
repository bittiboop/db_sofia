create database AcademyDB;
go
use AcademyDB;
go

create table Groups
(
    GroupID int primary key identity(1,1) not null,
    GroupName nvarchar(10) check(GroupName like '[A-Z]%') not null unique,
    GroupRating int check(GroupRating > 0 and GroupRating < 6) default 1 not null,
    GroupYear int check(GroupYear > 0 and GroupYear < 6) not null,
);
go
create table Departments
(
    DepartmentID int primary key identity(1,1) not null,
    DepartmentFinancing money check(DepartmentFinancing > 0) default 0 not null,
    DepartmentName nvarchar(100) check(DepartmentName like '[A-Z]%') not null unique,
);
go
create table Faculties
(
    FacultyID int primary key identity(1,1) not null,
    FacultyName nvarchar(100) check(FacultyName like '[A-Z]%') not null unique,
);
go
create table Teachers
(
    TeacherID int primary key identity(1,1) not null,
    TeacherEmploymentDate date check(TeacherEmploymentDate > '01.01.1990') not null,
    TeacherName nvarchar(max) check(TeacherName like '[A-Z]%') not null,
    TeacherPremium money check(TeacherPremium > 0) default 0 not null,
    TeacherSalary money check(TeacherSalary > 0 and TeacherSalary != 0) not null,
    TeacherSurname nvarchar(max) check(TeacherSurname like '[A-Z]%') not null,
);
go

insert into Groups(GroupName, GroupRating, GroupYear) values
('A1', 5, 1),
('B2', 4, 2),
('C3', 3, 3),
('D4', 2, 4),
('E5', 1, 5);
go
insert into Departments(DepartmentFinancing, DepartmentName) values
(1000000, 'Computer Science'),
(2000000, 'Mathematics'),
(3000000, 'Physics'),
(4000000, 'Chemistry'),
(5000000, 'Biology');
go
insert into Faculties(FacultyName) values
('Engineering'),
('Science'),
('Arts'),
('Business'),
('Law');
go
insert into Teachers(TeacherEmploymentDate, TeacherName, TeacherPremium, TeacherSalary, TeacherSurname) values
('2020-01-01', 'John', 5000, 6000, 'Doe'),
('2019-02-02', 'Smith', 4000, 5500, 'Johnson'),
('2018-03-03', 'Alex', 4500, 5000, 'Williams'),
('2017-04-04', 'David', 5500, 6500, 'Brown'),
('2016-05-05', 'Michael', 6000, 7000, 'Jones');
go

select * from Groups;
select * from Departments;
select * from Faculties;
select * from Teachers;

drop database AcademyDB;