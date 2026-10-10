

-- Customerc Analysis

/*

Q10: Identifies the top 10 customers by net sales and shows their location,
subscription status,total orders, and total quantity purchased.

*/

SELECT TOP 10
    c.Customer_ID,
    c.Location,
    c.Subscription_Status,

    COUNT(DISTINCT o.Order_Id) AS Total_Orders,
    SUM(o.Quantity) AS Total_Quantity,
    SUM(
        (CAST(o.List_price AS DECIMAL(18,2)) * o.Quantity)
        -
        (
            (CAST(o.List_price AS DECIMAL(18,2)) * o.Quantity)
            * o.Discount_Percent / 100.0
        )
    ) AS Net_Sales
FROM order_clean AS o
INNER JOIN customer_clean AS c
    ON o.Customer_ID = c.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Location,
    c.Subscription_Status
ORDER BY Net_Sales DESC;


/*

Q11: Compares subscribed and non-subscribed customers based on customer count, orders, quantity, net sales,
and average order value.

*/

SELECT
    c.Subscription_Status,
    COUNT(DISTINCT c.Customer_ID) AS Total_Customers,
    COUNT(DISTINCT o.Order_Id) AS Total_Orders,
    SUM(o.Quantity) AS Total_Quantity,
    SUM(
        (CAST(o.List_price AS DECIMAL(18,2)) * o.Quantity)
        -
        (
            (CAST(o.List_price AS DECIMAL(18,2)) * o.Quantity)
            * o.Discount_Percent / 100.0
        )
    ) AS Net_Sales,
    SUM(
        (CAST(o.List_price AS DECIMAL(18,2)) * o.Quantity)
        -
        (
            (CAST(o.List_price AS DECIMAL(18,2)) * o.Quantity)
            * o.Discount_Percent / 100.0
        )
    )
    /
    NULLIF(COUNT(DISTINCT o.Order_Id), 0) AS Average_Order_Value
FROM customer_clean AS c
INNER JOIN order_clean AS o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Subscription_Status
ORDER BY Net_Sales DESC;


/*

-- Q12: Groups customers by age range and calculates the number of customers and their average purchase amount
and average previous purchases.

*/

SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS Age_Group,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    AVG(Purchase_Amount_USD) AS Average_Purchase_Amount,
    AVG(Previous_Purchases) AS Average_Previous_Purchases
FROM customer_clean
GROUP BY
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END
ORDER BY
    Age_Group;


/* 

Q12B: Groups customers by purchase frequency and calculates customer count,
average purchase amount,and average previous purchases.

*/

SELECT
    Frequency_of_Purchases,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    AVG(Purchase_Amount_USD) AS Average_Purchase_Amount,
    AVG(Previous_Purchases) AS Average_Previous_Purchases
FROM customer_clean
GROUP BY
    Frequency_of_Purchases
ORDER BY
    Total_Customers DESC;



/*

-- Q12C: Groups customers by location and calculates the number of customers and their average purchase amount.

*/

SELECT
    Location,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    AVG(Purchase_Amount_USD) AS Average_Purchase_Amount,
    AVG(Previous_Purchases) AS Average_Previous_Purchases
FROM customer_clean
GROUP BY
    Location
ORDER BY
    Total_Customers DESC;