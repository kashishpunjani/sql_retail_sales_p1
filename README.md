# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_p1;

CREATE TABLE retail_sales
(
	transactions_id	INT primary key,
	sale_date DATE,	
	sale_time TIME,
	customer_id	INT,
	gender VARCHAR(10),
	age	INT,
	category VARCHAR(20),
	quantity INT,
	price_per_unit INT,
	cogs Float,
	total_sale Float
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05:**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * FROM retail_sales 
WHERE 
	category='Clothing' 
	and 
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	and
	quantity >= 4
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
	category, 
	sum(total_sale) as net_sales,
	count(*) as total_order
FROM retail_sales
GROUP BY 1;
```

4. **Write a SQL query to find the average age of customers who purchased items FROM the 'Beauty' category.**:
```sql
SELECT
    round(avg(age)) as avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT transactions_id, total_sale FROM retail_sales
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT category, gender, count(*) as total_trans
FROM retail_sales
group  by category, gender
ORDER BY 1;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales.**:
```sql
SELECT customer_id, sum(total_sale) as high_sale FROM retail_sales
GROUP BY customer_id
ORDER BY high_sale desc limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
	category, count(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes 155 unique customers across different age groups, with sales distributed across major categories such as Clothing, Beauty, and Electronics.
- **High-Value Transactions**: Several transactions have a total sale amount greater than 1000, with some reaching up to 2000, indicating the presence of premium customers.
- **Sales Trends**: Monthly analysis shows variations in sales, with peak performance in different months across years, indicating seasonal demand patterns.
- **Customer Insights**: The analysis identifies top-spending customers, with the highest customer contributing around 38,440 in total sales, showing dependency on a small group of high-value buyers.

## Reports

- **Sales Summary**: detailed analysis of total sales shows that Electronics, Clothing, and Beauty categories contribute almost equally to overall revenue, with slight variation in order volume.
- **Trend Analysis**: Sales distribution across months and shifts shows that evening time has the highest order count (1062 orders), indicating peak shopping activity after working hours.
- **Customer Insights**: Unique customer analysis shows that Clothing has the highest number of customers (149), followed by Electronics and Beauty.

## Conclusion

This project provides a foundational understanding of SQL for retail data analysis. It demonstrates how raw transactional data can be transformed into meaningful business insights using aggregation, filtering, and analytical queries. The analysis helps understand customer behavior, sales performance, and category trends, which are essential for business decision-making.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `sql_retail_sales_p1.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `sql_retail_sales_p1.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Kashish Punjani

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Contact

For feedback, collaboration, or opportunities:

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/kashishpunjani/)
- **GitHub**: [github.com/kashishpunjani]
- **Email id : kashishpunjani8@gmail.com**

Thank you for your support, and I look forward to connecting with you!
