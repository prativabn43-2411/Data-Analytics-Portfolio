# single line comments
-- single line comments
/* 
Multiline 
comments

What is SQL ?
--SQL is a tool or query language
- Used in DBMS(database management system)
-- multiple uses-- feed the data,extract data,
manipulate , transform using SQL inside the 
database

Structured Query Language
- SQL can only be working upon
structured Database (tabular format data)
- Relational DBMS 
but 
- Unstructured data stored in Non relational 
DBMS
- No SQL is used

Non Relational Database can manage the Structured data as well but 
Vice Versa isnt possible.

Type of Statements
DML - ( Data Manipulation Language)-- Select,Insert,Update,Delete
DCL - ( Data Control Language)--Grant,Revoke
TCL - ( Transactional Control Language)-- Rollback,Commit
DDL - ( Data Definition Language)-- Create, Alter, Drop

DataWarehouse, OLAP, OLTP
*/


Create Database Batch_10;
use Batch_10;
drop database Batch_10; # deletes anything mentioned (table,database)

create table Students
(roll_no int, Student_name text, marks float);
#varchar -- you have to give no. of characters
#text-- you dont have to give.

insert into Students values
(1,"Prativa",90.7),
(2,"Upasana",80.7),
(3,"Supritee",85.6);

select * from Students;  # * is used to get all columns
Select roll_no from Students;
select * from Students
where roll_no = 1; #where is used for conditions

use batch_10;
CREATE TABLE Employees
(emp_id int )


INSERT INTO Employees VALUES
(101,'Rahul','Sales','Male',25,35000,'Delhi','2023-01-15'),
(102,'Priya','HR','Female',28,42000,'Mumbai','2022-06-10'),
(103,'Amit','IT','Male',30,55000,'Bangalore','2021-09-05'),
(104,'Sneha','Finance','Female',27,48000,'Kolkata','2023-03-20'),
(105,'Rohan','IT','Male',26,50000,'Hyderabad','2022-11-18'),
(106,'Anjali','Sales','Female',24,36000,'Delhi','2024-01-10'),
(107,'Karan','Marketing','Male',29,45000,'Pune','2021-08-12'),
(108,'Pooja','HR','Female',31,60000,'Chennai','2020-12-01'),
(109,'Vikas','Finance','Male',32,62000,'Mumbai','2019-07-22'),
(110,'Neha','IT','Female',23,40000,'Bangalore','2024-02-14');

select * from Employees;

use batch_10;
CREATE TABLE Employees1 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    city VARCHAR(50),
    salary INT,
    email VARCHAR(100)
);

INSERT INTO Employees1 VALUES
(1, 'ravi kumar', 'IT', 'Bangalore', 55000, 'ravi.kumar@company.com'),
(2, 'Priya Sharma', 'HR', 'Delhi', 42000, 'priya.sharma@company.com'),
(3, 'AMAN GUPTA', 'IT', 'Bangalore', 61000, 'aman.gupta@company.com'),
(4, 'Sneha Iyer', 'Sales', 'Mumbai', 38000, 'sneha.iyer@company.com'),
(5, 'karan mehta', 'IT', 'Pune', 72000, 'karan.mehta@company.com'),
(6, 'Divya Nair', 'HR', 'Delhi', 45000, 'divya.nair@company.com'),
(7, 'Rohit Verma', 'Sales', 'Mumbai', 40000, 'rohit.verma@company.com'),
(8, '  Anjali Singh  ', 'IT', 'Bangalore', 58000, 'anjali.singh@company.com');

select * from Employees1;

#total Salary
select sum(salary) as Total_salary from Employees1;

#Total Salary Department Wise
select department,sum(salary) as Total_Salary
from Employees1
group by department
order by Total_salary DESC;

#count(*)-- counts the null value as well
select count(*) from employees1;

#count-- count only rows where no null values are there
select count(emp_name) as total_employees from Employees1;

#count with distinct-- only give the count of unique values
select count(distinct department) from Employees1;

#Dept wise count
select department,count(department) as Total_count
from Employees1
group by department
order by Total_count DESC;

#average salary city wise in desc
select city,
round(avg(salary),2) as average_Salary
from Employees1
group by city
order by average_salary DESC;

#max as Highest Salary, min as lowest salary, dept wise
select department,
max(salary) as highest_salary,
min(salary) as Lowest_salary
from Employees1
group by department;

#having clause for condition(city wise salary only for >75K)
select city,
round(sum(salary),2) as total_salary_city_wise
from employees1
group by city
having total_salary_city_wise>75000
order by total_salary_city_wise desc;

#Text Functions
-- find Employees whose name contains "a"
select emp_name
from employees1
where emp_name like "%a%";

-- Find Employees whose name starts with "r"
select emp_name
from employees1
where emp_name like "r%";

-- Employees whose name ends with "r"
select emp_name
from employees1
where emp_name like "%r";

#trim the name-- removing extra spaces
select emp_name,
trim(emp_name) as updated_name
from Employees1;
#upper
select trim(emp_name) as updated_name,
upper(trim(emp_name)) as upper_case
from Employees1;

#lower
select trim(emp_name) as updated_name,
lower(trim(emp_name)) as lower_case
from Employees1;

#lenght
select trim(emp_name) as updated_name,
length(trim(emp_name)) as Total_characters
from Employees1;

#Substring-- to Extract mentioned characters
select trim(emp_name) as updated_name,
substring(trim(emp_name),1,4) as Extracted_character
from Employees1;

#find first name from emp_name
select trim(emp_name) as updated_name,
substring_index(trim(emp_name)," ",1) as First_name
from Employees1;

#Find last name from emp_name
select trim(emp_name) as updated_name,
substring_index(trim(emp_name)," ",-1) as First_name
from Employees1;

#Ravi Kumar Pradhan
#1--Ravi
#2--Ravi Kumar
#-1-- Pradhan
#-2-- Prasad sahoo

#Concat-- (emp_name and Department)
select emp_id,
concat(trim(emp_name),"/",department) as emp_dept
from Employees1;

#replace (older domain with newdomain(newcompany.com)
select email,
replace(email,"company.com","newcompany.com") as updated_email
from Employees1;

#emp_name-- First letter capital for first name
select trim(emp_name),
concat(
upper(substring(trim(emp_name),1,1)),
lower(substring(trim(emp_name),2))
) as updated_name
from Employees1;










