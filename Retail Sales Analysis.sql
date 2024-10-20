-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;


-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );




-- How many sales we have?
select count(*)
from retail_sales

-- How many uniuque customers we have ?
select count(distinct(customer_id))
from retail_sales



select * from retail_sales
-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select *
from retail_sales
where sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select *
from retail_sales
where category = 'Clothing' 
	and sale_date between '2022-11-01' and '2022-11-30'
	and quantity >=4
	
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as total_sales
from retail_sales
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as avg_age
from retail_sales
where category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from retail_sales
where total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select  category, gender,count(transaction_id) as total_transactions
from retail_sales
group by category, gender
order by category

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select Year, Month, average_sales
from (
select 
	extract (year from sale_date) as Year,
	extract (month from sale_date) as Month,
	avg(total_sale) as average_sales,
	rank () over(partition by extract (year from sale_date) order by avg(total_sale) desc) as rank 
from retail_sales
group by Year, Month) x
where rank = 1		

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count(distinct(customer_id)) as customers
from retail_sales
group by category 

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


(
select *,
	case 
		when extract(hour from sale_time) <=12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as Shift 
from retail_sales)


	
	
	
	
	
	
	
	
