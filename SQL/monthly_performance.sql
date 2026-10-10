

-- Q2: Monthly Sales & Profit Performance


SELECT
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,

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
    ) AS Profit

FROM order_clean

GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date)

ORDER BY
    Order_Year,
    Order_Month;