-- This is a SQL Project for Exploration of Data in the Store Database 

-- Creating a Database Store_Database_Project
CREATE DATABASE Store_Database_Project;

USE Store_Database_Project;

-- Creating tables and inserting values for the project
CREATE TABLE goldusers_signup (
    userid INTEGER,
    gold_signup_date DATE
);

INSERT INTO goldusers_signup (userid, gold_signup_date) 
VALUES 
    (1, '09-22-2017'),
    (3, '04-21-2017');

CREATE TABLE users (
    userid INTEGER,
    signup_date DATE
);

INSERT INTO users (userid, signup_date) 
VALUES 
    (1, '09-02-2014'),
    (2, '01-15-2015'),
    (3, '04-11-2014');

CREATE TABLE sales (
    userid INTEGER,
    created_date DATE,
    product_id INTEGER
);

INSERT INTO sales (userid, created_date, product_id) 
VALUES 
    (1, '04-19-2017', 2),
    (3, '12-18-2019', 1),
    (2, '07-20-2020', 3),
    (1, '10-23-2019', 2),
    (1, '03-19-2018', 3),
    (3, '12-20-2016', 2),
    (1, '11-09-2016', 1),
    (1, '05-20-2016', 3),
    (2, '09-24-2017', 1),
    (1, '03-11-2017', 2),
    (1, '03-11-2016', 1),
    (3, '11-10-2016', 1),
    (3, '12-07-2017', 2),
    (3, '12-15-2016', 2),
    (2, '11-08-2017', 2),
    (2, '09-10-2018', 3);

CREATE TABLE product (
    product_id INTEGER,
    product_name TEXT,
    price INTEGER
);

INSERT INTO product (product_id, product_name, price) 
VALUES
    (1, 'p1', 980),
    (2, 'p2', 870),
    (3, 'p3', 330);

-- Queries to retrieve data from the tables

-- 1. What is the total amount each customer has spent?
SELECT a.userid, SUM(b.price) AS Total_Spent 
FROM sales a 
INNER JOIN product b ON a.product_id = b.product_id
GROUP BY a.userid;

-- 2. How many days each customer has visited the store?
SELECT userid, COUNT(DISTINCT created_date) AS NoOf_Days
FROM sales
GROUP BY userid;

-- 3. What was the first product purchased by each customer?
SELECT * FROM (
    SELECT *, RANK() OVER(PARTITION BY userid ORDER BY created_date) AS rnk FROM sales
) a 
WHERE rnk = 1;

-- 4. What is the most purchased item on the menu?
SELECT product_id, COUNT(product_id) AS cnt 
FROM sales
GROUP BY product_id
ORDER BY COUNT(product_id) DESC;

-- 5. Which Product is the most popular for each customer?
SELECT * FROM (
    SELECT *, RANK() OVER(PARTITION BY userid ORDER BY cnt DESC) AS rnk 
    FROM (
        SELECT userid, product_id, COUNT(product_id) AS cnt
        FROM sales
        GROUP BY userid, product_id
    ) a
) b
WHERE rnk = 1;

-- Additional Queries

-- 6. How many customers signed up for the gold membership before the year 2016?
SELECT COUNT(DISTINCT userid) AS Num_Gold_Customers_Before_2016
FROM goldusers_signup
WHERE YEAR(gold_signup_date) < 2016;

-- 7. What is the average amount spent by each customer in the gold membership program? 
SELECT a.userid, AVG(b.price) AS Avg_Amount_Spent
FROM sales a
INNER JOIN product b ON a.product_id = b.product_id
INNER JOIN goldusers_signup c ON a.userid = c.userid
GROUP BY a.userid;

-- 8. List all customers who made purchases on or after '2023-01-01'.
SELECT DISTINCT a.userid
FROM users a
LEFT JOIN sales b ON a.userid = b.userid AND b.created_date >= '2023-01-01';

-- 9. List all products that have never been purchased by any customer.
SELECT product_id, product_name
FROM product
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM sales
);

-- 10. What is the total revenue generated from all sales?
SELECT SUM(price) AS Total_Revenue
FROM (
    SELECT s.product_id, p.price
    FROM sales s
    INNER JOIN product p ON s.product_id = p.product_id
) revenue;

