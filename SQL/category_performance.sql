

-- Q4: Calculates total orders, quantity, net sales, profit, and profit margin for each product category.


SELECT
    Category,

    COUNT(DISTINCT Order_Id) AS Total_Orders,

    SUM(Quantity) AS Total_Quantity,

    SUM(
        (CAST(List_price AS DECIMAL(18,2)) * Quantity)
        -
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            * Discount_Percent / 100.0
        )
    ) AS Net_Sales,

    SUM(
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            -
            (
                (CAST(List_price AS DECIMAL(18,2)) * Quantity)
                * Discount_Percent / 100.0
            )
        )
        -
        (CAST(cost_price AS DECIMAL(18,2)) * Quantity)
    ) AS Profit,

    SUM(
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            -
            (
                (CAST(List_price AS DECIMAL(18,2)) * Quantity)
                * Discount_Percent / 100.0
            )
        )
        -
        (CAST(cost_price AS DECIMAL(18,2)) * Quantity)
    )
    /
    NULLIF(
        SUM(
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            -
            (
                (CAST(List_price AS DECIMAL(18,2)) * Quantity)
                * Discount_Percent / 100.0
            )
        ),
        0
    ) * 100 AS Profit_Margin_Percent

FROM order_clean
GROUP BY Category
ORDER BY Net_Sales DESC;



/*
Q5: Sub-category Performance Calculates net sales, profit, and profit margin
for each sub-category and sorts them from highest to lowest net sales.

*/


SELECT
    Sub_Category,

    SUM(
        (CAST(List_price AS DECIMAL(18,2)) * Quantity)
        -
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            * Discount_Percent / 100.0
        )
    ) AS Net_Sales,

    SUM(
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            -
            (
                (CAST(List_price AS DECIMAL(18,2)) * Quantity)
                * Discount_Percent / 100.0
            )
        )
        -
        (CAST(cost_price AS DECIMAL(18,2)) * Quantity)
    ) AS Profit,

    SUM(
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            -
            (
                (CAST(List_price AS DECIMAL(18,2)) * Quantity)
                * Discount_Percent / 100.0
            )
        )
        -
        (CAST(cost_price AS DECIMAL(18,2)) * Quantity)
    )
    /
    NULLIF(
        SUM(
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            -
            (
                (CAST(List_price AS DECIMAL(18,2)) * Quantity)
                * Discount_Percent / 100.0
            )
        ),
        0
    ) * 100 AS Profit_Margin_Percent

FROM order_clean
GROUP BY Sub_Category
ORDER BY Net_Sales DESC;



-- Q6: Top 10 Products by Sales Identifies the top 10 products based on net sales and shows the quantity sold for each product.

SELECT TOP 10
    Product_Id,

    SUM(Quantity) AS Total_Quantity,

    SUM(
        (CAST(List_price AS DECIMAL(18,2)) * Quantity)
        -
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            * Discount_Percent / 100.0
        )
    ) AS Net_Sales

FROM order_clean
GROUP BY Product_Id
ORDER BY Net_Sales DESC;