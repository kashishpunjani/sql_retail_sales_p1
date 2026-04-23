-- SQL Retail Sales Analysis - P1
create database sql_project_p1;

-- create table
-- drop table if exists retail_sales;
create table retail_sales(
	transactions_id	int primary key,
	sale_date date,	
	sale_time time,
	customer_id	int,
	gender varchar(10),
	age	int,
	category varchar(20),
	quantiy	int,
	price_per_unit int,
	cogs Float,
	total_sale Float
);

SELECT * FROM retail_sales;

SELECT count(*) FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;
	
SELECT * FROM retail_sales
WHERE
	transactions_id	IS NULL 
	or
	sale_date IS NULL
	or
	sale_time IS NULL
	or 
	gender IS NULL
	or 
	category IS NULL
	or 
	quantiy IS NULL
	or 
	cogs IS NULL
	or 
	total_sale IS NULL;


Delete FROM retail_sales
WHERE
	transactions_id	IS NULL 
	or
	sale_date IS NULL
	or
	sale_time IS NULL
	or 
	gender IS NULL
	or 
	category IS NULL
	or 
	quantiy IS NULL
	or 
	cogs IS NULL
	or 
	total_sale IS NULL;

-- Data Exploration
-- How many sales we have?
SELECT count(*) as total_sale FROM retail_sales;

-- How many customers we have? 
SELECT COUNT(DISTINCT(customer_id)) FROM retail_sales;

-- Data Analysis & Business Key Problem & Answers
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05'

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_sales 
WHERE 
	category='Clothing' 
	and 
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	and
	quantiy >= 4
	
-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT 
	category, 
	sum(total_sale) as net_sales,
	count(*) as total_order
FROM retail_sales
GROUP BY 1;

-- 4. Write a SQL query to find the average age of customers who purchased items FROM the 'Beauty' category.:
SELECT category, round(avg(age)) FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;

-- 5. Write a SQL query to find all transactions WHERE the total_sale is greater than 1000.:
SELECT transactions_id, total_sale FROM retail_sales
WHERE total_sale > 1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category, gender, count(*) 
FROM retail_sales
group  by category, gender
ORDER BY 1;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT year, months,avg_sales FROM
(
SELECT 
	extract(Year FROM sale_date)  as year,
	extract(Month FROM sale_date)  as months,
	avg(total_sale) as avg_sales,
	RANK() OVER (PARTITION BY extract(Year FROM sale_date)  ORDER BY avg(total_sale) desc ) as rank
FROM retail_sales
GROUP BY year, months
) as t1
WHERE rank = 1;

-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT customer_id, sum(total_sale) as high_sale FROM retail_sales
GROUP BY customer_id
ORDER BY high_sale desc limit 5

-- 9. Write a SQL query to find the number of unique customers who purchased items FROM each category.:
SELECT 
	category, count(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
-- Morning <12, Afternoon Between 12 & 17, Evening >17
WITH hourly_sale
as
(
SELECT * , 
	case
		when extract(hour from sale_time) < 12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening' 
	end as shift
from retail_sales
order by sale_time
) 
select shift, count(*) as total_orders
from hourly_sale
group by shift;
