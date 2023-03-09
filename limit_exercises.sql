/* MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. 
For example, to find all the unique titles within the company, we could run the following query:*/

use employees;
select database();

Select distinct last_name
from employees
order by last_name desc
limit 10;

-- List the first 10 distinct last name sorted in descending order.
-- Zykh, Zyda, Zwicker. Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, Zongker

/* Find all previous or current employees hired in the 90s and born on Christmas. 
Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. 
Write a comment in your code that lists the five names of the employees returned.*/
select *
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%12-25'
order by hire_date asc
limit 5; -- Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup

/* Try to think of your results as batches, sets, or pages. The first five results are your first page. 
The five after that would be your second page, etc. Update the query to find the tenth page of results.*/
select *
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%12-25'
order by hire_date asc
limit 5 offset 45; -- Pranay Narwekar, Marjo Farrow, Ennio Karcich, Dines Lubachevsky, Ipke Fontan

/* LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET 
(number of results to skip), LIMIT (number of results per page), and the page number?*/
-- If I wanted to start on page 2 with a limit of 5, I would set the offset to 5. page 2 would start at 6-10