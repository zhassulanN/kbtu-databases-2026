-- Task 1
CREATE DATABASE advanced_lab;
\c advanced_lab

CREATE TABLE employees (
    emp_id     SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    department VARCHAR(50),
    salary     INTEGER,
    hire_date  DATE,
    status     VARCHAR(20) DEFAULT 'Active'
);

CREATE TABLE departments (
    dept_id    SERIAL PRIMARY KEY,
    dept_name  VARCHAR(50),
    budget     INTEGER,
    manager_id INTEGER
);

CREATE TABLE projects (
    project_id   SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id      INTEGER,
    start_date   DATE,
    end_date     DATE,
    budget       INTEGER
);

-- Task 2
INSERT INTO employees (emp_id, first_name, last_name, department)
VALUES (100, 'Zhassulan', 'Nugmanov',     'IT'),
       (101, 'Malik',     'Izimbergenov', 'Sales'),
       (102, 'Iska',      'Bogenbai',     'IT');

-- Task 3
INSERT INTO employees (emp_id, first_name, last_name, department, salary, status)
VALUES (103, 'Bekzat', 'Mufta', 'IT', DEFAULT, DEFAULT);

-- Task 4
INSERT INTO departments (dept_name, budget, manager_id)
VALUES ('IT',        150000, 1),
       ('Sales',      50000, 2),
       ('HR',         90000, 3),
       ('Marketing',  70000, NULL);

-- Task 5
INSERT INTO employees (first_name, last_name, department, hire_date, salary)
VALUES ('Alibi', 'Ayapbergenov', 'Sales', CURRENT_DATE, 50000 * 1.1);

-- Task 6
CREATE TEMP TABLE temp_employees (LIKE employees);

INSERT INTO temp_employees
SELECT * FROM employees WHERE department = 'IT';

-- Sample data
INSERT INTO employees (first_name, last_name, department, salary, hire_date, status)
VALUES ('Aigerim', 'Bekova',    'IT',    85000, '2018-03-15', 'Active'),
       ('Ruslan',  'Akhmetov',  'IT',    95000, '2019-07-01', 'Active'),
       ('Madina',  'Karimova',  'Sales', 48000, '2021-05-10', 'Active'),
       ('Yerlan',  'Sadykov',   'Sales', 52000, '2022-02-14', 'Active'),
       ('Asel',    'Nurlanova', 'HR',    45000, '2020-09-01', 'Inactive'),
       ('Nurlan',  'Tokayev',   'HR',    42000, '2021-11-20', 'Inactive'),
       ('Timur',   'Ospanov',   'HR',    38000, '2023-06-01', 'Terminated'),
       ('Kamila',  'Zhakupova', NULL,    35000, '2024-01-15', 'Active');

INSERT INTO projects (project_name, dept_id, start_date, end_date, budget)
VALUES ('Old CRM migration', 2, '2021-01-10', '2022-06-30', 30000),
       ('Website redesign',  1, '2023-03-01', '2024-12-31', 80000),
       ('New ERP system',    1, '2024-01-15', '2025-06-30', 120000),
       ('Hiring campaign',   3, '2024-02-01', '2024-08-31', 20000);

-- Task 7
UPDATE employees
SET salary = salary * 1.10;

-- Task 8
UPDATE employees
SET status = 'Senior'
WHERE salary > 60000
  AND hire_date < '2020-01-01';

-- Task 9
BEGIN;

UPDATE employees
SET department = CASE
                     WHEN salary > 80000                 THEN 'Management'
                     WHEN salary BETWEEN 50000 AND 80000 THEN 'Senior'
                     ELSE 'Junior'
                 END
RETURNING emp_id, first_name, salary, department;

ROLLBACK;

-- Task 10
UPDATE employees
SET department = DEFAULT
WHERE status = 'Inactive';

-- Task 11
UPDATE departments
SET budget = (SELECT AVG(salary) * 1.2
              FROM employees
              WHERE employees.department = departments.dept_name)
WHERE dept_name IN (SELECT department
                    FROM employees
                    WHERE salary IS NOT NULL);

-- Task 12
UPDATE employees
SET salary = salary * 1.15,
    status = 'Promoted'
WHERE department = 'Sales';

-- Task 13
DELETE FROM employees
WHERE status = 'Terminated';

-- Task 14
DELETE FROM employees
WHERE salary < 40000
  AND hire_date > '2023-01-01'
  AND department IS NULL;

-- Task 15
DELETE FROM departments
WHERE dept_name NOT IN (SELECT DISTINCT department
                        FROM employees
                        WHERE department IS NOT NULL);

-- Task 16
DELETE FROM projects
WHERE end_date < '2023-01-01'
RETURNING *;

-- Task 17
INSERT INTO employees (first_name, last_name, department, salary, hire_date)
VALUES ('Erlan', 'Kassymov', NULL, NULL, '2025-02-01');

-- Task 18
UPDATE employees
SET department = 'Unassigned'
WHERE department IS NULL;

-- Task 19
DELETE FROM employees
WHERE salary IS NULL
   OR department IS NULL;

-- Task 20
INSERT INTO employees (first_name, last_name, department, salary, hire_date)
VALUES ('Dana', 'Omarova', 'IT', 70000, '2024-09-01')
RETURNING emp_id, first_name || ' ' || last_name AS full_name;

-- Task 21
UPDATE employees
SET salary = salary + 5000
WHERE department = 'IT'
RETURNING emp_id,
          salary - 5000 AS old_salary,
          salary        AS new_salary;

-- Task 22
DELETE FROM employees
WHERE hire_date < '2020-01-01'
RETURNING *;

-- Task 23
INSERT INTO employees (first_name, last_name, department, salary, hire_date)
SELECT 'Arman', 'Seitkali', 'IT', 60000, '2025-03-10'
WHERE NOT EXISTS (SELECT 1
                  FROM employees
                  WHERE first_name = 'Arman'
                    AND last_name  = 'Seitkali');

-- Task 24
UPDATE employees
SET salary = CASE
                 WHEN (SELECT budget
                       FROM departments
                       WHERE departments.dept_name = employees.department) > 100000
                 THEN salary * 1.10
                 ELSE salary * 1.05
             END;

-- Task 25
INSERT INTO employees (first_name, last_name, department, salary, hire_date)
VALUES ('Aruzhan',  'Tulegenova', 'IT', 50000, '2025-06-01'),
       ('Daniyar',  'Kenzhebaev', 'IT', 52000, '2025-06-01'),
       ('Saule',    'Abenova',    'IT', 54000, '2025-06-01'),
       ('Miras',    'Zhanabaev',  'IT', 56000, '2025-06-01'),
       ('Togzhan',  'Baimukhan',  'IT', 58000, '2025-06-01');

UPDATE employees
SET salary = salary * 1.10
WHERE hire_date = '2025-06-01';

-- Task 26
CREATE TABLE employee_archive (LIKE employees);

INSERT INTO employee_archive
SELECT * FROM employees WHERE status = 'Inactive';

DELETE FROM employees
WHERE status = 'Inactive';

-- Task 27
UPDATE projects
SET end_date = end_date + INTERVAL '30 days'
WHERE budget > 50000
  AND dept_id IN (SELECT dept_id
                  FROM departments
                  WHERE dept_name IN (SELECT department
                                      FROM employees
                                      GROUP BY department
                                      HAVING COUNT(*) > 3))
RETURNING project_id, project_name, end_date;
