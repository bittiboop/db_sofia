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
    FacultyFinancing money check(FacultyFinancing > 0) default 0 not null,
    FacultyName nvarchar(100) check(FacultyName like '[A-Z]%') not null unique,
);
go
create table Departments
(
    DepartmentID int primary key identity(1,1) not null,
    DepartmentFinancing money check(DepartmentFinancing > 0) default 0 not null,
    DepartmentName nvarchar(100) check(DepartmentName like '[A-Z]%') not null unique,
    FacultyID int not null foreign key references Faculties(FacultyID),
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
    TeacherName nvarchar(max) check(TeacherName like '[A-Z]%') not null,
    TeacherSalary money check(TeacherSalary > 0) not null,
    TeacherSurname nvarchar(max) check(TeacherSurname like '[A-Z]%') not null,
);
go
create table Lectures
(
    LectureID int primary key identity(1,1) not null,
    LectureRoom nvarchar(max) check(LectureRoom like '[A-Z]%') not null,
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

insert into Subjects (SubjectName) values
('Mathematics'),
('Physics'),
('Chemistry'),
('Biology'),
('History'),
('Geography'),
('English'),
('Ukrainian');
insert into Faculties (FacultyName, FacultyFinancing) values
                                                          ('Mathematics and Computer Science', 100000),
                                                          ('Physics and Technology', 200000),
                                                          ('Chemistry and Biology', 150000),
                                                          ('History and Geography', 120000),
                                                          ('Foreign Languages', 130000);
insert into Departments (DepartmentName, DepartmentFinancing, FacultyID) values
                                                                             ('Mathematics', 50000, 1),
                                                                             ('Computer Science', 30000, 1),
                                                                             ('Physics', 70000, 2),
                                                                             ('Technology', 80000, 2),
                                                                             ('Chemistry', 60000, 3),
                                                                             ('Biology', 40000, 3),
                                                                             ('History', 90000, 4),
                                                                             ('Geography', 100000, 4),
                                                                             ('English', 110000, 5),
                                                                             ('Ukrainian', 120000, 5);
insert into Groups (GroupName, GroupYear, DepartmentID) values
                                                            ('M-1', 1, 1),
                                                            ('M-2', 2, 1),
                                                            ('C-1', 1, 2),
                                                            ('C-2', 2, 2),
                                                            ('P-1', 1, 3),
                                                            ('P-2', 2, 3),
                                                            ('T-1', 1, 4),
                                                            ('T-2', 2, 4),
                                                            ('B-1', 1, 5),
                                                            ('B-2', 2, 5),
                                                            ('H-1', 1, 6),
                                                            ('H-2', 2, 6),
                                                            ('G-1', 1, 7),
                                                            ('G-2', 2, 7),
                                                            ('E-1', 1, 8),
                                                            ('E-2', 2, 8);
insert into Curators (CuratorName, CuratorSurname) values
                                                       ('John', 'Doe'),
                                                       ('Jane', 'Smith'),
                                                       ('Michael', 'Johnson'),
                                                       ('Emily', 'Davis'),
                                                       ('William', 'Brown');
insert into Teachers (TeacherName, TeacherSalary, TeacherSurname) values
                                                                      ('John', 50000, 'Doe'),
                                                                      ('Jane', 60000, 'Smith'),
                                                                      ('Emily', 55000, 'Johnson'),
                                                                      ('Michael', 70000, 'Brown'),
                                                                      ('Sarah', 65000, 'Davis');
insert into Lectures (LectureRoom, SubjectID, TeacherID) values
                                                             ('Room 101', 1, 1),
                                                             ('Room 105', 2, 2),
                                                             ('Room 103', 3, 3),
                                                             ('Room 104', 4, 4),
                                                             ('Room 105', 5, 5),
                                                             ('Room 201', 6, 1),
                                                             ('Room 202', 7, 2),
                                                             ('Room 203', 8, 3),
                                                             ('Room 204', 1, 4);
insert into GroupsCurators (GroupID, CuratorID) values
                                                    (1, 1),
                                                    (2, 2),
                                                    (3, 3),
                                                    (4, 4),
                                                    (5, 5),
                                                    (6, 1),
                                                    (7, 2),
                                                    (8, 3),
                                                    (9, 4),
                                                    (10, 5);
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
                                                    (10, 10),
                                                    (11, 11),
                                                    (12, 12);
go


select t.TeacherName, t.TeacherSurname, g.GroupName
from Teachers t
         cross join Groups g
order by t.TeacherName, t.TeacherSurname, g.GroupName;

select f.FacultyName
from Faculties f
where f.FacultyFinancing < (select sum(DepartmentFinancing) from Departments d where d.FacultyID = f.FacultyID)
group by f.FacultyName;

select c.CuratorSurname, g.GroupName
from Curators c
         join GroupsCurators gc on c.CuratorID = gc.CuratorID
         join Groups g on gc.GroupID = g.GroupID
order by c.CuratorSurname, g.GroupName;

select t.TeacherName, t.TeacherSurname
from Teachers t
         join Lectures l on t.TeacherID = l.TeacherID
         join GroupsLectures gl on l.LectureID = gl.LectureID
         join Groups g on gl.GroupID = g.GroupID
where g.GroupName = 'P-1'
order by t.TeacherName, t.TeacherSurname;

select t.TeacherSurname, f.FacultyName
from Teachers t
         join Lectures l on t.TeacherID = l.TeacherID
         join Subjects s on l.SubjectID = s.SubjectID
         join Departments d on s.SubjectID = d.DepartmentID
         join Faculties f on d.FacultyID = f.FacultyID
group by t.TeacherSurname, f.FacultyName

select d.DepartmentName, g.GroupName
from Departments d
         join Groups g on d.DepartmentID = g.DepartmentID
order by d.DepartmentName, g.GroupName;

select s.SubjectName
from Subjects s
         join Lectures l on s.SubjectID = l.SubjectID
         join Teachers t on l.TeacherID = t.TeacherID
where t.TeacherName = 'Emily' and t.TeacherSurname = 'Johnson'
group by s.SubjectName;

select d.DepartmentName
from Departments d
         join Subjects s on d.DepartmentID = s.SubjectID
where s.SubjectName = 'Ukrainian'
group by d.DepartmentName;

select g.GroupName
from Groups g
         join Departments d on g.DepartmentID = d.DepartmentID
         join Faculties f on d.FacultyID = f.FacultyID
where f.FacultyName = 'Computer Science'
group by g.GroupName;


select g.GroupName, f.FacultyName
from Groups g
         join Departments d on g.DepartmentID = d.DepartmentID
         join Faculties f on d.FacultyID = f.FacultyID
where g.GroupYear = 5
group by g.GroupName, f.FacultyName;

select t.TeacherName + ' ' + t.TeacherSurname as FullName, s.SubjectName, g.GroupName
from Teachers t
         join Lectures l on t.TeacherID = l.TeacherID
         join Subjects s on l.SubjectID = s.SubjectID
         join GroupsLectures gl on l.LectureID = gl.LectureID
         join Groups g on gl.GroupID = g.GroupID
where l.LectureRoom = 'Room 103'
order by t.TeacherName, t.TeacherSurname, s.SubjectName, g.GroupName;


drop database AcademyDB;