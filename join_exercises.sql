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

-- 2
select departments.dept_name as `Department Name`, concat(employees.first_name,' ',employees.last_name) as `Department Manager`
from dept_manager
join departments on dept_manager.dept_no = departments.dept_no
join employees on dept_manager.emp_no = employees.emp_no
where dept_manager.to_date > now()
 order by departments.dept_name;

-- 3
select departments.dept_name as `Department Name`, concat(employees.first_name,' ',employees.last_name) as `Department Manager`
from dept_manager
join departments on dept_manager.dept_no = departments.dept_no
join employees on dept_manager.emp_no = employees.emp_no
where dept_manager.to_date > now()
and employees.gender = 'F'
order by departments.dept_name;

-- 4
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

-- 5
select *
from salaries;

select departments.dept_name as `Department Name`, concat(employees.first_name,' ',employees.last_name) as `Name`, salary
from dept_manager
join departments on dept_manager.dept_no = departments.dept_no
join employees on dept_manager.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no
where dept_manager.to_date > now()
 and salaries.to_date > now()
 group by departments.dept_name, employees.first_name, employees.last_name, salary
order by departments.dept_name;

 
 -- 6
 select *
 from employees;
 
 select *
 from departments;
 
 select *
 from dept_emp;
 
select departments.dept_no, departments.dept_name, count(*) as num_employees
	from dept_emp
join employees on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join salaries on employees.emp_no = salaries.emp_no
where dept_emp.to_date > now()
group by departments.dept_no, departments.dept_name
	order by departments.dept_no asc;
    
-- 7 
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

-- 8 
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

-- 9
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

-- 10
select dept_name, round(AVG(salary),0) as average_salary
	from dept_emp
join employees on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join salaries on employees.emp_no = salaries.emp_no
group by dept_name
order by AVG(salary) desc;
