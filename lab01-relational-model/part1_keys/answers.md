\# Task 1.1: Superkey and Candidate Key Analysis



\## Relation A: Employee



\*\*Candidate keys:\*\* EmpID, SSN, Email



\*\*Primary key: EmpID\*\*

Chosen because it is immutable throughout an employee's time at the company

(unlike Email or SSN, which can change/expire), and unlike SSN, it is not

sensitive personal data that shouldn't be scattered across the system.



\*\*6 superkeys:\*\*

1\. {EmpID, Name}

2\. {EmpID, SSN}

3\. {SSN, Phone}

4\. {EmpID, Email}

5\. {SSN, Name}

6\. {SSN, Email}



\*\*Can two employees have the same phone number?\*\*

Yes. Unlike EmpID, SSN, or Email, Phone is not guaranteed to be unique — it

could represent a shared department line (e.g. HR or Support) or an office

landline used by multiple staff. In the sample data each employee has a

different number, but that's just a property of this dataset, not a

structural guarantee.



\## Relation B: Course Registration



\*\*Primary key:\*\* {StudentID, CourseCode, Section, Semester, Year}



\- StudentID — identifies whose registration it is

\- CourseCode — a student can register for many different courses

\- Section — per business rule 2, different sections of the same course

&#x20; in the same semester are distinct registrations

\- Semester + Year — per business rule 1, the same course can recur across

&#x20; different terms; Semester alone is ambiguous without Year



\*\*Additional candidate keys:\*\* None. Grade and Credits are not unique

identifiers (many students can share a grade or credit value).



\# Task 1.2: Foreign Key Design



| Table.Attribute | References |

|---|---|

| Student.AdvisorID | Professor.ProfID |

| Professor.Department | Department.DeptCode |

| Course.DepartmentCode | Department.DeptCode |

| Department.ChairID | Professor.ProfID |

| Enrollment.StudentID | Student.StudentID |

| Enrollment.CourseID | Course.CourseID |



Note: Professor and Department have a circular reference (Professor →

Department via Department, and Department → Professor via ChairID),

which is common in real schemas but requires care with FK constraint

ordering at creation time.

