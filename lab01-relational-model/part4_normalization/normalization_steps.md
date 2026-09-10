\# Task 4.1: Denormalized Table Analysis



\## Table: StudentProject(StudentID, StudentName, StudentMajor, ProjectID,

\## ProjectTitle, ProjectType, SupervisorID, SupervisorName, SupervisorDept,

\## Role, HoursWorked, StartDate, EndDate)



\## 1. Functional Dependencies



StudentID → StudentName, StudentMajor

ProjectID → ProjectTitle, ProjectType, SupervisorID

SupervisorID → SupervisorName, SupervisorDept

{StudentID, ProjectID} → Role, HoursWorked, StartDate, EndDate



\## 2. Problems



\*\*Redundancy:\*\* StudentName/StudentMajor repeat once per project the student

is on; SupervisorName/SupervisorDept repeat once per project the supervisor

runs.



\*\*Update anomaly:\*\* If a student on 3 projects changes their major, all 3

rows must be updated. Updating only one row leaves the table in an

inconsistent state — conflicting majors for the same student.



\*\*Insert anomaly:\*\* A new student cannot be added until assigned to a

project, because ProjectID is part of the primary key {StudentID,

ProjectID}, and primary key attributes cannot be NULL.



\*\*Delete anomaly:\*\* If the last row referencing a given ProjectID is

deleted, all information about that project (title, type, supervisor) is

lost, even though the project could logically still exist.



\## 3. 1NF



No violations — every cell already holds a single atomic value; a student

in multiple projects is represented as multiple rows, not multiple values

in one cell.



\## 4. 2NF



Primary key: {StudentID, ProjectID}



Partial dependencies found:

\- StudentID → StudentName, StudentMajor

\- ProjectID → ProjectTitle, ProjectType, SupervisorID



2NF decomposition:



Student(StudentID, StudentName, StudentMajor)

Project(ProjectID, ProjectTitle, ProjectType, SupervisorID, SupervisorName, SupervisorDept)

StudentProject(StudentID, ProjectID, Role, HoursWorked, StartDate, EndDate)



\## 5. 3NF



Transitive dependency found: ProjectID → SupervisorID → SupervisorName, SupervisorDept



Final 3NF decomposition:



Student(StudentID, StudentName, StudentMajor)

Project(ProjectID, ProjectTitle, ProjectType, SupervisorID)

Supervisor(SupervisorID, SupervisorName, SupervisorDept)

StudentProject(StudentID, ProjectID, Role, HoursWorked, StartDate, EndDate)



Foreign keys:

\- Project.SupervisorID → Supervisor.SupervisorID

\- StudentProject.StudentID → Student.StudentID

\- StudentProject.ProjectID → Project.ProjectID







\# Task 4.2: Advanced Normalization



\## Table: CourseSchedule(StudentID, StudentMajor, CourseID, CourseName,

\## InstructorID, InstructorName, TimeSlot, Room, Building)



\## 1. Primary Key



{StudentID, CourseID, TimeSlot}



A course can have multiple sections (different instructor/time/room for

the same CourseID), so CourseID alone isn't enough. TimeSlot, combined

with CourseID, pins down one specific section.



\## 2. Functional Dependencies



StudentID → StudentMajor

CourseID → CourseName

InstructorID → InstructorName

{CourseID, TimeSlot} → InstructorID, Room

{TimeSlot, Room} → Building



\## 3. BCNF Check



None of the FDs have a superkey on the left side:

\- StudentID is not a superkey (missing CourseID, TimeSlot)

\- CourseID is not a superkey

\- InstructorID is not a superkey

\- {CourseID, TimeSlot} is not a superkey (missing StudentID)

\- {TimeSlot, Room} is not a superkey



All five FDs violate BCNF.



\## 4. BCNF Decomposition



Student(StudentID, StudentMajor)

Course(CourseID, CourseName)

Instructor(InstructorID, InstructorName)

RoomSchedule(TimeSlot, Room, Building)

SectionSchedule(CourseID, TimeSlot, InstructorID, Room)

Enrollment(StudentID, CourseID, TimeSlot)



Foreign keys:

\- SectionSchedule.InstructorID → Instructor.InstructorID

\- SectionSchedule.{TimeSlot, Room} → RoomSchedule.{TimeSlot, Room}

\- Enrollment.StudentID → Student.StudentID

\- Enrollment.{CourseID, TimeSlot} → SectionSchedule.{CourseID, TimeSlot}



\## 5. Potential Information Loss



No data is lost — the decomposition is lossless, since each step follows

a valid FD, so the original table can be reconstructed via joins without

producing spurious rows.



However, this is not fully dependency-preserving: verifying that a given

CourseID/TimeSlot maps to the correct Building now requires joining

SectionSchedule and RoomSchedule, rather than checking a single table

directly. This is a known trade-off of BCNF — it removes redundancy and

anomalies, but doesn't always keep every dependency checkable within one

table.

