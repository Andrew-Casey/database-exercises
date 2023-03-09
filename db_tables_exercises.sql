-- list all the databases
SHOW DATABASES;
-- use the sql code necessary to use the albums_db database
USE albums_db;
-- show the currently selected database
SELECT database();
-- list all tables in the database
SHOW tables;
-- write the sql code to switch the employees database
USE employees;
-- show the currently selected database
select database();
-- list all the tables in the database
SHOW tables; 

-- Explore the employees table. 
SHow create table employees;
/* CREATE TABLE `employees` (
  `emp_no` int NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 
*/

-- Which tables do you think contain a numeric type column?
-- Which table(s) do you think contain a string type column?
-- Which table(s) do you think contain a date type column? 

-- employees contain first and last name in (varchar), emp_no as the primary key in int, gender in enumeration limitation as M or F, and hire date as date
-- departments contain dept num as char limited to 4 characters, dept name as varchar limited to 40 characters, primary key is dept no
-- dept_emp contains date, integers and char data
-- dept_manager contains integers, char (4) date data
-- salaries contains integers, dates
-- titles contains integers, varchar, date data


/* What is the relationship between the employees and the departments tables? 
The relationship between employees and departments tables are a combined 
dept_emp table with emp_no and dept_no being the linking variable */

/* Show the SQL that created the dept_manager table. 
Write the SQL it takes to show this as your exercise solution. 
 CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL, 
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1 */