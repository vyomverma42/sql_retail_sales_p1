-- SQL Retail Sales Analysis - P1
CREATE DATABASE project1;


-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retailsales
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

select * from retailsales;

select top 10*
from retailsales

-- data cleaning

select count(*) from retailsales
select * from retailsales
where transactions_id is null

select * from retailsales
where sale_date is null

select * from retailsales
where 
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 gender is null
	 or
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null



delete from retailsales
where
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 gender is null
	 or
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

select count(*) from retailsales

--Data Exploration--

--How many sales we have?
select count(*) as total_sale from retailsales

-- How many customers we have?
select count(customer_id) from retailsales
-- How many unique customers we have?
select distinct(count(customer_id)) from retailsales

-- How many categories we have?
select distinct category from retailsales

--Data analysis/ business analysis

--Q1. write a sql query to retrieve all columns for sales on'2022-11-05'

select *
from retailsales
where sale_date = '2022-11-05';

--Q2. write a sql query to retrieve all transactions where the category is 'clothing' and qty sold is more than 10 in Nov 2022.
s
elect 
  category,
  sum(quantiy)
  from retailsales
  where category = 'clothing' 
  and sale_date >= '2022-11-01'
  and sale_date < '2022-12-01'
  group by category

  select * from retailsales
  where category='clothing'
  and sale_date >= '2022-11-01'
  and sale_date < '2022-12-01'
  and quantiy >=4

--Q3. Write sql query to calculate total sales of each category.

select
category,
sum(total_sale) as netsale,
count(*) 
from retailsales
group by category

--Q4. write sql query to find avg age of customers who purchased items from 'beauty' category

select 
  avg(age)
  from retailsales
  where category = 'beauty'

--Q5. Write a sql query to find all transactions where the total saleis greater than 1000.

select * from retailsales
where total_sale >1000

--Q6. write sql query to find the total no. of transactions(transaction_id) made by each gender in each category.

select
  category,
  gender,
  count(*) as total_transactions
  from retailsales
  group 
  by 
  category,
  gender
  order by category

--Q7. write sql query to calculate average sale for each month. find out best selling month of each year.

select
   YEAR(sale_date) as saleyear,
   MONTH(sale_date)as salemonth,
   avg(total_sale),
   rank() over (partition by YEAR(sale_date) order by  avg(total_sale) desc) as ranked
   from retailsales
   group 
   by
   year(sale_date),
   MONTH(sale_date)
   

SELECT TOP 1 WITH TIES
    YEAR(sale_date) AS SaleYear,
    DATENAME(month, sale_date) AS BestSellingMonth,
    CAST(AVG(total_sale) AS DECIMAL(10,2)) AS AverageSale,
    CAST(SUM(total_sale) AS DECIMAL(10,2)) AS TotalSales
FROM retailsales
GROUP BY 
    YEAR(sale_date), 
    MONTH(sale_date), 
    DATENAME(month, sale_date)
ORDER BY 
    ROW_NUMBER() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(total_sale) DESC);

--Q.8 write a sql query to find the top 5 customers based on highest total sales

select top 5
  customer_id,
  sum(total_sale) as totalsale
  from retailsales
  group by customer_id
  order by sum(total_sale) desc

--Q.9 write a sql query to find the no. of unique customers who purchased items from each category.

select
  category,
  count(distinct customer_id)
  from retailsales
  group by category
  
--Q.10 write a sql query to create each shift and no. of orders (Example morning <=12, Afternoon between 12 and 17, Evening >17)

with hourly_sale
as
(
select *,
   case
       when datepart(hour, sale_time) <12 then 'Morninig'
	   when datepart(hour, sale_time) between 12 and 17  then 'Afternoon'
	   else 'Evening'
	   end as shift
from retailsales
)
select
shift,
count(*) as total_orders
from hourly_sale
group by shift

--End of Project--
