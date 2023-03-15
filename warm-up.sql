-- using the chipotle database,
show databases;
use chipotle;
select database();
show tables;
select *
from orders;

-- find how many times someone ordered a chicken or veggie bowl
-- with a quantity greater than 1
select *
from orders
where item_name IN ('Chicken bowl','Veggie Bowl')
	and quantity > 1;
	
-- 15 mar warm up
-- Using the customer table from sakila database,
-- find the number of active and inactive users

show databases;
use sakila;
select database();
show tables;

select *
from customer;

select count(*)
from customer;

select distinct active
from customer;

select active, count(*)
from customer
group by active;
-- when ever we need to group by category we have to use 'group by'