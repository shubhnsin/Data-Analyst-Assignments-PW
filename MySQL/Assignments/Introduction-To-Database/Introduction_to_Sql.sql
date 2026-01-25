-- ============================================
-- Introduction to SQL and Databases
-- Database: MySQL
-- ============================================

-- ----------------------------
-- Task 1: Create Database
-- ----------------------------
CREATE DATABASE company_db;
USE company_db;

-- ----------------------------
-- Task 2: Create Employees Table
-- ----------------------------
CREATE TABLE employees (
    id INT PRIMARY KEY,              -- Unique employee ID
    first_name VARCHAR(50),           -- Employee first name
    last_name VARCHAR(50),            -- Employee last name
    department VARCHAR(50),           -- Department name
    salary INT                        -- Monthly salary
);

-- ----------------------------
-- Task 3: Insert Initial Records
-- ----------------------------
INSERT INTO employees VALUES
(1, 'John', 'Doe', 'Sales', 45000),
(2, 'Jane', 'Smith', 'HR', 52000),
(3, 'Amit', 'Sharma', 'IT', 65000),
(4, 'Neha', 'Verma', 'Sales', 58000),
(5, 'Rahul', 'Mehta', 'Finance', 60000);

-- ----------------------------
-- Task 4: Retrieve All Records
-- ----------------------------
SELECT * FROM employees;

-- ----------------------------
-- Filtering Using WHERE Clause
-- ----------------------------

-- Employees from Sales department
SELECT * FROM employees
WHERE department = 'Sales';

-- Employees with salary greater than 50000
SELECT * FROM employees
WHERE salary > 50000;

-- Sales employees earning more than 50000
SELECT * FROM employees
WHERE department = 'Sales'
AND salary > 50000;

-- Retrieve unique departments
SELECT DISTINCT department
FROM employees;

-- ----------------------------
-- Modifying Data
-- ----------------------------

-- Insert additional employees
INSERT INTO employees VALUES
(6, 'Karan', 'Patel', 'IT', 70000),
(7, 'Sneha', 'Iyer', 'HR', 48000),
(8, 'Vikas', 'Singh', 'Sales', 55000);

-- Update salary for employee with ID = 2
UPDATE employees
SET salary = 60000
WHERE id = 2;

-- Delete employee with ID = 1
DELETE FROM employees
WHERE id = 1;

-- Verify final data
SELECT * FROM employees;

-- ----------------------------
-- Using Constraints
-- ----------------------------

CREATE TABLE employees_v2 (
    id INT PRIMARY KEY,                   -- Unique ID
    name VARCHAR(50) NOT NULL,            -- Name is mandatory
    email VARCHAR(100) UNIQUE,            -- Email must be unique
    department VARCHAR(50) NOT NULL,      -- Department is mandatory
    salary INT CHECK (salary > 0)         -- Salary must be positive
);

-- Valid insert
INSERT INTO employees_v2 VALUES
(1, 'Rohit', 'rohit@gmail.com', 'IT', 60000);

-- Invalid insert (fails due to duplicate email)
INSERT INTO employees_v2 VALUES
(2, 'Rohit2', 'rohit@gmail.com', 'HR', 55000);

