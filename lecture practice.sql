use chipotle;
show tables;

select distinct item_name
from orders
where item_name like '%chicken%'
;

select item_name -- have to specify the item_name, can not leave it *
from orders
where item_name like '%chicken%'
group by item_name
;

select item_name, quantity -- can't add any additional columns without and aggregate function
from orders
where item_name like '%chicken%'
group by item_name, quantity
order by item_name
;

-- aggregate functions
-- how many chicken bowls have been ordered?

select count(*)
from orders
where item_name = 'chicken bowl'
;

-- for each chicken item, how many times was it ordered?
select item_name, count(*)
from orders where item_name like '%chicken%'
group by item_name
;

-- min, max
select item_name, min(quantity), max(quantity), round(avg(quantity),1), count(*)
from orders where item_name like '%chicken%'
group by item_name
;

-- having

-- select
-- from
-- where
-- group by
-- having

-- find all order items that have been ordered over 100 times
-- first group by item_name

-- then filter by counts greater than 100

select item_name, sum(quantity) as sum_quant
from orders
group by item_name
having sum_quant > 100
order by sum_quant desc
limit 5;
