/* 
FERID GURBANOV

Pizza_Sales_Report

*/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Total Revenue

select sum(total_price)as total_revenue from pizza_sales

-- Avarage Order Value

select floor(sum(total_price)/count(distinct order_id)) as avg_order from pizza_sales

-- Total Pizza Sold
 
select sum(quantity) as total_pizza_sold from pizza_sales

-- Total orders

select count( distinct order_id) as total_orders from pizza_sales

-- Average Pizzas Per Order

select floor(sum(quantity)/ count(distinct order_id)) avg_pizza from pizza_sales

------------------------------------------------------------------------------------------------------------------------------------------------------

-- Daily Trend for Total Orders

select to_char(order_date, 'DAY') as day_name,
count(distinct order_id) as total_orders
from pizza_sales group by to_char(order_date, 'DAY')

-- Monthly Trend for Total Orders

select to_char(order_date, 'MONTH') as month_name,
count(distinct order_id) as total_orders
from pizza_sales group by to_char(order_date, 'MONTH') order by total_orders desc

-- Percentage of Sales by Pizza Ctegory 

--select * from pizza_sales where extract(month from order_date)=1

select distinct pizza_category,sum(total_price) as total_price,
round(sum(total_price)*100 / (select sum(total_price) from pizza_sales ), 2) as pct_total_sales
from pizza_sales group by pizza_category

-- Percentage of Sales by Pizza Size

select distinct pizza_size,sum(total_price) as total_price,
round(sum(total_price)*100 / (select sum(total_price) from pizza_sales ),2) as pct_total_sales
from pizza_sales  group by pizza_size order by total_price desc

-------------------------------------------------------------------------------------------------------------------------------------------------------

-- Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

select pizza_name, sum(total_price) as total_revenue
from pizza_sales group by pizza_name 
order by total_revenue desc
fetch first 5 rows only

select pizza_name, sum(quantity) as total_quantity
from pizza_sales group by pizza_name 
order by total_quantity desc
fetch first 5 rows only

select pizza_name, count(distinct order_id) as total_order
from pizza_sales group by pizza_name 
order by total_order desc
fetch first 5 rows only
