-- which employees have higher than avg salary. (scaler example)
use employees;

select avg(salary)
from salaries;

select *
from salaries;

select *
from salaries
-- conditional subquery
where salary > 63810;
-- not programmatic

select *
from salaries
where salary >
	(
	select avg(salary)
    from salaries
    )
;

-- add the person
select e.first_name, 
		e.last_name,
		s.*
from salaries as s
join employees as e using (emp_no)
where salary >
	(
	select avg(salary)
    from salaries
    )
    and s.to_date > curdate()
;

-- see the average as well
select e.first_name, 
		e.last_name,
		s.salary,
        (select round(avg(salary),0) from salaries) as avg_salary        
from salaries as s
join employees as e using (emp_no)
where salary >
	(
	select avg(salary)
    from salaries
    )
;

-- find all current dept managers names and birthdates (column subquery)

select *
from employees;

select *
from dept_manager;

-- all current managers
select *
from dept_manager
where to_date > now();

-- first and last names
select first_name
	,last_name
    ,birth_date
from employees;

-- join with a subquery

select first_name
	,last_name
    ,birth_date
from employees
where emp_no in 
	(
    select emp_no
	from dept_manager
	where to_date > now()
)
;

-- select managers by name with birthdates add department they work in
select e.first_name
	,e.last_name
    ,e.birth_date
    ,d.dept_name
from employees as e
join dept_manager as dm using (emp_no)
join departments as d using (dept_no)
where emp_no in 
	(
    select emp_no
	from dept_manager
	where to_date > now()
)
;

-- row subquery, one employee 

select *
from employees
where emp_no = 101010;

select first_name
	, last_name
    ,birth_date
from employees
where emp_no = 
	(
	select emp_no
    from employees
    where emp_no = 101010
    )
;

-- subquery a table
-- how many duplicate user names are there from your user name query

select sum(cnt), count(cnt), max(cnt)
from (
	select lower(concat(substr(first_name,1,1),
						substr(last_name,1,4),
                        '_',
                        lpad(month(birth_date),2,0),
                        substr(birth_date,3,2)
                        )
					    ) as username
                        , count(*) as cnt
                        from employees
                        group by username
                        having count(*) >= 2
                        order by count(*) desc
                        ) as un
                        