Create Database Retail_MIS

Use Retail_MIS

Select count(*) As [Total Rows]
from dbo.customer_raw

select top 10 *
from customer_raw

select count(*) As [Total Rows]
from order_raw

select count(distinct order_id) As [distinct rows] from order_raw

select customer_id,count(distinct order_id) As [distinct rows]
from order_raw
GROUP BY customer_id
HAVING count(*) > 1

select count(*)
from order_raw
where order_id is NULL

select * from order_raw

select
count(order_date) AS [Date],
Min(order_date) As [earlist date],
Max(order_date) as [lastest date]
from order_raw

select
count(Quantity) AS [Total Quantity],
Min(Quantity) As [Minimum Quantity],
Max(Quantity) As [Maximum Quantity]
from order_raw


select
count(Quantity) AS [Invalid_Quantity]
from order_raw
where Quantity <= 0


select
count(*) AS [Null_Quantity]
from order_raw
where Quantity IS NULL

select * From order_raw

select
Min(cost_price) AS [lower Cost Price],
Min(List_price) AS [Lower List Price],
Max(cost_price) AS [Highest Cost Price],
Max(List_price) AS [Hoghest List Price]
From order_raw

select 
count(cost_price) AS [Invalide Cst]
from order_raw
where cost_price <= 0

select 
count(List_Price) AS [Invalide List price]
from order_raw
where List_Price <= 0

Select Order_Id,
Product_Id,
cost_price,
List_Price,
Quantity,
Discount_Percent
From order_raw
where cost_price <= 0 or List_Price <= 0

SELECT COUNT(*) AS [Null_Cost_Price]
FROM order_raw
WHERE cost_price IS NULL;

SELECT COUNT(*) AS [Null_List_Price]
FROM order_raw
WHERE List_Price IS NULL;

Select 
min(Discount_percent) AS [MIN Discount],
max(Discount_percent) AS [Max Discount]
from order_raw

SELECT COUNT(*) AS [Null_Discount_percent]
FROM order_raw
WHERE Discount_percent IS NULL;

Select count(*) AS [Null Cust ID]
from order_raw
where customer_ID is NULL

select Customer_ID from order_raw
select Customer_ID from customer_raw

select Count (O.Customer_ID)
from order_raw AS O
left join customer_raw AS C
ON O.Customer_ID = C.Customer_ID
where C.Customer_ID is NULL



Select Count(Customer_ID) AS [Number of Customer]
from customer_raw
Group by Customer_ID
Having count(*) > 1


SELECT COUNT(*) AS [Duplicated Customer IDs]
FROM (
    SELECT Customer_ID
    FROM customer_raw
    GROUP BY Customer_ID
    HAVING COUNT(*) > 1
) AS d;


SELECT
    Customer_ID,
    COUNT(*) AS [Number of Records]
FROM customer_raw
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

SELECT *
FROM customer_raw
WHERE Customer_ID = 172;

SELECT
    Customer_ID,
    Age,
    Gender,
    Purchase_Amount_USD,
    Location,
    Size,
    Color,
    Season,
    Review_Rating,
    Subscription_Status,
    Discount_Applied,
    Previous_Purchases,
    Payment_Method,
    Frequency_of_Purchases,
    COUNT(*) AS [Duplicate_Count]
FROM customer_raw
GROUP BY
    Customer_ID,
    Age,
    Gender,
    Purchase_Amount_USD,
    Location,
    Size,
    Color,
    Season,
    Review_Rating,
    Subscription_Status,
    Discount_Applied,
    Previous_Purchases,
    Payment_Method,
    Frequency_of_Purchases
HAVING COUNT(*) > 1;


SELECT COUNT(DISTINCT Customer_ID) AS [Unique Customers]
FROM customer_raw;


SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Null_Age,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Null_Gender,
    SUM(CASE WHEN Purchase_Amount_USD IS NULL THEN 1 ELSE 0 END) AS Null_Purchase_Amount,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS Null_Location,
    SUM(CASE WHEN Size IS NULL THEN 1 ELSE 0 END) AS Null_Size,
    SUM(CASE WHEN Color IS NULL THEN 1 ELSE 0 END) AS Null_Color,
    SUM(CASE WHEN Season IS NULL THEN 1 ELSE 0 END) AS Null_Season,
    SUM(CASE WHEN Review_Rating IS NULL THEN 1 ELSE 0 END) AS Null_Review_Rating,
    SUM(CASE WHEN Subscription_Status IS NULL THEN 1 ELSE 0 END) AS Null_Subscription_Status,
    SUM(CASE WHEN Discount_Applied IS NULL THEN 1 ELSE 0 END) AS Null_Discount_Applied,
    SUM(CASE WHEN Previous_Purchases IS NULL THEN 1 ELSE 0 END) AS Null_Previous_Purchases,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Null_Payment_Method,
    SUM(CASE WHEN Frequency_of_Purchases IS NULL THEN 1 ELSE 0 END) AS Null_Frequency
FROM customer_raw;


SELECT
    MIN(Age) AS Min_Age,
    MAX(Age) AS Max_Age
FROM customer_raw;


SELECT
    COUNT(*) AS Invalid_Age
FROM customer_raw
WHERE Age <= 0
   OR Age > 100;


SELECT
    MIN(Purchase_Amount_USD) AS Min_Purchase_Amount,
    MAX(Purchase_Amount_USD) AS Max_Purchase_Amount
FROM customer_raw;


SELECT
    COUNT(*) AS Invalid_Purchase_Amount
FROM customer_raw
WHERE Purchase_Amount_USD < 0;


SELECT
    Size,
    COUNT(*) AS Records
FROM customer_raw
GROUP BY Size
ORDER BY Records DESC;


SELECT
    Color,
    COUNT(*) AS Records
FROM customer_raw
GROUP BY Color
ORDER BY Records DESC;


SELECT
    Season,
    COUNT(*) AS Records
FROM customer_raw
GROUP BY Season
ORDER BY Records DESC;

SELECT
    MIN(Review_Rating) AS Min_Rating,
    MAX(Review_Rating) AS Max_Rating
FROM customer_raw;

SELECT
    COUNT(*) AS Invalid_Rating
FROM customer_raw
WHERE Review_Rating < 0
   OR Review_Rating > 5;


SELECT
    Subscription_Status,
    COUNT(*) AS Records
FROM customer_raw
GROUP BY Subscription_Status
ORDER BY Records DESC;



SELECT
    Discount_Applied,
    COUNT(*) AS Records
FROM customer_raw
GROUP BY Discount_Applied
ORDER BY Records DESC;


SELECT
    MIN(Previous_Purchases) AS Min_Previous_Purchases,
    MAX(Previous_Purchases) AS Max_Previous_Purchases
FROM customer_raw;

SELECT
    COUNT(*) AS Invalid_Previous_Purchases
FROM customer_raw
WHERE Previous_Purchases < 0;


SELECT
    Payment_Method,
    COUNT(*) AS Records
FROM customer_raw
GROUP BY Payment_Method
ORDER BY Records DESC;


SELECT
    Frequency_of_Purchases,
    COUNT(*) AS Records
FROM customer_raw
GROUP BY Frequency_of_Purchases
ORDER BY Records DESC;