/* 1 Write a query that returns all employees, 
their department number, their start date, their end date, and a new column 'is_current_employee' that 
is a 1 if the employee is still with the company and 0 if not. */

show databases;
use employees;
select database();

select *
from dept_emp;

select *
from departments;

select e.first_name, e.last_name, d.dept_no, e.hire_date, current_employees.to_date, current_employees.is_current_employee
from 
	(select to_date, emp_no, dept_no
	, if(to_date > curdate(), true,false) as is_current_employee
    from dept_emp)
    as current_employees
	join employees as e using (emp_no)
	join departments as d using (dept_no);
    
select to_date
	, if(to_date > curdate(), true,false) as is_current_employee, e.*
    from dept_emp
    as current_employees
    join employees as e using (emp_no);

/* Write a query that returns all employee names (previous and current), 
and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
depending on the first letter of their last name.*/
select first_name, last_name,
	case 
		when substr(last_name, 1) <= 'h' then 'A-H'
        when substr(last_name, 1) between 'h' and 'r' then 'I-Q'
        when substr(last_name, 1) > 'q' then 'R-Z'
    end as 'alpha_group'
from employees
;

/* How many employees (current or previous) were born in each decade? */

select count(*), decade_born
	from
    (select birth_date,
	case
		when birth_date like '192%' then '20s'
		when birth_date like '193%' then '30s'
		when birth_date like '194%' then '40s'
        when birth_date like '195%' then '50s'
        when birth_date like '196%' then '60s'
        when birth_date like '197%' then '70s'
        when birth_date like '198%' then '80s'
        when birth_date like '199%' then '90s'
    end as 'decade_born'    
from employees) as bdays
group by decade_born;

/*What is the current average salary for each of the following department groups: R&D, Sales & Marketing, 
Prod & QM, Finance & HR, Customer Service?*/
select *
from salaries;

select *
from dept_emp;

select *
from departments;

select round(avg(salary),2),
	CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance and HR'
       ELSE 'Customer Service'
   END AS dept_group
from salaries as s
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
 where s.to_date > curdate()
  and de.to_date > curdate()
group by dept_group
;

-- a different way

select round(avg(salary),2),
	CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance and HR'
       ELSE 'Customer Service'
   END AS dept_group
from salaries as s
join dept_emp as de on s.emp_no = de.emp_no
 and de.to_date > now()
join departments as d using (dept_no)
 where s.to_date > now()
group by dept_group
;

