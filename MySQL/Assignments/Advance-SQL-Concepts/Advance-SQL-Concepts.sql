-- TABLE CREATION & DATA INSERTION

CREATE TABLE employees(
employee_id INT,
name VARCHAR(50),
department VARCHAR(50),
salary INT,
hire_date DATE
);

INSERT INTO employees VALUES
(1,'Alice','HR',55000,'2020-01-15'),
(2,'Bob','HR',80000,'2019-05-16'),
(3,'Charlie','HR',70000,'2018-07-30'),
(4,'Dev','Finance',48000,'2021-01-10'),
(5,'Imran','IT',68000,'2017-12-25'),
(6,'Jack','Finance',60000,'2019-11-05'),
(7,'Jason','IT',45000,'2018-03-15'),
(8,'Kiara','IT',70000,'2022-06-18'),
(9,'Michael','IT',42000,'2019-05-20'),
(10,'Nalini','Finance',41500,'2021-08-24'),
(11,'Nandini','Finance',52000,'2017-03-25');

CREATE TABLE departments(
department_id INT,
department_name VARCHAR(50),
location VARCHAR(50)
);

INSERT INTO departments VALUES
(1,'HR','New York'),
(2,'IT','San Francisco'),
(3,'Finance','Chicago');


-- QUESTION 1: Write SQL window function syntax.

SELECT 
    column_name,
    window_function(expression) 
    OVER (
        [PARTITION BY partition_column]
        [ORDER BY order_column]
        [ROWS | RANGE BETWEEN frame_start AND frame_end]
    ) AS alias_name
FROM table_name;


-- QUESTION 2: Demonstrate FIRST_VALUE and LAST_VALUE.

SELECT 
    name,
    FIRST_VALUE(salary) OVER (ORDER BY salary DESC) AS highest_salary,
    LAST_VALUE(salary) OVER (
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS lowest_salary
FROM employees;


-- QUESTION 3: Assign unique rank using ROW_NUMBER()

SELECT *,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS rnk
FROM employees;

-- QUESTION 4: Department-wise salary rank.

SELECT *,
RANK() OVER (
    PARTITION BY department 
    ORDER BY salary DESC
) AS dept_rank
FROM employees;


-- QUESTION 5: Difference between RANK and DENSE_RANK.

SELECT *,
DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;


-- QUESTION 6: Running total of salaries.

SELECT *,
SUM(salary) OVER (
    ORDER BY hire_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_total
FROM employees;


-- QUESTION 7: Salary difference from department maximum.

SELECT *,
MAX(salary) OVER (PARTITION BY department) - salary AS diff
FROM employees;


-- QUESTION 8: 3-period moving average.

SELECT *,
AVG(salary) OVER (
    ORDER BY hire_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS moving_avg
FROM employees;


-- QUESTION 9: Cumulative salary distribution.

SELECT *,
CUME_DIST() OVER (ORDER BY salary) AS cum_dist
FROM employees;


-- QUESTION 10: Last hired employee per department

SELECT DISTINCT department,
LAST_VALUE(name) OVER (
    PARTITION BY department
    ORDER BY hire_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS last_hired
FROM employees;


-- QUESTION 11: Explain RANGE vs ROWS.

-- ROWS: Works on the physical number of rows
-- RANGE: Groups rows with equal ordering values

-- QUESTION 12: Employees earning above department average

SELECT *
FROM (
    SELECT *,
    AVG(salary) OVER (PARTITION BY department) AS avg_sal
    FROM employees
) t
WHERE salary > avg_sal;


-- QUESTION 13: Join departments and rank employees.

SELECT 
    e.*,
    d.location,
    RANK() OVER (
        PARTITION BY e.department 
        ORDER BY e.salary DESC
    ) AS dept_rank
FROM employees e
JOIN departments d
ON e.department = d.department_name;
