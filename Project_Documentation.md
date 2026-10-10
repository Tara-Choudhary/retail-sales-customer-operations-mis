# Retail Sales & Customer Operations MIS Reporting System

**Tools:** Microsoft SQL Server (SSMS), Microsoft Excel\
**Project type:** MIS Reporting / Operations Analytics / Data Analysis\
**Analysis period:** January 2022 -- December 2023

## 1. Project Overview

This project demonstrates an end-to-end MIS reporting workflow using
retail order and customer data. Raw records are validated and cleaned in
SQL Server, business metrics are calculated, SQL analyses are performed,
and the reporting outputs are presented through an Excel MIS workbook
and management dashboard.

The project is designed to demonstrate practical skills relevant to
entry-level MIS Analyst, Reporting Analyst, and Data Analyst roles.

## 2. Business Objective

Create a consistent reporting layer that helps management review:

-   Sales, orders, and quantity trends
-   Category, sub-category, and product performance
-   Profitability and discount patterns
-   Customer and subscription characteristics
-   Customer-segment performance
-   Shipping-mode usage
-   Data-quality exceptions

## 3. Tools and Skills Demonstrated

-   **SQL Server / SSMS:** data validation, cleaning, joins,
    aggregation, grouping, sorting, conditional logic, calculations, and
    exception reporting
-   **Microsoft Excel:** reporting tables, KPI summary, pivot-based
    analysis, charts, year slicer, and management dashboard
-   **Data analysis:** KPI definitions, reconciliation, trend analysis,
    segmentation, and business interpretation

## 4. Dataset and Data Model

The project uses two source datasets loaded into SQL Server:

  ------------------------------------------------------------------------
  Table                                     Raw rows Description
  --------------------- ---------------------------- ---------------------
  `customer_raw`                               5,050 Customer attributes
                                                     such as age,
                                                     location,
                                                     subscription,
                                                     purchase amount,
                                                     review rating, and
                                                     purchase frequency

  `order_raw`                                  9,994 Order date, shipping
                                                     mode, segment,
                                                     category, product,
                                                     cost, list price,
                                                     quantity, discount,
                                                     and customer ID
  ------------------------------------------------------------------------

The cleaned reporting tables are `customer_clean` and `order_clean`.

### Data workflow

`Source CSVs → SQL raw tables → Data validation → Clean tables → Business analysis → Excel MIS workbook and dashboard`

Raw tables are preserved. Cleaning is performed in separate clean tables
so that the original imported records remain available for reference.

## 5. Data Validation and Cleaning

### Customer data

-   Identified 5,050 raw rows and 5,000 distinct customer IDs.
-   Investigated 50 customer IDs with duplicate rows; duplicate records
    were exact duplicates across customer attributes.
-   Removed duplicate copies in `customer_clean`, leaving 5,000 records.
-   Standardised `Fall` to `Autumn`.
-   Standardised `Every 3 Months` to `Quarterly`.
-   Standardised `Fortnightly` to `Bi-Weekly`.
-   Preserved unresolved missing values rather than filling them with
    guessed values.

Missing values remaining in the clean customer data:

  Field                  Missing records
  -------------------- -----------------
  Purchase amount                    558
  Size                               374
  Review rating                      600
  Discount applied                     2
  Previous purchases                 548

### Order data

-   Preserved all 9,994 order records.
-   Verified 9,994 distinct order IDs and no missing order IDs.
-   Order dates range from 2022-01-01 to 2023-12-31.
-   Quantity ranges from 1 to 14; no invalid quantities (`<= 0`) were
    found.
-   Discount values range from 2% to 5%, with no missing discount
    values.
-   Verified that all order customer IDs match a customer in the clean
    customer table.
-   Flagged 507 records where both `cost_price` and `List_price` are
    zero as `Zero Price`; these rows were retained rather than deleted.

### Data-quality treatment

The project preserves unresolved customer NULLs and flags zero-price
orders for investigation. The source data does not include delivery
dates or delivery durations, so delivery speed or SLA performance is not
measured.

## 6. KPI Definitions

  KPI                   Definition
  --------------------- ---------------------------------------------
  Total Orders          Count of order records / distinct order IDs
  Total Quantity        Sum of quantity
  Gross Sales           `List_price × Quantity`
  Discount Amount       `Gross Sales × Discount_Percent / 100`
  Net Sales             `Gross Sales − Discount Amount`
  Total Cost            `cost_price × Quantity`
  Profit                `Net Sales − Total Cost`
  Profit Margin         `Profit / Net Sales × 100`
  Average Order Value   `Net Sales / Total Orders`

SQL price calculations use decimal casting to support currency
calculations, and `NULLIF` is used where needed to avoid division by
zero.

**Important interpretation note:** "Profit" is a calculated metric based
on the supplied list price, discount percentage, and cost price. It
should not be interpreted as audited accounting profit.

## 7. Overall Results

  KPI                            Result
  --------------------- ---------------
  Total Orders                    9,994
  Total Quantity                 37,873
  Gross Sales             11,485,170.00
  Discount Amount            405,841.80
  Net Sales               11,079,328.20
  Total Cost              10,039,400.00
  Calculated Profit        1,039,928.20
  Profit Margin                 9.3862%
  Average Order Value          1,108.60

These figures are used as the baseline for reconciliation across
monthly, category, segment, and exception analyses.

## 8. SQL Business Analysis

The SQL work is organised into eight scripts covering 15 business
questions:

1.  Overall sales and order KPIs
2.  Monthly sales, quantity, and profit
3.  Highest- and lowest-sales months
4.  Category and sub-category performance
5.  Top 10 products by net sales
6.  Overall discount impact and discount-versus-margin analysis
7.  Customer analysis, subscription comparison, age groups, purchase
    frequency, and locations
8.  Segment performance, shipping-mode usage, and data-quality
    exceptions

The analysis uses SQL operations such as `SELECT`, `COUNT`, `SUM`,
`AVG`, `GROUP BY`, `ORDER BY`, `TOP`, `CASE`, `JOIN`, and calculated
fields.

## 9. Key Findings

-   The dataset contains 9,994 orders and 37,873 units.
-   Net sales are 11,079,328.20 and calculated profit is 1,039,928.20,
    giving a profit margin of approximately 9.39%.
-   February 2023 is the highest net-sales month at 731,638.80; June
    2023 is the lowest at 328,939.00.
-   Technology generated the highest net sales and calculated profit
    among the three categories.
-   Chairs generated the highest net sales among sub-categories.
    Fasteners had the lowest sub-category net sales and lowest profit
    margin.
-   Product `TEC-CO-10004722` ranked first by net sales in the top-10
    product analysis.
-   Profit margin was lower in the higher-discount groups in this
    dataset: 10.7149% at 2% discount and 7.8767% at 5% discount. This is
    an observed association, not proof of causation.
-   Customers with a subscription had a higher observed average order
    value among customers with orders; non-subscribed customers
    accounted for more orders and total net sales.
-   Consumer generated the highest segment net sales and calculated
    profit; Corporate had the highest segment profit margin.
-   Standard Class was the most-used shipping mode.
-   507 zero-price orders were retained and flagged as data-quality
    exceptions.

## 10. Reconciliation Checks

The SQL analyses were checked against the overall KPI baseline:

-   Monthly orders sum to 9,994 and monthly quantity sums to 37,873.
-   Category totals reconcile with the overall order, quantity, net
    sales, and profit totals.
-   Segment totals reconcile with the overall order, quantity, net
    sales, and profit totals.
-   Valid-price and zero-price records together account for all 9,994
    orders and 37,873 units.
-   Zero-price orders contribute zero to the calculated net sales and
    profit totals under the project's calculation definitions.

## 11. Excel MIS Workbook

The Excel workbook contains these reporting worksheets:

-   `Clean_Customers`
-   `Clean_Orders`
-   `SQL_Reporting_Data`
-   `KPI_Summary`
-   `Monthly_MIS`
-   `Sales_Performance`
-   `Location_Performance`
-   `Customer_Analysis`
-   `Exception_Report`
-   `Management_Dashboard`

The management dashboard includes seven KPI measures, four charts, and a
year slicer for applicable order-related reporting. The slicer has been
tested by the project author. The overall customer subscription profile
is based on all 5,000 customer records and is intentionally not filtered
by order year.

## 12. Limitations

-   The analysis is limited to the fields available in the source
    datasets.
-   The customer dataset contains missing values in several fields;
    unresolved values are retained as NULL.
-   Zero-price orders are flagged, but the source does not establish why
    both cost and list price are zero.
-   Shipping-mode usage is analysed, but delivery performance and SLA
    compliance cannot be calculated without delivery dates or duration
    data.
-   Observed relationships, including discount level versus profit
    margin and subscription versus average order value, do not prove
    causation.
-   The profit metric is derived from the available price and cost
    fields and is not a substitute for audited financial reporting.

## 13. Suggested Repository Contents

-   `README.md` --- concise project overview and navigation
-   `Project_Documentation.md` --- consolidated methodology, KPI
    definitions, findings, and limitations
-   `sql/` --- SQL scripts
-   `results/` --- exported query outputs
-   `Retail_MIS_Reporting.xlsx` --- final Excel MIS workbook and
    dashboard
-   `screenshots/` --- dashboard screenshot

## 14. Conclusion

This project demonstrates a practical reporting workflow from raw data
validation and cleaning through SQL business analysis and Excel-based
MIS reporting. It combines data-quality awareness, reproducible SQL
queries, KPI reconciliation, and a management-facing dashboard in one
portfolio project.
