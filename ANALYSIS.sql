CREATE DATABASE PIZZAHUT;
USE PIZZAHUT;
SELECT * FROM pizza_types;
CREATE TABLE ORDER_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id));

-- Retrieve the total number of orders placed.

select count(*) from orders;

-- Calculate the total revenue generated from pizza sales.-- 
SELECT 
    SUM(pizzas.price * order_details.quantity) AS total
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;
--     
--     Identify the highest-priced pizza.-- 


select * from pizzas;
select * from order_details;
select * from pizza_types;
SELECT 
    pizza_types.name,pizzas.price
FROM
    pizzas 
        JOIN
    pizza_types  on pizzas.pizza_type_id = pizza_types.pizza_type_id order by pizzas.price desc limit 1;
    
-- Identify the most common pizza size ordered.
SELECT 
pizzas.size,
   (count(pizzas.size))as c
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id group by pizzas.size order by c desc limit 1;
    
-- List the top 5 most ordered pizza types along with their quantities.
select * from pizzas;
select * from pizza_types;
select * from  order_details;
with piz as (
select pizza_types.name,pizzas.pizza_id
from pizza_types join pizzas 
on pizza_types.pizza_type_id=pizzas.pizza_type_id 
)
select piz.name , sum(order_details.quantity) as tq from piz  join order_details on piz.pizza_id = order_details.pizza_id group by piz.name order by tq desc limit 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

with piz as (
select pizza_types.category,pizzas.pizza_id
from pizza_types join pizzas 
on pizza_types.pizza_type_id=pizzas.pizza_type_id 
)select piz.category,
 sum(order_details.quantity) as tq from piz  join order_details on piz.pizza_id = order_details.pizza_id group by piz.category;
 
--  Determine the distribution of orders by hour of the day.
select hour(order_time),count(order_id) from orders group by hour(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.
with piz as (
select pizza_types.category,pizzas.pizza_id
from pizza_types join pizzas 
on pizza_types.pizza_type_id=pizzas.pizza_type_id 
)select piz.category,
 count(order_details.order_details_id) as
 tq from piz  join order_details on piz.pizza_id = order_details.pizza_id group by piz.category;
 
--  Determine the top 3 most ordered pizza types based on revenue.
select * from orders;
select * from pizzas;
select * from pizza_types;
select * from  order_details;
with cte as (
SELECT 
pizzas.pizza_type_id,
    SUM(pizzas.price * order_details.quantity) AS total
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id group by pizzas.pizza_type_id)
    
select cte.total,pizza_types.name from cte join pizza_types on cte.pizza_type_id = pizza_types.pizza_type_id order by total desc limit 3;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT AVG(T) 
 FROM 
 (
select orders.order_date
, sum(order_details.quantity) as t
 from orders join order_details on orders.order_id = order_details.order_id group by orders.order_date) as av;
 

 
 
