create database AcademyDB;
go
use AcademyDB;
go

create table Curators
(
    CuratorID int primary key identity(1,1) not null,
    CuratorName nvarchar(max) check(CuratorName like '[A-Z]%') not null,
    CuratorSurname nvarchar(max) check(CuratorSurname like '[A-Z]%') not null,
);
create table Subjects
(
    SubjectID int primary key identity(1,1) not null,
    SubjectName nvarchar(100) check(SubjectName like '[A-Z]%') not null unique,
);
go
create table Faculties
(
    FacultyID int primary key identity(1,1) not null,
    FacultyName nvarchar(100) check(FacultyName like '[A-Z]%') not null unique,
);
go
create table Students
(
    StudentID int primary key identity(1,1) not null,
    StudentName nvarchar(max) check(StudentName like '[A-Z]%') not null,
    StudentRating int check(StudentRating > 0 and StudentRating < 6) not null,
    StudentSurname nvarchar(max) check(StudentSurname like '[A-Z]%') not null,
);
go
create table Departments
(
    DepartmentID int primary key identity(1,1) not null,
    DepartmentBuilding int check(DepartmentBuilding > 0 and DepartmentBuilding < 6) not null,
    DepartmentFinancing money check(DepartmentFinancing > 0) default 0 not null,
    DepartmentName nvarchar(100) check(DepartmentName like '[A-Z]%') not null unique,
);
go
create table Groups
(
    GroupID int primary key identity(1,1) not null,
    GroupName nvarchar(10) check(GroupName like '[A-Z]%') not null unique,
    GroupYear int check(GroupYear > 0 and GroupYear < 6) not null,
    DepartmentID int not null foreign key references Departments(DepartmentID),
);
go
create table GroupsCurators
(
    GroupsCuratorsID int primary key identity(1,1) not null,
    GroupID int not null foreign key references Groups(GroupID),
    CuratorID int not null foreign key references Curators(CuratorID),
);
create table Teachers
(
    TeacherID int primary key identity(1,1) not null,
    TeacherISProfessor bit check(TeacherISProfessor = 0 or TeacherISProfessor = 1) not null,
    TeacherName nvarchar(max) check(TeacherName like '[A-Z]%') not null,
    TeacherSalary money check(TeacherSalary > 0 and TeacherSalary != 0) not null,
    TeacherSurname nvarchar(max) check(TeacherSurname like '[A-Z]%') not null,
);
go
create table Lectures
(
    LectureID int primary key identity(1,1) not null,
    LectureDate date check(LectureDate < '2025-04-19') not null,
    SubjectID int not null foreign key references Subjects(SubjectID),
    TeacherID int not null foreign key references Teachers(TeacherID),
);
go
create table GroupsLectures
(
    GroupsLecturesID int primary key identity(1,1) not null,
    GroupID int not null foreign key references Groups(GroupID),
    LectureID int not null foreign key references Lectures(LectureID),
);
go
create table GroupsStudents
(
    GroupsStudentsID int primary key identity(1,1) not null,
    GroupID int not null foreign key references Groups(GroupID),
    StudentID int not null foreign key references Students(StudentID),
);
go

insert into Curators (CuratorName, CuratorSurname) values
('John', 'Doe'),
('Jane', 'Smith'),
('Alice', 'Johnson'),
('Bob', 'Brown'),
('Charlie', 'Davis'),
('Diana', 'Wilson'),
('Ethan', 'Garcia'),
('Fiona', 'Martinez'),
('George', 'Lopez'),
('Hannah', 'Gonzalez');
insert into Students (StudentName, StudentRating, StudentSurname) values
                                                                      ('Michael', 4, 'Smith'),
                                                                      ('Sarah', 5, 'Johnson'),
                                                                      ('David', 3, 'Brown'),
                                                                      ('Emma', 4, 'Davis'),
                                                                      ('Olivia', 2, 'Wilson'),
                                                                      ('Liam', 5, 'Garcia'),
                                                                      ('Sophia', 3, 'Martinez'),
                                                                      ('James', 4, 'Lopez'),
                                                                      ('Isabella', 5, 'Gonzalez'),
                                                                      ('Benjamin', 2, 'Miller');
insert into Subjects (SubjectName) values
                                       ('Mathematics'),
                                       ('Physics'),
                                       ('Chemistry'),
                                       ('Biology'),
                                       ('History'),
                                       ('Geography'),
                                       ('Computer Science'),
                                       ('English Literature'),
                                       ('Philosophy'),
                                       ('Art History');
insert into Faculties (FacultyName) values
                                        ('Faculty of Science'),
                                        ('Faculty of Arts'),
                                        ('Faculty of Engineering'),
                                        ('Faculty of Medicine'),
                                        ('Faculty of Business'),
                                        ('Faculty of Education'),
                                        ('Faculty of Law'),
                                        ('Faculty of Social Sciences'),
                                        ('Faculty of Music'),
                                        ('Faculty of Architecture');
insert into Departments (DepartmentBuilding, DepartmentFinancing, DepartmentName) values
                                                                                      (1, 100000, 'Department of Mathematics'),
                                                                                      (2, 200000, 'Department of Physics'),
                                                                                      (3, 300000, 'Department of Chemistry'),
                                                                                      (4, 400000, 'Department of Biology'),
                                                                                      (5, 500000, 'Department of History'),
                                                                                      (1, 600000, 'Department of Geography'),
                                                                                      (2, 700000, 'Department of Computer Science'),
                                                                                      (3, 800000, 'Department of English Literature'),
                                                                                      (4, 900000, 'Department of Philosophy'),
                                                                                      (5, 1000000, 'Department of Art History');
insert into Groups (GroupName, GroupYear, DepartmentID) values
                                                            ('CS101', 1, 1),
                                                            ('CS102', 2, 2),
                                                            ('CS103', 3, 3),
                                                            ('CS104', 4, 4),
                                                            ('CS105', 5, 5),
                                                            ('CS106', 1, 6),
                                                            ('CS107', 2, 7),
                                                            ('CS108', 3, 8),
                                                            ('CS109', 4, 9),
                                                            ('CS110', 5, 10);
insert into GroupsCurators (GroupID, CuratorID) values
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
insert into Teachers (TeacherISProfessor, TeacherName, TeacherSalary, TeacherSurname) values
                                                                                          (1, 'Dr. Alice', 80000, 'Johnson'),
                                                                                          (0, 'Mr. Bob', 60000, 'Brown'),
                                                                                          (1, 'Prof. Charlie', 90000, 'Davis'),
                                                                                          (0, 'Ms. Diana', 70000, 'Wilson'),
                                                                                          (1, 'Dr. Ethan', 85000, 'Garcia'),
                                                                                          (0, 'Ms. Fiona', 65000, 'Martinez'),
                                                                                          (1, 'Prof. George', 95000, 'Lopez'),
                                                                                          (0, 'Ms. Hannah', 75000, 'Gonzalez'),
                                                                                          (1, 'Dr. Ian', 82000, 'Miller'),
                                                                                          (0, 'Ms. Jane', 68000, 'Taylor');
insert into Lectures (LectureDate, SubjectID, TeacherID) values
                                                             ('2023-10-01', 1, 1),
                                                             ('2023-10-02', 2, 2),
                                                             ('2023-10-03', 3, 3),
                                                             ('2023-10-04', 4, 4),
                                                             ('2023-10-05', 5, 5),
                                                             ('2023-10-06', 6, 6),
                                                             ('2023-10-07', 7, 7),
                                                             ('2023-10-08', 8, 8),
                                                             ('2023-10-09', 9, 9),
                                                             ('2023-10-10', 10, 10);
insert into GroupsLectures (GroupID, LectureID) values
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
insert into GroupsStudents (GroupID, StudentID) values
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

select DepartmentBuilding
from Departments
group by DepartmentBuilding
having sum(DepartmentFinancing) > 100000;


select GroupName
from Groups
where GroupYear = 5 and DepartmentID = (select DepartmentID from Departments where DepartmentName = 'Department of Computer Science')
  and GroupID in (select GroupID from GroupsLectures where LectureID in (select LectureID from Lectures where LectureDate between '2023-10-01' and '2023-10-07'))


select GroupName
from Groups
where GroupID in (select GroupID from GroupsStudents group by GroupID having avg(StudentRating) > (select avg(StudentRating) from Students where StudentID in (select StudentID from GroupsStudents where GroupID = (select GroupID from Groups where GroupName = 'CS107'))))


select TeacherSurname, TeacherName
from Teachers
where TeacherSalary > (select avg(TeacherSalary) from Teachers where TeacherISProfessor = 1);


select GroupName
from Groups
where GroupID in (select GroupID from GroupsCurators group by GroupID having count(CuratorID) > 1);


select GroupName
from Groups
where GroupID in (select GroupID from GroupsStudents group by GroupID having avg(StudentRating) < (select min(avg(StudentRating)) from GroupsStudents group by GroupID where GroupID in (select GroupID from Groups where GroupYear = 5)));


select FacultyName
from Faculties
where FacultyID in (select FacultyID from Departments group by FacultyID having sum(DepartmentFinancing) > (select sum(DepartmentFinancing) from Departments where FacultyID = (select FacultyID from Faculties where FacultyName = 'Faculty of Engineering')));

drop database AcademyDB;