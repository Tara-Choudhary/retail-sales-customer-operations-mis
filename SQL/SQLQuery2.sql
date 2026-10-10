

---- Clearn record for Customer Table ----

SELECT DISTINCT
    Customer_ID,
    Age,
    Gender,
    Purchase_Amount_USD,
    Location,
    Size,
    Color,

    CASE
        WHEN Season = 'Fall' THEN 'Autumn'
        ELSE Season
    END AS Season,

    Review_Rating,
    Subscription_Status,
    Discount_Applied,
    Previous_Purchases,
    Payment_Method,

    CASE
        WHEN Frequency_of_Purchases = 'Every 3 Months'
            THEN 'Quarterly'
        WHEN Frequency_of_Purchases = 'Fortnightly'
            THEN 'Bi-Weekly'
        ELSE Frequency_of_Purchases
    END AS Frequency_of_Purchases

INTO customer_clean
FROM customer_raw;



---- Validate Query for new record ----

SELECT
    COUNT(*) AS Clean_Rows,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM customer_clean;



SELECT
    Customer_ID,
    COUNT(*) AS Records
FROM customer_clean
GROUP BY Customer_ID
HAVING COUNT(*) > 1;




--- Order table ----


SELECT
    Order_Id,
    Order_Date,
    Ship_Mode,
    Segment,
    Category,
    Sub_Category,
    Product_Id,
    cost_price,
    List_price,
    Quantity,
    Discount_Percent,
    Customer_ID,

    CASE
        WHEN cost_price = 0
         AND List_price = 0
            THEN 'Zero Price'
        ELSE 'Valid Price'
    END AS Price_Quality

INTO order_clean
FROM order_raw;



----

SELECT
    COUNT(*) AS Clean_Order_Rows,
    COUNT(DISTINCT Order_Id) AS Unique_Orders
FROM order_clean;


SELECT
    Price_Quality,
    COUNT(*) AS Records
FROM order_clean
GROUP BY Price_Quality;


--- relationship ---

SELECT
    COUNT(*) AS Orphan_Orders
FROM order_clean AS o
LEFT JOIN customer_clean AS c
    ON o.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;


SELECT
    COUNT(*) AS Joined_Rows
FROM order_clean AS o
INNER JOIN customer_clean AS c
    ON o.Customer_ID = c.Customer_ID;