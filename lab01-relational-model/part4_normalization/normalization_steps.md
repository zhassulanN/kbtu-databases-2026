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

