
MySQL Project Queries - 


mysql> CREATE DATABASE walmart_db;

mysql> USE walmart_db;
Database changed

mysql> SHOW TABLES;


-- Count total records

mysql> SELECT COUNT(*) FROM walmart;


-- Name Distinct Payment Method

mysql> SELECT DISTINCT payment_method FROM walmart;


-- Count payment methods and number of transactions by payment method

mysql> SELECT payment_method, COUNT(*) FROM walmart GROUP BY payment_method;


-- Count distinct branches

mysql> SELECT COUNT(DISTINCT branch) FROM walmart;


-- Find the maximum and minimum quantity sold

mysql> SELECT MAX(quantity) FROM walmart;
mysql> SELECT MIN(quantity) FROM walmart;


SOME BUSSINESS PROBLEMS 
  

Q1: Find different payment methods, number of transactions, and quantity sold by payment method

mysql> SELECT payment_method, COUNT(*) as no_payments,SUM(quantity) as no_of_qty_sold FROM walmart GROUP BY payment_method;



Q2: Calculate the total quantity of items sold per payment method

mysql> SELECT payment_method, SUM(quantity) AS no_qty_sold FROM walmart GROUP BY payment_method;



Q3: Calculate the total profit for each category

mysql> SELECT category, SUM(unit_price * quantity * profit_margin) AS total_profit FROM walmart GROUP BY category ORDER BY total_profit DESC;



Q4: Identify the busiest day for each branch based on the number of transactions

mysql> SELECT Branch, day_name, no_transactions FROM ( SELECT Branch, DAYNAME(STR_TO_DATE(date, '%d/%m/%Y')) AS day_name, COUNT(*) AS no_transactions, RANK() OVER(PARTITION BY Branch ORDER BY COUNT(*) DESC) AS `rank` FROM walmart GROUP BY Branch, day_name) AS ranked WHERE `rank` = 1;



Q5 : Identify the highest-rated category in each branch
-- Display the branch, category, and avg rating

mysql> SELECT Branch, category, avg_rating FROM ( SELECT Branch , category, AVG(rating) AS avg_rating, RANK() OVER(PARTITION BY Branch ORDER BY AVG(rating) DESC) AS `rank` FROM walmart GROUP BY Branch, category ) AS ranked WHERE `rank` = 1;




Q6: Determine the average, minimum, and maximum rating of categories for each city

mysql> SELECT city, category, MIN(rating) AS min_rating, MAX(rating) AS max_rating, AVG(rating) AS avg_rating FROM walmart GROUP BY city, category;



Q7: Categorize sales into Morning, Afternoon, and Evening shifts


mysql> SELECT Branch, CASE WHEN HOUR(TIME(time)) < 12 THEN 'Morning' WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon' ELSE 'Evening' END AS shift, COUNT(*) AS num_invoices FROM walmart GROUP BY Branch, shift ORDER BY Branch, num_invoices DESC;



