
-- Profitability Discount Analysis --


-- Q7: Calculates gross sales, total discount amount,net sales, and average discount percentage.

SELECT
    SUM(
        CAST(List_price AS DECIMAL(18,2)) * Quantity
    ) AS Gross_Sales,

    SUM(
        (CAST(List_price AS DECIMAL(18,2)) * Quantity)
        * Discount_Percent / 100.0
    ) AS Discount_Amount,

    SUM(
        (CAST(List_price AS DECIMAL(18,2)) * Quantity)
        -
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            * Discount_Percent / 100.0
        )
    ) AS Net_Sales,

    AVG(Discount_Percent) AS Average_Discount_Percent

FROM order_clean;


-- Q8: Compares orders, net sales, profit, and profit margin across different discount percentage levels.


SELECT
    Discount_Percent,

    COUNT(DISTINCT Order_Id) AS Total_Orders,

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
GROUP BY Discount_Percent
ORDER BY Discount_Percent;



-- Q9: Compares average discount, discount amount, net sales, profit, and profit margin across product categories.


SELECT
    Category,

    AVG(Discount_Percent) AS Average_Discount_Percent,

    SUM(
        (CAST(List_price AS DECIMAL(18,2)) * Quantity)
        * Discount_Percent / 100.0
    ) AS Discount_Amount,

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