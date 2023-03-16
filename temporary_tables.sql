/* Using the example from the lesson, create a temporary table called employees_with_departments 
that contains first_name, last_name, and dept_name for employees currently with that department. 
*/

show databases;
use pagel_2187;
select database();
use employees;
show tables;

select *
from employees;

select * 
from dept_emp;

select *
from departments;

CREATE TEMPORARY TABLE pagel_2187.employees_with_departments
(
select e.first_name, e.last_name, d.dept_name
from employees as e
	join dept_emp
		using (emp_no)
	join departments as d
		using (dept_no)
	where dept_emp.to_date > now()
)
    ;


select * 
from pagel_2187.employees_with_departments;

describe pagel_2187.employees_with_departments;

-- Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.

alter table pagel_2187.employees_with_departments 
add Full_name varchar(30) default null;

select *
from pagel_2187.employees_with_departments;

-- Update the table so that the full_name column contains the correct data.
update pagel_2187.employees_with_departments
set Full_name = concat(first_name, ' ', last_name);

select *
from pagel_2187.employees_with_departments;

-- Remove the first_name and last_name columns from the table.
ALTER TABLE pagel_2187.employees_with_departments
  DROP COLUMN First_name,
  Drop COLUMN Last_Name;

select *
from pagel_2187.employees_with_departments;

-- What is another way you could have ended up with this same table?

create temporary table pagel_2187.employees_with_departments
(
select concat(first_name, ' ', last_name) as full_name, d.dept_name
from employees as e
	join dept_emp
		using (emp_no)
	join departments as d
		using (dept_no)
	where dept_emp.to_date > now()
)
    ;

select *
from pagel_2187.employees_with_departments;

-- Create a temporary table based on the payment table from the sakila database.
use pagel_2187;
use sakila;
show tables;

select *
from payment;

CREATE TEMPORARY TABLE pagel_2187.sakila_payment
(
select payment_id
	, customer_id
    , staff_id
    , rental_id
    , amount * 100 as amount2
    , payment_date
    , last_update	
	from sakila.payment
  
)
;

select * 
from pagel_2187.sakila_payment;


/* Write the SQL necessary to transform the amount column such that it is stored as an integer 
representing the number of cents of the payment. For example, 1.99 should become 199. */

ALTER TABLE pagel_2187.sakila_payment
MODIFY COLUMN amount2 int;

select * 
from pagel_2187.sakila_payment;


/* Find out how the current average pay in each department compares to the overall current 
pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. 
In terms of salary, what is the best department right now to work for? The worst? */

use employees;
show tables;

select avg(salary), std(salary)
from employees.salaries
where to_date > curdate();

create temporary table pagel_2187.overall_aggregates as 
	(
	select avg(salary) as avg_salary, std(salary) as std_salary
	from employees.salaries
	where to_date > curdate()
	)
    ;

select *
from pagel_2187.overall_aggregates;

create temporary table pagel_2187.current_info as 
(
select dept_name
	, round(AVG(salary),0) as average_salary
	from dept_emp
join employees on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join salaries on employees.emp_no = salaries.emp_no
 where salaries.to_date > now()
group by dept_name
order by AVG(salary) desc
)
;

select *
from pagel_2187.current_info;

alter table pagel_2187.current_info
add overall_avg float (10,2);

alter table pagel_2187.current_info
add overall_std float (10,2);

alter table pagel_2187.current_info
add zscore float (10,2);

select *
from pagel_2187.current_info;

update pagel_2187.current_info
set overall_avg = (select avg_salary from pagel_2187.overall_aggregates)
;

update pagel_2187.current_info
set overall_std = (select std_salary from pagel_2187.overall_aggregates)
;

select * 
from pagel_2187.current_info;

-- update the zscore column to hold the calculated zscores
update pagel_2187.current_info
set zscore = (average_salary - overall_avg) / overall_std;

select * 
from pagel_2187.current_info
order by zscore desc;
-- sales is the best department to work for and human resources would be the worst
