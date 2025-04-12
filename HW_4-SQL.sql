create database AcademyDB;
go
use AcademyDB;
go

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
    DayOfWeek int check(DayOfWeek > 0 and DayOfWeek < 8) not null,
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
('Literature'),
('Computer Science');
go
insert into Faculties (FacultyName) values
('Engineering'),
('Science'),
('Arts'),
('Business'),
('Education'),
('Health');
go
insert into Departments (DepartmentFinancing, DepartmentName, FacultyID) values
(1000000, 'Computer Engineering', 1),
(2000000, 'Biological Sciences', 2),
(1500000, 'History and Culture', 3),
(1200000, 'Business Management', 4),
(1300000, 'Educational Studies', 5),
(1100000, 'Health Sciences', 6);
go
insert into Groups (GroupName, GroupYear, DepartmentID) values
('ENG1', 1, 1),
('BIO2', 2, 2),
('HIS3', 1, 3),
('BUS4', 4, 4),
('EDU5', 5, 5),
('HLS6', 4, 6),
('ENG7', 1, 1),
('BIO8', 2, 2),
('HIS9', 1, 3),
('BUS10', 4, 4),
('EDU11', 5, 5),
('HLS12', 5, 6);
go
insert into Teachers (TeacherName, TeacherSalary, TeacherSurname) values
('John', 50000, 'Doe'),
('Jane', 60000, 'Smith'),
('Emily', 55000, 'Johnson'),
('Michael', 70000, 'Brown'),
('Sarah', 65000, 'Davis');
go
insert into Lectures (DayOfWeek, LectureRoom, SubjectID, TeacherID) values
(1, 'Room 101', 1, 1),
(2, 'Room 105', 2, 2),
(3, 'Room 103', 3, 3),
(4, 'Room 104', 4, 4),
(5, 'Room 105', 5, 5),
(6, 'Room 201', 6, 1),
(7, 'Room 202', 7, 2),
(1, 'Room 203', 8, 3),
(2, 'Room 204', 1, 4),
(3, 'Room 201', 2, 5),
(4, 'Room 103', 3, 1),
(5, 'Room 102', 4, 2);
go
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


select count(TeacherID) as NumberOfTeachers
from Teachers
where TeacherID in (select TeacherID from Lectures where SubjectID in (select SubjectID from Subjects where SubjectName = 'Computer Engineering'));

select count(LectureID) as NumberOfLectures
from Lectures
where LectureID in (select LectureID from Lectures where TeacherID in (select TeacherID from Teachers where TeacherName = 'John' and TeacherSurname = 'Doe'));

select count(LectureID) as NumberOfLectures
from Lectures
where LectureRoom = 'Room 201';

select LectureRoom as RoomName, count(LectureID) as NumberOfLectures
from Lectures
group by LectureRoom;

select count(GroupID) as NumberOfStudents
from Groups
where GroupID in (select GroupID from GroupsLectures where LectureID in (select LectureID from Lectures where TeacherID in (select TeacherID from Teachers where TeacherName = 'Sarah' and TeacherSurname = 'Davis')));

select avg(TeacherSalary) as AverageSalary
from Teachers
where TeacherID in (select TeacherID from Lectures where SubjectID in (select SubjectID from Subjects where SubjectName = 'Engineering'));

select min(NumberOfStudents) as MinStudents, max(NumberOfStudents) as MaxStudents
from (select count(GroupID) as NumberOfStudents
      from Groups
      group by GroupID) as StudentCount;

select avg(DepartmentFinancing) as AverageFinancing
from Departments;

select TeacherName + ' ' + TeacherSurname as FullName, count(LectureID) as NumberOfLectures
from Teachers
         join Lectures on Teachers.TeacherID = Lectures.TeacherID
group by TeacherName, TeacherSurname;

select DayOfWeek, count(LectureID) as NumberOfLectures
from Lectures
group by DayOfWeek;

select LectureRoom as RoomName, count(DISTINCT Departments.DepartmentID) as NumberOfDepartments
from Lectures
         join GroupsLectures on Lectures.LectureID = GroupsLectures.LectureID
         join Groups on GroupsLectures.GroupID = Groups.GroupID
         join Departments on Groups.DepartmentID = Departments.DepartmentID
group by LectureRoom;

select FacultyName, count(Subjects.SubjectID) as NumberOfSubjects
from Faculties
         join Departments on Faculties.FacultyID = Departments.FacultyID
         join Groups on Departments.DepartmentID = Groups.DepartmentID
         join GroupsLectures on Groups.GroupID = GroupsLectures.GroupID
         join Lectures on GroupsLectures.LectureID = Lectures.LectureID
         join Subjects on Lectures.SubjectID = Subjects.SubjectID
group by FacultyName;

select TeacherName + ' ' + TeacherSurname as FullName, LectureRoom as RoomName, count(LectureID) as NumberOfLectures
from Teachers
         join Lectures on Teachers.TeacherID = Lectures.TeacherID
group by TeacherName, TeacherSurname, LectureRoom;


drop database AcademyDB;