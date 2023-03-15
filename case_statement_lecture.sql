-- if statements and case statements

-- what is it: controlling the flow of the program with conditional statements

use chipotle;
show tables;

select * 
from orders;

select * 
from orders
where item_name like '%chicken%'
;

select distinct item_name
from orders
where item_name like '%chicken%';

-- if function
-- if (condition, value_if_true, value_if_false) best for true or false
-- these hang out in the select statment (manipulating output data)

-- use if statement to find out if item is a chicken bowl
select distinct item_name, if (item_name = 'chicken bowl', 'yes', 'no') as is_chicken_bowl
from orders;

-- output values also work with no-strings

select distinct item_name, if (item_name = 'chicken bowl', '1', '0') as is_chicken_bowl
from orders;

-- recognizes the true and false but stores them as 1 and 0
select distinct item_name, if (item_name = 'chicken bowl', True, False) as is_chicken_bowl
from orders;

select *, if(item_name = 'chicken bowl', true, false) as is_chicken_bowl
from orders
;

-- shortcut
select distinct item_name
	, if (item_name like '%chicken%', true, false) as has_chicken
    from orders
    ;
-- dont have to explicitly type out the IF() when the output is true or false
select distinct item_name
	,item_name like '%chicken%' as has_chicken
-- output will always be 1 and 0 for true and false

    from orders
    ;
    
-- subquery to count chicken items
select -- distinct item_name
	 if (item_name like '%chicken%', 'yes', 'no') as has_chicken
    , count(*)
    from orders
    group by has_chicken
    ;
    
-- using subquery
select sum(has_chicken)
from
	(
	select distinct item_name
	,if(item_name like '%chicken%', true, false) as has_chicken
	from orders
	) as chicken
;

-- case statement
-- single out a single column
-- check if it equals something, if it does, perform an action and exit
-- check if it equals a second thing, if it does, perform that action
-- if it doesnt equal any of the above values perform an action for whatever is left and exit

/* format:
 case [column name]
	when [condition_a] then [output_value_a]
    when [condition_b] tgeb [output_value_b]
    elese [output_value_c]
end as [new_column_name]
*/

-- we are only checking one column
-- we are only checking for equality
-- but we can check for more than ture and false

select distinct item_name from orders;
-- find the bowls
select distinct item_name,
	case item_name
		when 'chicken bowl' then 'yes_chicken'
		when 'steak bowl' then 'yes_steak_bowl'
        when 'izze' then 'yes_izze'
        -- when like '%burrito%' then 'yes_some_burritos' -- wont work because it checks for equality
        else 'other'
	end as 'some_items'
from orders
;
    
-- case statement - option 2
-- check for a condition, if true, perform an action and exit
-- check for another condition, if true, perform an action and exit
-- and for whatever is left, perform an action and exit

/* format
	case
		when [colum_a condition_a] then [output_value_a]
		when [column_b condition_b] then [output_value_b]
		else value_c
	end as [new_column_name]
*/

-- more flexibility
-- can check different columns
-- con use different operator than equals
-- order matters
-- in general, this is the prefeered format 

select distinct item_name,
	case 
		when item_name = 'chicken bowl' then 'is_chicken_bowl' 
        --  ^checks first and perform and exit (will not check next if true)
		when item_name like '%bow%' then 'other_bowl'
        -- if no else statement then returned as null
        else 'other'
        end 'find_bowls'
from orders
;

select distinct item_name,
	case 
		when item_name = 'chicken bowl' then 'is_chicken_bowl' 
		when item_name like '%bow%' then 'other_bowl'
        when order_id < 4 then 'early_order'
	end 'find_bowls',
	case
		when choice_description like '%tomato%' then 'contains_tomato'
	end
from orders
;

select distinct item_price -- price is in strings
from orders
order by item_price
;

-- group quantity
select quantity, count(*)
from orders
group by quantity
;

-- categories for how many times a person ordered a specific item in an order
select distinct quantity,
	case 
		when quantity >= 5 then 'big orders'
        when quantity >= 2 then 'middle orders'
        else 'small orders'
	end as 'order_size'
from orders
;

-- find out how many times people ordered the different sizes (subquery)
select count(*), order_size
from
   (select id, quantity,
		case 
			when quantity >= 5 then 'big orders'
			when quantity >= 2 then 'middle orders'
			else 'small orders'
		end as 'order_size'
	from orders) as orders
group by order_size
;