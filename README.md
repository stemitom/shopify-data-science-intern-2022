# Shopify Winter Data Science Challenge 2022

## Question 1

On Shopify, we have exactly 100 sneaker shops, and each of these shops sells only one model of shoe. We want to do some analysis of the average order value (AOV). When we look at orders data over a 30 day window, we naively calculate an AOV of $3145.13. Given that we know these shops are selling sneakers, a relatively affordable item, something seems wrong with our analysis.

1. Think about what could be going wrong with our calculation. Think about a better way to evaluate this data.
2. What metric would you report for this dataset?
3. What is its value?


## Answers

1. There are extreme outliers in this dataset. Observing these anomalies, we can deduct that a customer with id ```607``` spent 704,000 on 17 purchases each at the same store and using the same payment method, a credit card. This looks suspicious and should be further investigated.


   Evaluating this data in a better way can be done in two ways: 
   1. **Using a better metric**: Our current AOV metric, which is the mean is sensitive to outliers present in the dataset. We should employ a more robust statistic that will not deviate highly in the face of outliers. An example is the **median**

   2. **Removing the outliers before computing mean as our Average Order Value (AOV) metric**: The issue with removing outliers before computing our metric(mean/median) is that regardless of being outliers, our data points may be valid. Removing them could prevent extracting significant insights from our data.

   Generally, we need to know how the AOV applies to making decisions before coming up with a definite answer.

2.  **Median**. It is a better statistic as it is robust and suitable for data with outliers.

3. **The median value is 284.00**. This median (also known as the 50th percentile) can be seen in the table returned by ```data.describe()```.


## Question 2

For this question you’ll need to use SQL. Follow [this link](https://www.w3schools.com/SQL/TRYSQL.ASP?FILENAME=TRYSQL_SELECT_ALL) to access the data set required for the challenge. Please use queries to answer the following questions. Paste your queries along with your final numerical answers below.

## Answers

1. How many orders were shipped by Speedy Express in total?

    ```
    SELECT COUNT(*)
    FROM Orders
    JOIN Shippers
    ON Shippers.ShipperID = Orders.ShipperID
    WHERE Shippers.ShipperName = 'Speedy Express';
    ```

    54

2. What is the last name of the employee with the most orders?
   
    ```
    SELECT Employees.LastName, COUNT(*)
    FROM Orders
    JOIN Employees
    ON Orders.EmployeeID = Employees.EmployeeID
    GROUP BY Employees.LastName
    ORDER BY count(*) DESC
    LIMIT 1
    ```

    Peacock: 40

3. What product was ordered the most by customers in Germany?

    ```
    SELECT Products.ProductName, SUM(OrderDetails.Quantity) AS TotalOrderAmount
    FROM Products
    JOIN OrderDetails ON OrderDetails.ProductID = Products.ProductID
    JOIN Orders ON Orders.OrderID = OrderDetails.OrderID
    JOIN Customers ON Customers.CustomerID = Orders.CustomerID
    WHERE Customers.Country = "Germany"
    GROUP BY Products.ProductName
    ORDER BY SUM(OrderDetails.Quantity) DESC
    LIMIT 1;
    ```
    Boston Crab Meat: 160