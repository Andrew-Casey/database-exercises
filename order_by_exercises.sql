-- Use the employees database.
use employees;
select database();

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?alter
select *
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
limit 3;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. What is the employee number of the top three results? Does it match the previous question?
select *
from employees
where first_name = 'Irena'
	or first_name = 'Vidya'
    or first_name = 'Maya'
    limit 3;  -- previous top three employee numbers are 10200, 10397, 10610. The top three results appear to be the same. 

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. What is the employee number of the top three results.
select *
from employees
where gender = 'm'
	and (first_name = 'Irena'
	or first_name = 'Vidya'
    or first_name = 'Maya')
    limit 3;

-- Find all unique last names that start with 'E'.
select distinct last_name
from employees
where last_name like 'E%';

-- Find all unique last names that start or end with 'E'.
select distinct last_name
from employees
where last_name like 'E%'
	or last_name like '%E';
    
-- Find all unique last names that end with E, but does not start with E?
select distinct last_name
from employees
where last_name like '%E'
and last_name not like 'E%';

-- Find all unique last names that start and end with 'E'.
select distinct last_name
from employees
where last_name like 'E%'
and last_name like '%E';

-- Find all current or previous employees hired in the 90s. Enter a comment with top three employee numbers.
select *
from employees
where hire_date between '1990-01-01' and '1999-12-31'; -- 10008, 10011, 10012 are the top three

-- Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.
select *
from employees
where birth_date like '%12-25';  -- 10078, 10115, 10261 are the top three

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with top three employee numbers.
select *
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%12-25';   -- 10261, 10438, 10681 are the top three employees

-- Find all unique last names that have a 'q' in their last name.
select distinct last_name
from employees
where last_name like '%q%';

-- Find all unique last names that have a 'q' in their last name but not 'qu'.
select distinct last_name
from employees 
where last_name like '%q%'
and last_name not like '%qu%';

/* Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
In your comments, answer: What was the first and last name in the first row of the results? 
What was the first and last name of the last person in the table? */
select *
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
order by first_name ASC;  -- the first person was Irena Reutenauer and the last person was Vidya Simmen

/* Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results 
returned by first name and then last name. 
In your comments, answer: What was the first and last name in the first row of the results? 
What was the first and last name of the last person in the table? */
select *
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
order by first_name ASC, last_name ASC; -- the first person is Irena Acton and the last person is Vidya Zweizig

/* Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your 
results returned by last name and then first name. 
In your comments, answer: What was the first and last name in the first row of the results? 
What was the first and last name of the last person in the table? */
select *
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
order by last_name ASC, first_name ASC; -- Irena Acton is the first person and Maya Zyda is the last person

/* Write a query to to find all employees whose last name starts and ends with 'E'. 
Sort the results by their employee number. Enter a comment with the number of employees returned, 
the first employee number and their first and last name, and the last employee number with 
their first and last name. */
select emp_no, first_name, last_name
from employees
where last_name like 'E%'
	and last_name like '%E'
order by emp_no ASC; -- 899 employees returned. The first employee returned was Ramzi Erde (10021) and the last was Tadahiro Erde (499648)

/* Write a query to to find all employees whose last name starts and ends with 'E'. 
Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number 
of employees returned, the name of the newest employee, and the name of the oldest employee. */
select *
from employees
where last_name like 'E%'
	and last_name like '%E'
order by hire_date DESC; -- 899 employees returned. The newest employee is Teiji Eldridge and the oldest employee is Sergi Erde

/* Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee 
who was hired last is the first result. Enter a comment with the number of employees returned, the name of the 
oldest employee who was hired last, and the name of the youngest employee who was hired first. */
select *
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%12-25'
order by birth_date asc, hire_date desc; -- 362 employees returned. The oldest person hired last is Khun Bernini, and the youngest person hired first is Douadi Pettis
