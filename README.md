# Danny's Diner SQL Analysis

## Project Overview

This project analyzes customer transactions, menu performance, membership behavior, and loyalty-program outcomes using MySQL.

The analysis combines three relational tables—`sales`, `menu`, and `members`—to answer business questions related to customer spending, visit frequency, product preferences, membership behavior, and reward points.

## Project Context

This is a SQL case study based on the fictional Danny's Diner dataset.

The purpose of the project is to demonstrate how SQL can be used to transform transactional data into customer, product, and loyalty-program insights.

## Business Questions

1. How much did each customer spend?
2. On average, how many times did a customer visit the restaurant?
3. What was the first menu item purchased by each customer?
4. What was the most frequently purchased menu item?
5. What was each customer's most frequently purchased product?
6. What was the first item purchased after becoming a member?
7. Which products did each member purchase before joining?
8. How many items did members purchase before joining, and how much did they spend?
9. How many standard loyalty points did each customer earn?
10. How many points did members earn by the end of January under the first-week promotion?

## Dataset

The project uses three relational tables:

- `sales`: customer purchases, order dates, and product IDs
- `menu`: product names and prices
- `members`: loyalty-program enrollment dates

Each row in the `sales` table represents the purchase of one menu item.

## Analytical Approach

The analysis follows a reusable SQL framework:

**Connect → Calculate → Stage → Filter**

- **Connect:** Join tables to retrieve the required customer, product, price, and membership information.
- **Calculate:** Use aggregation, conditional logic, and window functions to generate metrics.
- **Stage:** Store intermediate results in CTEs or subqueries when they must be reused.
- **Filter:** Select the relevant dates, rankings, customer groups, or membership periods.

## SQL Skills Demonstrated

- `INNER JOIN`
- `GROUP BY`
- `SUM()` and `COUNT()`
- `COUNT(DISTINCT ...)`
- `CASE` expressions
- Common Table Expressions
- Subqueries
- `DENSE_RANK()` window functions
- Date calculations with `DATE_ADD()`
- Conditional aggregation
- Sorting with `ORDER BY`
- Returning top results with `LIMIT`

## Selected Results

### 1. Customer Spending

Customer A generated the highest total spending at **$76**, followed closely by Customer B at **$74**.

[View customer spending result](images/q1-customer-spending.png)

### 2. Most Popular Menu Item

Ramen was the most frequently purchased menu item, with **8 purchases** across all customers.

[View most popular menu item result](images/q4-most-popular-item.png)

### 3. Customer Product Preferences

Customer A and Customer C purchased ramen most frequently. Customer B purchased sushi, curry, and ramen equally often.

[View customer product preference result](images/q5-customer-favorites.png)

### 4. Loyalty-Program Promotion

Under the first-week double-points promotion, Customer A earned **1,370 points**, while Customer B earned **820 points** by the end of January.

[View loyalty-program result](images/q10-loyalty-points.png)

## Key Findings

- Customer A spent the most overall: **$76**.
- Customer B visited the restaurant most frequently.
- Ramen was the most purchased menu item, with **8 purchases**.
- Customer B earned the most points under the standard rewards system.
- Customer A benefited most from the first-week double-points promotion.
- Customer spending, visit frequency, and loyalty points produced different customer rankings, showing the importance of evaluating customer value through multiple metrics.

## Repository Structure

```text
dannys-diner-sql-analysis/
├── images/
│   ├── q1-customer-spending.png
│   ├── q4-most-popular-item.png
│   ├── q5-customer-favorites.png
│   └── q10-loyalty-points.png
├── dannys_diner_setup.sql
├── dannys_diner_analysis.sql
└── README.md
```

## Files

- [`dannys_diner_setup.sql`](dannys_diner_setup.sql): creates the database, tables, relationships, and sample data
- [`dannys_diner_analysis.sql`](dannys_diner_analysis.sql): contains the SQL solutions to all 10 business questions
- [`images`](images): contains representative query and result screenshots

## How to Run

1. Open MySQL Workbench.
2. Run `dannys_diner_setup.sql` to create the database and load the sample data.
3. Run `dannys_diner_analysis.sql` to execute the 10 analytical queries.
4. Review the outputs in the MySQL Workbench Result Grid.

## Tools

MySQL · MySQL Workbench · GitHub
