create database AcademyDB;
go
use AcademyDB;
go


create table Teachers
(
    TeacherID int primary key identity(1,1) not null,
    TeacherName nvarchar(max) check(TeacherName like '[A-Z]%') not null,
    TeacherSurname nvarchar(max) check(TeacherSurname like '[A-Z]%') not null,
);
create table Curators
(
    CuratorID int primary key identity(1,1) not null,
    TeacherID int not null foreign key references Teachers(TeacherID),
);
go
create table Assistants
(
    AssistantID int primary key identity(1,1) not null,
    TeacherID int not null foreign key references Teachers(TeacherID),
);
go
create table Heads
(
    HeadID int primary key identity(1,1) not null,
    TeacherID int not null foreign key references Teachers(TeacherID),
);
go
create table LectureRooms
(
    LectureRoomID int primary key identity(1,1) not null,
    LectureRoomBuilding int check(LectureRoomBuilding > 0 and LectureRoomBuilding < 6) not null,
    LectureRoomName nvarchar(10) check(LectureRoomName like '[A-Z]%') not null unique,
);
go
create table Subjects
(
    SubjectID int primary key identity(1,1) not null,
    SubjectName nvarchar(100) check(SubjectName like '[A-Z]%') not null unique,
);
go
create table Lectures
(
    LectureID int primary key identity(1,1) not null,
    SubjectID int not null foreign key references Subjects(SubjectID),
    TeacherID int not null foreign key references Teachers(TeacherID),
);
go
create table Schedules
(
    ScheduleID int primary key identity(1,1) not null,
    ScheduleClass int check(ScheduleClass > 0 and ScheduleClass < 9) not null,
    ScheduleDayOfWeek int check(ScheduleDayOfWeek > 0 and ScheduleDayOfWeek < 8) not null,
    ScheduleWeek int check(ScheduleWeek > 0 and ScheduleWeek < 53) not null,
    LectureRoomID int not null foreign key references LectureRooms(LectureRoomID),
    LectureID int not null foreign key references Lectures(LectureID),
);
go
create table Deans
(
    DeanID int primary key identity(1,1) not null,
    TeacherID int not null foreign key references Teachers(TeacherID),
);
go
create table Faculties
(
    FacultyID int primary key identity(1,1) not null,
    FacultyBuilding int check(FacultyBuilding > 0 and FacultyBuilding < 6) not null,
    FacultyName nvarchar(100) check(FacultyName like '[A-Z]%') not null unique,
    DeanID int not null foreign key references Deans(DeanID),
);
go
create table Departments
(
    DepartmentID int primary key identity(1,1) not null,
    DepartmentBuilding int check(DepartmentBuilding > 0 and DepartmentBuilding < 6) not null,
    DepartmentName nvarchar(100) check(DepartmentName like '[A-Z]%') not null unique,
    FacultyID int not null foreign key references Faculties(FacultyID),
    HeadID int not null foreign key references Heads(HeadID),
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
go
create table GroupsLectures
(
    GroupsLecturesID int primary key identity(1,1) not null,
    GroupID int not null foreign key references Groups(GroupID),
    LectureID int not null foreign key references Lectures(LectureID),
);
go

insert into Teachers(TeacherName, TeacherSurname) values
('John', 'Doe'),
('Jane', 'Smith'),
('Emily', 'Jones'),
('Michael', 'Brown'),
('Sarah', 'Davis'),
('David', 'Wilson'),
('Laura', 'Garcia'),
('James', 'Martinez'),
('Linda', 'Hernandez'),
('Robert', 'Lopez');
insert into Curators(TeacherID) values
                                    (1),
                                    (2),
                                    (3),
                                    (4),
                                    (5),
                                    (6),
                                    (7),
                                    (8),
                                    (9),
                                    (10);
insert into Assistants(TeacherID) values
                                      (1),
                                      (2),
                                      (3),
                                      (4),
                                      (5),
                                      (6),
                                      (7),
                                      (8),
                                      (9),
                                      (10);
insert into Heads(TeacherID) values
                                 (1),
                                 (2),
                                 (3),
                                 (4),
                                 (5),
                                 (6),
                                 (7),
                                 (8),
                                 (9),
                                 (10);
insert into Subjects(SubjectName) values
                                      ('Mathematics'),
                                      ('Physics'),
                                      ('Chemistry'),
                                      ('Biology'),
                                      ('History'),
                                      ('Geography'),
                                      ('Literature'),
                                      ('Computer Science'),
                                      ('Art'),
                                      ('Music');
insert into LectureRooms(LectureRoomBuilding, LectureRoomName) values
                                                                   (1, 'A310'),
                                                                   (2, 'B212'),
                                                                   (3, 'C113'),
                                                                   (4, 'D414'),
                                                                   (5, 'E515');
insert into Lectures(SubjectID, TeacherID) values
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
insert into Schedules(ScheduleClass, ScheduleDayOfWeek, ScheduleWeek, LectureRoomID, LectureID) values
                                                                                                    (1, 1, 1, 1, 1),
                                                                                                    (2, 2, 2, 2, 2),
                                                                                                    (3, 3, 3, 3, 3),
                                                                                                    (4, 4, 4, 4, 4),
                                                                                                    (5, 5, 5, 5, 5),
                                                                                                    (6, 6, 6, 1, 6),
                                                                                                    (7, 7, 7, 2, 7),
                                                                                                    (8, 2, 8, 3, 8),
                                                                                                    (1, 1, 1, 4, 9),
                                                                                                    (2, 2, 2, 5, 10);
insert into Deans(TeacherID) values
                                 (1),
                                 (2),
                                 (3),
                                 (4),
                                 (5),
                                 (6),
                                 (7),
                                 (8),
                                 (9),
                                 (10);
insert into Faculties(FacultyBuilding, FacultyName, DeanID) values
                                                                (1, 'Engineering', 1),
                                                                (2, 'Science', 2),
                                                                (3, 'Arts', 3),
                                                                (4, 'Business', 4),
                                                                (5, 'Education', 5);
insert into Departments(DepartmentBuilding, DepartmentName, FacultyID, HeadID) values
                                                                                   (1, 'Computer Engineering', 1, 1),
                                                                                   (2, 'Mechanical Engineering', 2, 2),
                                                                                   (3, 'Electrical Engineering', 3, 3),
                                                                                   (4, 'Civil Engineering', 4, 4),
                                                                                   (5, 'Chemical Engineering', 5, 5);
insert into Groups(GroupName, GroupYear, DepartmentID) values
                                                           ('F505', 1, 1),
                                                           ('F506', 2, 2),
                                                           ('F507', 3, 3),
                                                           ('F508', 4, 4),
                                                           ('F509', 5, 5),
                                                           ('F510', 1, 1),
                                                           ('F511', 2, 2),
                                                           ('F512', 3, 3),
                                                           ('F513', 4, 4),
                                                           ('F514', 5, 5);
insert into GroupsCurators(GroupID, CuratorID) values
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
insert into GroupsLectures(GroupID, LectureID) values
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



select LectureRoomName
from LectureRooms
where LectureRoomID in
      (
          select LectureRoomID
          from Schedules
          where LectureID in
                (
                    select LectureID
                    from Lectures
                    where TeacherID in
                          (
                              select TeacherID
                              from Teachers
                              where TeacherName = 'Linda' and TeacherSurname = 'Hernandez'
                          )
                )
      );

select TeacherSurname
from Teachers
where TeacherID in
      (
          select AssistantID
          from Assistants
          where AssistantID in
                (
                    select LectureID
                    from Lectures
                    where LectureID in
                          (
                              select LectureID
                              from GroupsLectures
                              where GroupID in
                                    (
                                        select GroupID
                                        from Groups
                                        where GroupName = 'F505'
                                    )
                          )
                )
      );

select SubjectName
from Subjects
where SubjectID in
      (
          select SubjectID
          from Lectures
          where TeacherID in
                (
                    select TeacherID
                    from Teachers
                    where TeacherName = 'Laura' and TeacherSurname = 'Garcia'
                )
      )
  and SubjectID in
      (
          select SubjectID
          from Groups
          where GroupYear = 5
      );

select TeacherSurname
from Teachers
where TeacherID not in
      (
          select TeacherID
          from Lectures
          where LectureID in
                (
                    select LectureID
                    from Schedules
                    where ScheduleDayOfWeek = 1
                )
      );

select LectureRoomName, LectureRoomBuilding
from LectureRooms
where LectureRoomID not in
      (
          select LectureRoomID
          from Schedules
          where ScheduleDayOfWeek = 3 and ScheduleWeek = 2 and ScheduleClass = 3
      );

select TeacherName + ' ' + TeacherSurname as FullName
from Teachers
where TeacherID in
      (
          select TeacherID
          from Teachers
          where TeacherID not in
                (
                    select CuratorID
                    from Curators
                    where CuratorID in
                          (
                              select CuratorID
                              from GroupsCurators
                              where GroupID in
                                    (
                                        select GroupID
                                        from Groups
                                        where DepartmentID in
                                              (
                                                  select DepartmentID
                                                  from Departments
                                                  where FacultyID in
                                                        (
                                                            select FacultyID
                                                            from Faculties
                                                            where FacultyName = 'Computer Science'
                                                        )
                                              )
                                    )
                          )
                )
      );

select distinct FacultyBuilding as Building
from Faculties
union
select distinct DepartmentBuilding as Building
from Departments
union
select distinct LectureRoomBuilding as Building
from LectureRooms;

select TeacherName + ' ' + TeacherSurname as FullName
from Teachers
where TeacherID in
      (
          select TeacherID
          from Deans
          union
          select TeacherID
          from Heads
          union
          select TeacherID
          from Curators
          union
          select TeacherID
          from Assistants
      )
order by TeacherName, TeacherSurname;

select distinct ScheduleDayOfWeek
from Schedules
where LectureRoomID in
      (
          select LectureRoomID
          from LectureRooms
          where LectureRoomName in ('A311', 'B212')
      )
order by ScheduleDayOfWeek;

drop database AcademyDB;