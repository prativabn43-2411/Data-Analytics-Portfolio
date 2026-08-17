#Constraints
#Parent Table
create table Department(
dept_id int primary key,
dept_name Varchar(50) not null unique,
budget float default 100000.00 check(budget>0)
);
insert into Department values
(1,"HR",1500000.00),
(2,"IT",2000000.00),
(3,"Sales",2500000.00);

select * from Department;

#child table
Create table Employees2(
emp_id int primary key,
emp_name varchar(50) not null,
age int check(age>=18),
email varchar(50) unique,
salary int default 300000,
dept_id int,
Foreign key (dept_id) references Department(dept_id)
);

insert into Employees2
values
(101,"Ravi kumar",28,"ravi@gmail.com",450000,2),
(102,"Priya sharma",29,"priya@gmail.com",500000,1),
(103,"Aman Kumar",30,"aman@gmail.com",550000,3),
(104,"Sneha Iyer",32,"sneha@gmail.com",650000,1);

select * from Employees2;

insert into Employees2 -- Default constraint
(emp_id,emp_name,age,email,dept_id)
values
(105,"Shalini Jaiswal",25,"shalini@gmail.com",1);

insert into Employess2
values (101,"Test user",30,"test@gmail.com",500000,1); -- primary key violation

insert into Employees2
values (106,Null,30,"new@gmail.com",500000,1); -- not null violation

insert into Employees2
values(105,"Test user",11,"test@gmail.com",500000,1); -- check violation

insert into Employees2
values (106,"Test user",30,"ravi@gmail.com",500000,1); -- Unique violation

insert into Employees2
values (107,"Test user",30,"test@gmail.com",500000,5); -- Foreign key violation


