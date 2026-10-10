

/*

Data Quality / Exception Analysis
-- Q15: Identifies zero-price orders and compares them with valid-price orders based on order count,
quantity,net sales, and profit.

*/

SELECT
    Price_Quality,
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
GROUP BY Price_Quality
ORDER BY Total_Orders DESC;