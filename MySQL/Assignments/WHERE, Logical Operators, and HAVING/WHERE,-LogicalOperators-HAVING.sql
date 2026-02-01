-- Q1) Find all transactions where the amount is greater than $1000

SELECT *
FROM transactions
WHERE amount > 1000;


-- Q2) Find all transactions in the Electronics category where the amount is more than $500

SELECT *
FROM transactions
WHERE category = 'Electronics'
  AND amount > 500;


-- Q3) Retrieve all transactions that occurred after March 1, 2024

SELECT *
FROM transactions
WHERE STR_TO_DATE(transaction_date, '%d-%m-%Y') > '2024-03-01';


-- Q4) Find transactions where amount is between $500 and $1000 AND category is Furniture

SELECT *
FROM transactions
WHERE amount BETWEEN 500 AND 1000
  AND category = 'Furniture';


-- Q5) Find transactions with missing payment methods

SELECT *
FROM transactions
WHERE payment_method IS NULL;


-- Q6) Retrieve all transactions sorted by amount in descending order

SELECT *
FROM transactions
ORDER BY amount DESC;


-- Q7) Find the number of transactions in each category


SELECT category, COUNT(*) AS total_transactions
FROM transactions
GROUP BY category;


-- Q8) Retrieve categories that have more than 3 transactions

SELECT category, COUNT(*) AS total_transactions
FROM transactions
GROUP BY category
HAVING COUNT(*) > 3;


-- Q9) Calculate total sales per region where total sales exceed $3000

SELECT region, SUM(amount) AS total_sales
FROM transactions
GROUP BY region
HAVING SUM(amount) > 3000;


-- Q10) Find regions where the average transaction amount is greater than $800,
-- but only for categories having more than 3 transactions

SELECT region, AVG(amount) AS avg_transaction_amount
FROM transactions
WHERE category IN (
    SELECT category
    FROM transactions
    GROUP BY category
    HAVING COUNT(*) > 3
)
GROUP BY region
HAVING AVG(amount) > 800;
