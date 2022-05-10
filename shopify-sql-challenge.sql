-- (a) How many orders were shipped by Speedy Express in Total
SELECT count(*)
FROM Orders
JOIN Shippers
ON Shippers.ShipperID = Orders.ShipperID
WHERE Shippers.ShipperName = 'Speedy Express';

--Number of orders by Speedy Express: 54


-- (b) What is the last name of the employee with the most orders?

SELECT Employees.LastName, COUNT(*)
FROM Orders
JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Employees.LastName
ORDER BY count(*) DESC
LIMIT 1

-- Last name of the employee with the most orders: Peacock
-- Number of Orders: 40

-- (c) What product was ordered the most by customers in Germany?

SELECT Products.ProductName, SUM(Quantity) AS TotalQuantity
FROM Orders, OrderDetails, Customers, Products
WHERE Customers.Country = "Germany" AND OrderDetails.OrderID = Orders.OrderID AND OrderDetails.ProductID = Products.ProductID AND Customers.CustomerID = Orders.CustomerID
GROUP BY Products.ProductID
ORDER BY TotalQuantity DESC
LIMIT 1;

-- Product ordered the most by Germany: Boston Crab Meat
-- Total number of Orders: 160