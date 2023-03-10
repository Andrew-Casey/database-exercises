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
	