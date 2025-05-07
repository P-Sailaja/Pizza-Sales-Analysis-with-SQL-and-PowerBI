select * from dbo.pizza_Sales;
-- Query 1. Total Revenue

SELECT SUM(total_price) as Revenue FROM pizza_sales;

-- Query 2. Average Order Value

select SUM(total_price) / COUNT(DISTINCT order_id) as Avg_Order_Value
FROM pizza_sales;

-- Query 3. Total Pizza Sold

SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;

-- Query 4. Total Orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- Query 5. Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity) as decimal(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) as decimal(10,2)) as Avg_Pizzas_Per_Order
FROM pizza_sales;

-- Query 6. Daily Trend for Total Orders

SELECT DATENAME(DW, order_date) as Order_day, 
       COUNT(DISTINCT order_id) as Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date); 

-- Query 7. Monthly Trend for Total Orders
SELECT DATENAME(MONTH, order_date) as Month,
       COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_orders DESC

-- Query 8. Percentage of Sales by Pizza Category
SELECT pizza_category, SUM(total_price) as Total_Sales, SUM(total_price)*100 /
(SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category 
ORDER BY PCT DESC

--Query 9. Percentage of Sales by Pizza Size
SELECT pizza_size,  CAST(sum(total_price) as decimal(10,2)) as Total_sales, CAST(SUM(total_price) *100 /
(SELECT SUM(total_price) from pizza_sales WHERE DATEPART(quarter, order_date) = 1) as decimal(10,2)) as PCT
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC

-- Query 10. Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) as Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- Query 11. Bottom 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) as Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

-- Query 12. Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) as Total_Quantity 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

-- Query 13. Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) as Total_Quantity 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

-- Query 14. Top 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

-- Query 14. Bottom 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
