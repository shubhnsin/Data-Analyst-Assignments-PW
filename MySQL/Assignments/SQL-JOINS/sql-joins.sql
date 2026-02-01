-- Question 1 Retrieve all customers who have placed at least one order

SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;


-- Question 2 Retrieve all customers and their orders, including customers who have not placed any orders

SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate, o.Amount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;


-- Question 3 Retrieve all orders and their corresponding customers, including orders placed by unknown customers

SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate, o.Amount
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;


-- Question 4 Display all customers and orders, whether matched or not
  
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate, o.Amount
FROM Customers c
FULL OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID;


-- Question 5 Find customers who have not placed any orders
  
SELECT c.CustomerID, c.CustomerName, c.City
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- Question 6 Retrieve customers who made payments but did not place any orders

SELECT DISTINCT p.CustomerID
FROM Payments p
LEFT JOIN Orders o
ON p.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- Question 7 Generate all possible combinations between Customers and Orders

SELECT c.CustomerID, c.CustomerName, o.OrderID, o.Amount
FROM Customers c
CROSS JOIN Orders o;

-- Question 8 Show all customers along with order and payment amounts in one table
  
SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.Amount AS OrderAmount,
    p.PaymentID,
    p.Amount AS PaymentAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p
ON c.CustomerID = p.CustomerID;


-- Question 9 Retrieve all customers who have both placed orders and made payments

SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN Payments p ON c.CustomerID = p.CustomerID;
