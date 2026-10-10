
/*

Operations / MIS Reporting
-- Analyzes customer segment performance and shipping mode usage based on orders, quantity, sales, and profitability.

*/

-- Q13: Compares orders, quantity, net sales, profit,and profit margin across customer segments.

SELECT
    Segment,
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
GROUP BY Segment
ORDER BY Net_Sales DESC;



/*

Q14: Compares shipping modes based on total orders,quantity, and net sales to understand shipping mode usage.

*/

SELECT
    Ship_Mode,

    COUNT(DISTINCT Order_Id) AS Total_Orders,

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

GROUP BY Ship_Mode

ORDER BY Total_Orders DESC;