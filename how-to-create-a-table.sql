-- 13 mar
create table quote (
id int not null auto_increment,
author VARCHAR(50) not null, 
content VARCHAR(240) not null,
primary key(id));

describe quote; 

alter table quotes
add unique (content);

create table authorz (
id int not null auto_increment,
first_name varchar(100) not null,
last_name varchar(100) not null,
primary key (id),
unique (first_name, last_name)
);

describe authorz;
use employees;
show create table dept_emp; -- primary key linked from employees and departments
/*CREATE TABLE `dept_emp` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_emp_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_emp_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1 */

describe authors; -- has primary key (id), has a mul key or index as multiple occurances non-unique values are permitted (names)
describe departments; -- has a primary key (dept_no) and a uni key or index and is the fist column of a unique index. multiple instances of null are permitted
describe dept_emp; --  has two primary keys from other tables, linking the two together making them foreign keys
describe  dept_manager; -- has two primary keys from other tables (emp_no and dept_no) these link the tables together making them foreign keys
describe employees; -- has one primary key emp_no, no other indexes are present
describe salaries; -- has two primary keys linking two tables together
show create table salaries;
/*CREATE TABLE `salaries` (
  `emp_no` int NOT NULL,
  `salary` int NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`from_date`),
  CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1 */

describe titles; -- has three primary keys linking multiple tables together 
show create table titles;
/* CREATE TABLE `titles` (
  `emp_no` int NOT NULL,
  `title` varchar(50) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date DEFAULT NULL,
  PRIMARY KEY (`emp_no`,`title`,`from_date`),
  CONSTRAINT `titles_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1 */