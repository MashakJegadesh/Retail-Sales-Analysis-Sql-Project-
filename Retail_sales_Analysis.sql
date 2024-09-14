
Select * from   [dbo].[SQL - Retail Sales Analysis_utf ]


select count(*)  from  [dbo].[SQL - Retail Sales Analysis_utf ]


----Checking Null Values---
delete  from  [dbo].[SQL - Retail Sales Analysis_utf ]
  where transactions_id is null
  or
  sale_date is null
  or
  sale_time is null
  or 
  customer_id is null
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

  select count(*) from [dbo].[SQL - Retail Sales Analysis_utf ]

  ---Data Exploration----

  --1.How many records we have??

  select count(*) from [dbo].[SQL - Retail Sales Analysis_utf ]


  --2.how many unique customer we have--

  select count(distinct customer_id) from [dbo].[SQL - Retail Sales Analysis_utf ]

  --3.unique categories 

  select distinct category from [dbo].[SQL - Retail Sales Analysis_utf ]

 ----- Business Problems ---

--1.write the sale made on specific day 

select * from [dbo].[SQL - Retail Sales Analysis_utf ]
where sale_date ='2022-05-11'

--2.write the query to retrieve the all transaction where category is clothing and the quantity sold is more than 10 nov

select *
from [dbo].[SQL - Retail Sales Analysis_utf ]
where category='clothing' and month(sale_date)>11
and quantiy >=4


--3.--Total Sales For each category---
select sum(total_sale),category from [dbo].[SQL - Retail Sales Analysis_utf ]
group by category

----4.find average age of the customers who purchased items beauty from category

select avg(age) from [dbo].[SQL - Retail Sales Analysis_utf ]
where category ='Beauty'

----5.total Sale is greater than 1000 for all transactions---
select * from [dbo].[SQL - Retail Sales Analysis_utf ]
where total_sale > 1000

----6.total number of transaction made my eaxch gender in each category--

select count(transactions_id) as Total_transactions ,gender,category
from [dbo].[SQL - Retail Sales Analysis_utf ]
group by gender,category
order by 1 

---7.Average Sales for each month and also retrieve the best selling--
select * from 
(
select avg(total_sale) as Average_sales ,month(sale_date) as month_no,year(sale_date) as year_of,
rank() over(partition by year(sale_date)  order by  avg(total_sale)  desc) as rnk 
from [dbo].[SQL - Retail Sales Analysis_utf ]
group by month(sale_date),year(sale_date)
) as avg_sales_month
where rnk =1

----8.top 5 customers based on total sales--

select top 5  sum(total_sale) as total_sales ,customer_id  from [dbo].[SQL - Retail Sales Analysis_utf ]
group by customer_id
order by 1 desc


--9-no of unique customers who purchased items from each category --

select category,count(distinct customer_id) as unique_customers
from [dbo].[SQL - Retail Sales Analysis_utf ]
group by category

---10.--write the query each shift and no of orders (orders per shift) ---

with hourly_sales as(
SELECT *,
    CASE 
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
        ELSE 'evening'
    END AS shifts
FROM [dbo].[SQL - Retail Sales Analysis_utf])
select shifts,count(*) as total_orders  from hourly_sales
group by shifts