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
where dept_manager.to_date > now();

-- 3
select departments.dept_name as `Department Name`, concat(employees.first_name,' ',employees.last_name) as `Department Manager`
from dept_manager
join departments on dept_manager.dept_no = departments.dept_no
join employees on dept_manager.emp_no = employees.emp_no
where dept_manager.to_date > now()
and employees.gender = 'F';

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
group by title;

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
 
select departments.dept_no, departments.dept_name, count(*)
from dept_emp
join employees on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join salaries on employees.emp_no = salaries.emp_no
group by departments.dept_no, departments.dept_name
;