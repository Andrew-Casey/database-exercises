show databases;
use employees;
select database();
show tables;
-- Find all the current employees with the same hire date as employee 101010 using a subquery.
select *
from employees;

select hire_date 
from employees
where emp_no = (101010);

select e.first_name
	  ,e.last_name
      ,e.hire_date
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
where hire_date =
		(
		select hire_date 
		from employees
		where emp_no = (101010)
        )
	and de.to_date > now()
        ;

-- Find all the titles ever held by all current employees with the first name Aamod.
select *
from employees;

select * 
from titles;

select e.first_name, e.last_name, t.title
FROM
    (
        SELECT *
        FROM employees
        WHERE first_name = 'Aamod'
    ) as e
JOIN titles as t ON e.emp_no = t.emp_no
Join dept_emp as de on e.emp_no = de.emp_no
WHERE de.to_date > CURDATE();

      
-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
select first_name, last_name
from employees;

select *
from dept_emp;
   
 select count(*)
	from employees
    where emp_no not in
		(
        select employees.emp_no
        from employees
        join dept_emp on employees.emp_no = dept_emp.emp_no
        and dept_emp.to_date > curdate()
        )
        ;
    -- 59900
        
-- Find all the current department managers that are female. List their names in a comment in your code.
select *
from employees;

select * 
from dept_manager;

select concat(first_name, ' ', last_name) 
	from employees as e
	where e.emp_no in (select d.emp_no from dept_manager as d
						join employees e on e.emp_no = d.emp_no
						where d.to_date > curdate()
						and gender = 'f');

-- Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.

select concat(e.first_name, ' ',e.last_name), 
		s.salary,
        (select round(avg(salary),0) from salaries) as avg_salary        
from salaries as s
join employees as e using (emp_no)
where salary >
	(
	select avg(salary)
    from salaries
    )
and to_date > now()
;

-- How many current salaries are within 1 standard deviation of the current highest salary? 
select *
from salaries;

select count(*)
	from salaries
    where salary >
    (select max(salary)from salaries
    where to_date > now()) - (select round(std(salary),0) from salaries
    where to_date > now())
    and to_date > now()
;
  -- What percentage of all salaries is this?
select 
(100*(100* (select count(*)
	from salaries
    where salary >
    (select max(salary)from salaries
    where to_date > now()) - (select round(std(salary),0) from salaries
    where to_date > now())
    and to_date > now())
    /
    count(emp_no)))
    from salaries
    where to_date > now()
    ;

-- Find all the department names that currently have female managers.
    select e.first_name, e.last_name, e.gender, d.dept_name
	from
		(
        select *
        from employees
        where gender = 'F'
        ) as e
        join dept_manager as dm on e.emp_no = dm.emp_no
        join departments as d on dm.dept_no = d.dept_no
        order by e.first_name
        ;
    
select *
from departments;
select *
from dept_manager;

-- Find the first and last name of the employee with the highest salary.
select e.first_name, 
		e.last_name,
		salary,
        (select max(salary) from salaries) as max_salary        
from salaries as s
join employees as e using (emp_no)
where salary = (select max(salary) from salaries)
	and to_date > now()
order by salary desc
limit 1
;

-- Find the department name that the employee with the highest salary works in.
