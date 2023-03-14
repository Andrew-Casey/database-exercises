show databases;
use join_example_db;
select database();
show tables;

select *
from roles;

describe roles;

select *
from users;
describe users;

select * -- returns 4 results
from roles
join users on roles.id = users.role_id;

select * -- to flip order, change which table is calling 'joining' from the other.
from users
join roles 
on roles.id = users.role_id;

select *
from roles
left join users 
on roles.id = users.role_id;

select *
from roles
right join users 
on roles.id = users.role_id;

select role_id, count(*)
from roles
join users 
on roles.id = users.role_id
group by role_id;

use employees;
select database();
show tables;

select *
from dept_manager;

select *
from employees;

select *
from departments;

select *
from dept_emp;

-- 2 write a query that shows each department along with the name of the current manager for that department.
select departments.dept_name as `Department Name`, concat(employees.first_name,' ',employees.last_name) as `Department Manager`
from dept_manager
join departments on dept_manager.dept_no = departments.dept_no
join employees on dept_manager.emp_no = employees.emp_no
where dept_manager.to_date > now() -- curdate() 
 order by departments.dept_name;

-- 3 Find the name of all departments currently managed by women.
select departments.dept_name as `Department Name`, concat(employees.first_name,' ',employees.last_name) as `Department Manager`
from dept_manager
join departments on dept_manager.dept_no = departments.dept_no
join employees on dept_manager.emp_no = employees.emp_no
where dept_manager.to_date > now()
and employees.gender = 'F'
order by departments.dept_name;

-- 4 Find the current titles of employees currently working in the Customer Service department.
show tables;
select *
from employees;

select *
from departments;

select *
from dept_emp;

select * 
from titles;

select titles.title, count(*)
from dept_emp
join employees on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join titles on employees.emp_no = titles.emp_no
where dept_name = 'Customer Service'
	and titles.to_date > now()
group by title
order by title;

-- Andrew King example
select t.title, count(de.emp_no) as count
from dept_emp as de
join titles as t using (emp_no)
join departments as d using (dept_no)
where t.to_date > curdate() 
	and de.to_date > curdate()
    and d.dept_name = 'Customer Service'
group by t.title
;
-- 5 Find the current salary of all current managers.
select *
from salaries;

select departments.dept_name as `Department Name`, concat(employees.first_name,' ',employees.last_name) as `Name`, salary
from dept_manager
join departments on dept_manager.dept_no = departments.dept_no
join employees on dept_manager.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no
where dept_manager.to_date > now()
 and salaries.to_date > now()
 -- group by departments.dept_name, employees.first_name, employees.last_name, salary
order by departments.dept_name;

 
 -- 6 Find the number of current employees in each department.
 select *
 from employees;
 
 select *
 from departments;
 
 select *
 from dept_emp;
 
select dept_emp.dept_no, departments.dept_name, count(dept_emp.emp_no) as num_employees
	from employees
join dept_emp on employees.emp_no = dept_emp.emp_no    
join departments on dept_emp.dept_no = departments.dept_no
where dept_emp.to_date > now()
group by departments.dept_no, departments.dept_name
	order by departments.dept_no asc;
    
-- 7 Which department has the highest average salary? Hint: Use current not historic information.
select *
from salaries;

select *
from employees;

select departments.dept_name, avg(salary) as average_salary
	from dept_emp
join employees on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join salaries on employees.emp_no = salaries.emp_no
	where salaries.to_date > now()
		and dept_emp.to_date > now()
	group by departments.dept_name
		order by departments.dept_name desc
	limit 1;

-- Andrew King's example
select d.dept_name, 
		round(avg(s.salary),2) as average_salary
from dept_emp as de
join salaries as s on de.emp_no = s.emp_no
	and de.to_date > curdate()
    and s.to_date > curdate()
join departments as d using (dept_no)
	group by d.dept_name
    order by average_salary desc
    limit 1
;

-- 8 Who is the highest paid employee in the Marketing department?
select employees.first_name, employees.last_name
	from dept_emp
join employees on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join salaries on employees.emp_no = salaries.emp_no
where salaries.to_date > now()
 and dept_emp.to_date > now()
group by employees.first_name, employees.last_name, salaries.salary, dept_name
having dept_name = 'marketing'
 order by salaries.salary desc 
limit 1;

-- 9 Which current department manager has the highest salary?
select employees.first_name ,employees.last_name, salary, departments.dept_name
	from dept_manager
join departments on dept_manager.dept_no = departments.dept_no
join employees on dept_manager.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no
	where dept_manager.to_date > now()
	and salaries.to_date > now()
group by departments.dept_name, employees.first_name, employees.last_name, salary
order by salary desc
limit 1;

-- 10 Determine the average salary for each department. Use all salary information and round your results.
select dept_name, round(AVG(salary),0) as average_salary
	from dept_emp
join employees on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join salaries on employees.emp_no = salaries.emp_no
group by dept_name
order by AVG(salary) desc;

-- Andrew King's example
select d.dept_name, 
	 round(avg(s.salary),0) as avg_dept_salary
from departments as d
join dept_emp as de using (dept_no)
join salaries as s using (emp_no)
group by d.dept_name
order by avg_dept_salary desc
;

-- 11
select CONCAT(employees.first_name,' ', employees.last_name) as `Employee Name`
	   , departments.dept_name as `Department Name`
	   -- , CONCAT(employees_manager.first_name, ’ ’, employees_manager.last_name)
FROM employees
JOIN dept_emp on employees.emp_no = dept_emp.emp_no
JOIN departments on dept_emp.dept_no = departments.dept_no
JOIN dept_manager on dept_emp.dept_no =  dept_manager.dept_no
JOIN employees as employees_manager on dept_manager.emp_no = employees_manager.emp_no
-- JOIN departments as departments_manager on dept_manager.dept_no = departments.dept_no
WHERE dept_emp.to_date > NOW()
 	AND dept_manager.to_date > NOW()	
;
