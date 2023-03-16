show databases;

# use your data base since it has write permissions
use pagel_2187;
select database();

# create a temporary table called my_numbers
# with tow columns - n & name

create temporary table my_numbers -- new table name
	(
    n int unsigned not null, -- first column
    name varchar(20) not null -- second column
    ) -- contained in parenthesis
    ;
    
select *
from my_numbers;

show tables; -- temp tables wont show up in your list of tables

# insert data in my numbers
Insert into my_numbers (n, name) -- table name (columns)
values (1, 'a'), (2, 'b'), (3, 'c'), (4, 'd') -- inserting each clumn by row
;
insert into my_numbers (n, name)
values (5, 'e')
;
-- verify data was inserted
select * from my_numbers;

# update values
update my_numbers -- stating that im going to update my_numbers table
set name = 'big' --  what I want to change my values to
where n >= 4 -- where i want to change my values
;

select *
from my_numbers;
# delete values from temp table

delete from my_numbers
where n > 2
;

select *
from my_numbers;


use employees;

select employees.*
		, salary
        , dept_name
from employees
	join dept_emp
		using (emp_no)
	join salaries
		using (emp_no)
	join departments 
		using (dept_no)
	where salaries.to_date > now()
		and dept_emp.to_date > now()
        and dept_name = 'Customer Service'
        ;
    
    
create temporary table pagel_2187.curr_employees -- write to my current database
( -- write 
select employees.*
		, salary
        , dept_name
from employees
	join dept_emp
		using (emp_no)
	join salaries
		using (emp_no)
	join departments 
		using (dept_no)
	where salaries.to_date > now()
		and dept_emp.to_date > now()
        and dept_name = 'Customer Service'
)
;

select * from pagel_2187.curr_employees; -- have to specify my database

add a new column for a avg salary in temp table

alter table curr_employees -- adding a new column to curr_employees
add avg_dept_salary float -- adding column by specifying name a datatype
;

select * from my_numbers;
drop table curr_employees;
drop table my_numbers;

-- alter table [table_name] -- changing structure of the table
-- add/drop [column_name/ row condition]
-- update table [ table_name]
-- set [cloumn_name = value]
	-- where [conditional]
-- drop table [ table_name]