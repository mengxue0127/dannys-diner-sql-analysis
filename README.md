# Danny's Diner SQL Analysis

## Project Overview

This project analyzes customer transactions, menu performance,
membership behavior, and loyalty points using MySQL.

The analysis is based on three relational tables: sales, menu,
and members.

## Business Questions

1. How much did each customer spend?
2. On average, how many times did a customer visit?
3. What was the first item purchased by each customer?
4. What was the most purchased menu item?
5. What was each customer's favorite product?
6. What was the first item purchased after becoming a member?
7. Which products were purchased before membership?
8. How many items did members purchase before joining,
   and how much did they spend?
9. How many standard loyalty points did each customer earn?
10. How many points did members earn by the end of January
    under the first-week promotion?

## Dataset

The project uses three tables:

- `sales`: customer purchases and order dates
- `menu`: product names and prices
- `members`: loyalty-program join dates

## SQL Skills Demonstrated

- INNER JOIN
- GROUP BY
- SUM and COUNT
- COUNT DISTINCT
- CASE expressions
- Common Table Expressions
- DENSE_RANK window functions
- Date calculations with DATE_ADD
- Conditional aggregation

## Key Findings

- Customer A spent the most overall: $76.
- Customer B visited most frequently.
- Ramen was the most purchased item, with 8 purchases.
- Customer B earned the most points under the standard system.
- Customer A benefited most from the first-week promotion.

## Files

- `dannys_diner_setup.sql`: database creation and sample data
- `dannys_diner_analysis.sql`: solutions to all 10 questions

## Tools

MySQL · MySQL Workbench
