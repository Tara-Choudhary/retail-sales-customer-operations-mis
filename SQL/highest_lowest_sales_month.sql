

-- Q3: Highest and Lowest Sales Month

-- Highest Net Sales Month

-- Highest Net Sales Month

SELECT TOP 1
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,

    SUM(
        (CAST(List_price AS DECIMAL(18,2)) * Quantity)
        -
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            * Discount_Percent / 100.0
        )
    ) AS Net_Sales

FROM order_clean

GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date)


ORDER BY Net_Sales DESC;



-- Lowest Net Sales Month

SELECT TOP 1
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,

    SUM(
        (CAST(List_price AS DECIMAL(18,2)) * Quantity)
        -
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            * Discount_Percent / 100.0
        )
    ) AS Net_Sales

FROM order_clean

GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date)

ORDER BY Net_Sales ASC;