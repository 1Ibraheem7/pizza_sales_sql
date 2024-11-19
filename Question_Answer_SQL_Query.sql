create database pizzahut;
use pizzahut;



--1 Calculate the total revernue generated from pizza sales.

select 
round(sum(order_details.quantity * pizzas.price),2)as total_sales
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id

--3 Identify the highest-priced pizza.
select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by pizzas.price desc limit 1;


--4 Identity the most common pizza size orderd.
select quantity, count(order_details_id)
from order_details group by quantity;

--5 Identity the most common pizza size ordered.
select pizzas.size, count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id =order_details.pizza_id
group by pizzas.size order by  order_count desc;
select pizzas.size, count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id =order_details.pizza_id
group by pizzas.size order by  order_count desc;
select pizzas.size, count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id =order_details.pizza_id
group by pizzas.size order by  order_count desc;


--6 list the top 5 most orderd pizza
--6 Type along with their quantites.
select pizza_types.name,
order_details.quantity
from pizza_type join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id;

#inter
--7 Join the necessary tables to find the 
--  total quantity of each pizza category ordered.
select paizza_types.category,
sum(order_details.quantity) as quantity
from pizza_type join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by  quantity desc;


--8 Determine the distribution of orders by hour of the day
select * from orders;
select hour(time), count(order_id) from orders
group by hour(time);

--9 join relevent tables to find the category -wise distribution of pizzas.
select category , count(name) from pizza_types
group by category;

--10 Group the orders by date and calculate the average
-- number of pizzas ordered per day.
select avg(quantity)from
(select orders.date, sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id= order_details.order_id
group by orders.date) as order_quantity;

--11 Determine the top 3 most ordered pizza types based on reveue.
select pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;


--12 Calcutate the percentage contribution of each pizza type to total revenue.
select pizza_types.category,
sum(order_deatils.quantity*pizzas.price)as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by revenue desc;


--13 Analyze the cumulative revenue generated over lime.
select orders.date,
sum(revenue) over (order by date)as cum_revenue
from
(select orders.date,
sum(order_details.quantity * pizzas.price)as revenue
from order_details join pizzas
on order_details.pizza_id=pizzas.pizza_id
join orders
on orders.order_id=order_details.order_id
group by orders.date) as sales;

14 Determine the top 3 most orderd pizza types based on revenue for each pizza category.

