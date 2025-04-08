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
    FacultyDean nvarchar(max) check(FacultyDean like '[A-Z]%') not null,
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
    TeacherIsAssistant bit default 0 not null,
    TeacherIsProfessor bit default 0 not null,
    TeacherPosition nvarchar(max) check(TeacherPosition like '[A-Z]%') not null,
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
insert into Faculties(FacultyDean, FacultyName) values
                                                    ('John Doe', 'Engineering'),
                                                    ('Jane Smith', 'Arts'),
                                                    ('Jim Brown', 'Science'),
                                                    ('Jake White', 'Business'),
                                                    ('Jill Green', 'Education');
go
insert into Teachers(TeacherEmploymentDate, TeacherName, TeacherPremium, TeacherSalary, TeacherSurname, TeacherIsAssistant, TeacherIsProfessor, TeacherPosition) values
                                                                                                                                                                     ('2020-01-01', 'Alice', 1000, 50000, 'Johnson', 1, 0, 'Assistant'),
                                                                                                                                                                     ('2019-02-15', 'Bob', 2000, 60000, 'Williams', 0, 1, 'Professor'),
                                                                                                                                                                     ('2018-03-20', 'Charlie', 1500, 55000, 'Jones', 1, 0, 'Assistant'),
                                                                                                                                                                     ('2017-04-25', 'David', 2500, 70000, 'Brown', 0, 1, 'Professor'),
                                                                                                                                                                     ('2016-05-30', 'Eve', 3000, 80000, 'Davis', 1, 0, 'Assistant');
go

select DepartmentID, DepartmentFinancing, DepartmentName from Departments;

select GroupName as [Group Name], GroupRating as [Group Rating] from Groups;

select TeacherSurname as [Last Name],
       (TeacherPremium / TeacherSalary) * 100 as [Rate Percentage],
       ((TeacherPremium + TeacherSalary) / TeacherSalary) * 100 as [Total Rate Percentage]
from Teachers;

select 'The dean of faculty ' + FacultyName + ' is ' + FacultyDean as [Faculty Info]
from Faculties;

select TeacherSurname from Teachers
where TeacherIsProfessor = 1 and TeacherSalary > 1050;

select DepartmentName from Departments
where DepartmentFinancing < 11000 or DepartmentFinancing > 25000;

select FacultyName from Faculties
where FacultyName != 'Engineering';

select TeacherSurname, TeacherPosition from Teachers
where TeacherIsAssistant = 1 and TeacherIsProfessor = 0;

select TeacherSurname, TeacherPosition, TeacherPremium from Teachers
where TeacherIsAssistant = 1 and TeacherPremium between 160 and 550;

select TeacherSurname, TeacherSalary from Teachers
where TeacherIsAssistant = 1;

select TeacherSurname, TeacherPosition from Teachers
where TeacherEmploymentDate < '01.01.2000';

select DepartmentName as [Name of Department] from Departments
where DepartmentName < 'Software Development';

select TeacherSurname from Teachers
where TeacherIsAssistant = 1 and Teachers.TeacherSalary + Teachers.TeacherPremium < 1200;

select GroupName from Groups
where GroupYear = 5 and GroupRating between 2 and 4;

select TeacherSurname from Teachers
where TeacherIsAssistant = 1 and TeacherSalary < 550 or TeacherPremium < 200;

drop database AcademyDB;