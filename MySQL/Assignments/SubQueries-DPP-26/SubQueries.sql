-- QUESTION 1: Retrieve the names of employees who earn more than the average salary of all employees.

SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- QUESTION 2: Find the employees who belong to the department with the highest average salary.

SELECT *
FROM employees
WHERE dept_id = (
    SELECT dept_id
    FROM employees
    GROUP BY dept_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

-- QUESTION 3: List all employees who have made at least one sale.

SELECT DISTINCT e.*
FROM employees e
JOIN sales s ON e.emp_id = s.emp_id;

-- QUESTION 4: Find the employee with the highest sale amount.

SELECT *
FROM employees
WHERE emp_id = (
    SELECT emp_id
    FROM sales
    ORDER BY amount DESC
    LIMIT 1
);

-- QUESTION 5: Retrieve employees whose salaries are higher than Shubham's salary.

SELECT *
FROM employees
WHERE salary >
(SELECT salary FROM employees WHERE emp_name = 'Shubham');

-- QUESTION 6: Find employees who work in the same department as Abhishek.

SELECT *
FROM employees
WHERE dept_id =
(SELECT dept_id FROM employees WHERE emp_name = 'Abhishek');

-- QUESTION 7: List departments that have at least one employee earning more than 60000.

SELECT DISTINCT dept_name
FROM departments
WHERE dept_id IN (
    SELECT dept_id
    FROM employees
    WHERE salary > 60000
);

-- QUESTION 8: Find the department name of the employee who made the highest sale.

SELECT dept_name
FROM departments
WHERE dept_id = (
    SELECT dept_id
    FROM employees
    WHERE emp_id = (
        SELECT emp_id
        FROM sales
        ORDER BY amount DESC
        LIMIT 1
    )
);

-- QUESTION 9: Retrieve employees who have made sales greater than the average sale amount.

SELECT DISTINCT e.*
FROM employees e
JOIN sales s ON e.emp_id = s.emp_id
WHERE s.amount > (SELECT AVG(amount) FROM sales);

-- QUESTION 10: Find the total sales made by employees who earn more than the average salary.

SELECT SUM(amount)
FROM sales
WHERE emp_id IN (
    SELECT emp_id
    FROM employees
    WHERE salary > (SELECT AVG(salary) FROM employees)
);

-- QUESTION 11: Find employees who have not made any sales.

SELECT *
FROM employees
WHERE emp_id NOT IN (SELECT emp_id FROM sales);

-- QUESTION 12: List employees who work in departments where the average salary is above 55000.

SELECT *
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM employees
    GROUP BY dept_id
    HAVING AVG(salary) > 55000
);

-- QUESTION 13: Retrieve department names where the total sales exceed 10000.

SELECT dept_name
FROM departments
WHERE dept_id IN (
    SELECT dept_id
    FROM employees e
    JOIN sales s ON e.emp_id = s.emp_id
    GROUP BY dept_id
    HAVING SUM(amount) > 10000
);

-- QUESTION 14: Find the employee who has made the second-highest sale.

SELECT *
FROM employees
WHERE emp_id = (
    SELECT emp_id
    FROM sales
    ORDER BY amount DESC
    LIMIT 1 OFFSET 1
);

-- QUESTION 15: Retrieve employees whose salary is greater than the highest sales amount recorded.

SELECT *
FROM employees
WHERE salary > (SELECT MAX(amount) FROM sales);
