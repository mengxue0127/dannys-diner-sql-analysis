-- =====================================================
-- Danny's Diner SQL Project
-- Database setup and sample data
-- =====================================================

-- 1. 创建数据库
CREATE DATABASE IF NOT EXISTS dannys_diner;

-- 2. 进入这个数据库
USE dannys_diner;


-- =====================================================
-- Table 1: menu
-- 先创建 menu，因为 sales 的 product_id 会连接到它
-- =====================================================

CREATE TABLE menu (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(5, 2) NOT NULL
);


-- =====================================================
-- Table 2: members
-- =====================================================

CREATE TABLE members (
    customer_id CHAR(1) PRIMARY KEY,
    join_date DATE NOT NULL
);


-- =====================================================
-- Table 3: sales
-- =====================================================

CREATE TABLE sales (
    customer_id CHAR(1) NOT NULL,
    order_date DATE NOT NULL,
    product_id INT NOT NULL,

    CONSTRAINT fk_sales_menu
        FOREIGN KEY (product_id)
        REFERENCES menu(product_id)
);
INSERT INTO menu (
    product_id,
    product_name,
    price
)
VALUES
    (1, 'sushi', 10.00),
    (2, 'curry', 15.00),
    (3, 'ramen', 12.00);
    INSERT INTO members (
    customer_id,
    join_date
)
VALUES
    ('A', '2021-01-07'),
    ('B', '2021-01-09');
INSERT INTO sales (
    customer_id,
    order_date,
    product_id
)
VALUES
    ('A', '2021-01-01', 1),
    ('A', '2021-01-01', 2),
    ('A', '2021-01-07', 2),
    ('A', '2021-01-10', 3),
    ('A', '2021-01-11', 3),
    ('A', '2021-01-11', 3),

    ('B', '2021-01-01', 2),
    ('B', '2021-01-02', 2),
    ('B', '2021-01-04', 1),
    ('B', '2021-01-11', 1),
    ('B', '2021-01-16', 3),
    ('B', '2021-02-01', 3),

    ('C', '2021-01-01', 3),
    ('C', '2021-01-01', 3),
    ('C', '2021-01-07', 3);