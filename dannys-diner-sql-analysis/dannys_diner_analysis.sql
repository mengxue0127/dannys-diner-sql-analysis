-- ============================================================
-- Danny's Diner SQL Analysis
-- Database: dannys_diner
-- Total Questions: 10
-- ============================================================

USE dannys_diner;


-- ============================================================
-- Question 1
-- How much did each customer spend at the restaurant?
--
-- Core structure:
-- JOIN + SUM() + GROUP BY
-- ============================================================

SELECT
    s.customer_id,
    SUM(m.price) AS total_spent
FROM sales AS s
JOIN menu AS m
    ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;


-- ============================================================
-- Question 2
-- On average, how many times did a customer visit
-- the restaurant?
--
-- One visit = one distinct order date.
--
-- First calculate each customer's number of visits,
-- then calculate the average of those visit counts.
--
-- Core structure:
-- GROUP BY + COUNT(DISTINCT) + outer AVG()
-- ============================================================

SELECT
    AVG(visit_count) AS average_visits
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_date) AS visit_count
    FROM sales
    GROUP BY customer_id
) AS customer_visits;


-- ============================================================
-- Question 3
-- What was the first menu item purchased by each customer?
--
-- DENSE_RANK() keeps all items purchased
-- on the same earliest date.
--
-- Core structure:
-- JOIN + DENSE_RANK() + CTE + outer WHERE rank = 1
-- ============================================================

WITH ranked_orders AS (
    SELECT
        s.customer_id,
        s.order_date,
        m.product_name,

        DENSE_RANK() OVER (
            PARTITION BY s.customer_id
            ORDER BY s.order_date
        ) AS order_rank

    FROM sales AS s
    JOIN menu AS m
        ON s.product_id = m.product_id
)

SELECT
    customer_id,
    product_name
FROM ranked_orders
WHERE order_rank = 1
ORDER BY customer_id, product_name;


-- ============================================================
-- Question 4
-- What was the most purchased menu item?
-- How many times was it purchased by all customers?
--
-- Core structure:
-- JOIN + GROUP BY + COUNT()
-- + ORDER BY DESC + LIMIT 1
-- ============================================================

SELECT
    m.product_name,
    COUNT(*) AS purchase_count
FROM sales AS s
JOIN menu AS m
    ON s.product_id = m.product_id
GROUP BY
    m.product_id,
    m.product_name
ORDER BY purchase_count DESC
LIMIT 1;


-- ============================================================
-- Question 5
-- What was each customer's most frequently purchased item?
--
-- DENSE_RANK() keeps all products tied for first place.
--
-- Core structure:
-- JOIN + GROUP BY + COUNT() + DENSE_RANK()
-- + CTE + outer WHERE rank = 1
-- ============================================================

WITH ranked_products AS (
    SELECT
        s.customer_id,
        m.product_name,
        COUNT(*) AS purchase_count,

        DENSE_RANK() OVER (
            PARTITION BY s.customer_id
            ORDER BY COUNT(*) DESC
        ) AS product_rank

    FROM sales AS s
    JOIN menu AS m
        ON s.product_id = m.product_id

    GROUP BY
        s.customer_id,
        m.product_id,
        m.product_name
)

SELECT
    customer_id,
    product_name,
    purchase_count
FROM ranked_products
WHERE product_rank = 1
ORDER BY customer_id, product_name;


-- ============================================================
-- Question 6
-- What was the first item purchased by each customer
-- after becoming a member?
--
-- The join date itself is included.
--
-- Core structure:
-- JOIN + WHERE membership date + DENSE_RANK()
-- + CTE + outer WHERE rank = 1
-- ============================================================

WITH member_orders AS (
    SELECT
        s.customer_id,
        s.order_date,
        m.product_name,

        DENSE_RANK() OVER (
            PARTITION BY s.customer_id
            ORDER BY s.order_date
        ) AS order_rank

    FROM sales AS s

    JOIN members AS mb
        ON s.customer_id = mb.customer_id

    JOIN menu AS m
        ON s.product_id = m.product_id

    WHERE s.order_date >= mb.join_date
)

SELECT
    customer_id,
    product_name
FROM member_orders
WHERE order_rank = 1
ORDER BY customer_id, product_name;


-- ============================================================
-- Question 7
-- Which different menu items did each member purchase
-- before becoming a member?
--
-- DISTINCT removes repeated customer-product combinations.
--
-- Core structure:
-- JOIN + WHERE before membership + DISTINCT
-- ============================================================

SELECT DISTINCT
    s.customer_id,
    m.product_name
FROM sales AS s

JOIN members AS mb
    ON s.customer_id = mb.customer_id

JOIN menu AS m
    ON s.product_id = m.product_id

WHERE s.order_date < mb.join_date
ORDER BY s.customer_id, m.product_name;


-- ============================================================
-- Question 8
-- Before becoming a member:
-- How many items did each member purchase?
-- How much did each member spend?
--
-- Core structure:
-- JOIN + WHERE before membership
-- + GROUP BY + COUNT(*) + SUM()
-- ============================================================

SELECT
    s.customer_id,
    COUNT(*) AS total_items,
    SUM(m.price) AS total_amount
FROM sales AS s

JOIN members AS mb
    ON s.customer_id = mb.customer_id

JOIN menu AS m
    ON s.product_id = m.product_id

WHERE s.order_date < mb.join_date

GROUP BY s.customer_id
ORDER BY s.customer_id;


-- ============================================================
-- Question 9
-- Customers earn 10 points for every $1 spent.
-- Sushi earns 2x points.
--
-- How many points did each customer earn?
--
-- Core structure:
-- JOIN + CASE + SUM() + GROUP BY
-- ============================================================

SELECT
    s.customer_id,

    SUM(
        CASE
            WHEN m.product_name = 'sushi'
                THEN m.price * 10 * 2
            ELSE m.price * 10
        END
    ) AS total_points

FROM sales AS s

JOIN menu AS m
    ON s.product_id = m.product_id

GROUP BY s.customer_id
ORDER BY s.customer_id;


-- ============================================================
-- Question 10
-- During the first 7 days after joining the program,
-- including the join date, all products earn 2x points.
--
-- Outside the first week, sushi still earns 2x points.
--
-- How many points did members A and B have
-- by the end of January?
--
-- Core structure:
-- JOIN + January filter + CASE + DATE_ADD()
-- + SUM() + GROUP BY
-- ============================================================

SELECT
    s.customer_id,

    SUM(
        CASE
            -- First membership week:
            -- join date through join date + 6 days
            WHEN s.order_date BETWEEN mb.join_date
                                  AND DATE_ADD(
                                      mb.join_date,
                                      INTERVAL 6 DAY
                                  )
                THEN m.price * 10 * 2

            -- Outside the first week,
            -- sushi still earns double points
            WHEN m.product_name = 'sushi'
                THEN m.price * 10 * 2

            -- All other purchases earn normal points
            ELSE m.price * 10
        END
    ) AS total_points

FROM sales AS s

JOIN members AS mb
    ON s.customer_id = mb.customer_id

JOIN menu AS m
    ON s.product_id = m.product_id

WHERE s.order_date < '2021-02-01'

GROUP BY s.customer_id
ORDER BY s.customer_id;