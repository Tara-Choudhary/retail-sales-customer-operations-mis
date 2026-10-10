


-- Q1: Overall Sales & Order KPIs

SELECT
    COUNT(DISTINCT Order_Id) AS Total_Orders,

    SUM(Quantity) AS Total_Quantity,

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

    SUM(
        CAST(cost_price AS DECIMAL(18,2)) * Quantity
    ) AS Total_Cost,

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
    ) * 100 AS Profit_Margin_Percent,

    SUM(
        (CAST(List_price AS DECIMAL(18,2)) * Quantity)
        -
        (
            (CAST(List_price AS DECIMAL(18,2)) * Quantity)
            * Discount_Percent / 100.0
        )
    )
    /
    NULLIF(COUNT(DISTINCT Order_Id), 0) AS Average_Order_Value

FROM order_clean;