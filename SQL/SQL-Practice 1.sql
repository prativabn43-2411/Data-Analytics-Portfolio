/* ============================================================
   PRACTICE FILE: AGGREGATE FUNCTIONS & TEXT FUNCTIONS
   Table: Products
   Instructions: Write the SQL query below each question.
   ============================================================ */
#05/08/2026

/* ------------------------------------------------------------
   STEP 1: CREATE TABLE
   ------------------------------------------------------------ */
create database Practice;
use Practice;

CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50),
    city VARCHAR(50),
    price INT,
    description VARCHAR(100)
);


/* ------------------------------------------------------------
   STEP 2: INSERT DATA
   ------------------------------------------------------------ */

INSERT INTO Products VALUES
(1, 'wireless mouse', 'Electronics', 'Bangalore', 799, 'compact wireless mouse'),
(2, 'Office Chair', 'Furniture', 'Delhi', 4500, 'ergonomic office chair'),
(3, 'BLUETOOTH SPEAKER', 'Electronics', 'Bangalore', 2200, 'portable bluetooth speaker'),
(4, 'Study Table', 'Furniture', 'Mumbai', 3800, 'wooden study table'),
(5, 'laptop stand', 'Electronics', 'Pune', 1200, 'adjustable laptop stand'),
(6, 'Bookshelf', 'Furniture', 'Delhi', 3200, 'wall mounted bookshelf'),
(7, 'Table Lamp', 'Electronics', 'Mumbai', 950, 'LED table lamp'),
(8, '  Yoga Mat  ', 'Fitness', 'Bangalore', 600, 'non-slip yoga mat');

select * from Products;
/* ============================================================
   SECTION A: AGGREGATE FUNCTIONS
   ============================================================ */

-- Q1. Find the total number of products.
select
count(product_id) as Total_products 
from Products;

-- Q2. Find the total value of all products (sum of prices).
select 
sum(price) as Total_price 
from Products;

-- Q3. Find the average price of products.
select 
round(avg(price),2) as Average_price 
from Products;

-- Q4. Find the most expensive and least expensive product price.
select 
max(price) as highest_price,
min(price) as Lowest_price
from Products;

-- Q5. Find how many products exist in each category.
select category,
count(category) as Total_count
from Products
group by category
order by Total_count DESC;

-- Q6. Find the average price per city.
select city,
round(avg(price),2) as average_Price
from Products
group by city;

-- Q7. Find categories where the average price is more than 2000.
select Category,
round(avg(price),2) as Average_Price_category_wise
from Products
group by Category
having  Average_Price_category_wise>2000
order by  Average_Price_category_wise desc;

-- Q8. Find the total price of products per city, sorted from highest to lowest.
select city,
sum(price) as Total_price
from Products
group by City
order by Total_price desc;


-- Q9. Find the number of distinct cities the products are available in.
select count(distinct city) from Products;


/* ============================================================
   SECTION B: TEXT FUNCTIONS
   ============================================================ */

-- Q1. Display all product names in uppercase and lowercase.
select 
upper(trim(Product_Name)) as Upper_Name,
lower(trim(Product_name)) as Lower_Name
from Products;

-- Q2. Remove the extra spaces from the product_name column and display the cleaned result.
select product_name,
trim(Product_name) as Updated_name
from Products;

-- Q3. Find the length of each product_name (after removing spaces).
select product_name,
length(trim(Product_name)) as Updated_name
from Products;

-- Q4. Extract the first 5 characters of each description.
select description as Updated_description,
substring(Description,1,5) as  Updated_description
from Products;

-- Q5. Combine product_name and category into a single column separated by a hyphen.
Select Product_name,
concat(trim(Product_name),"-",category) as Product_category
from Products;

-- Q6. Replace the word 'table' with 'desk' in the description column.
select description,
replace(description,"table","desk") as updated_Description
from Products;

-- Q7. Convert each product_name into proper case (first letter capital, rest lowercase).
select trim(product_name),
concat(
upper(substring(trim(product_name),1,1)),
lower(substring(trim(product_name),2))
) as updated_name
from Products;

-- Q8. Find all products whose description contains the word 'wireless'.
select Description
from Products
where description like "%wireless%";

-- Q9. Find all products whose product_name starts with the letter 'B' (case-insensitive).
select Product_name
from Products
where Product_name like "B%";

#06/08/2026

create database Practice;
use Practice;

CREATE TABLE Orders (
    order_id INT,
    customer_name VARCHAR(50),
    order_date DATE,
    delivery_date DATE,
    order_time TIME,
    last_updated DATETIME
);

INSERT INTO Orders VALUES
(1, 'Ravi Kumar', '2025-01-15', '2025-01-20', '10:30:00', '2025-01-15 10:30:00'),
(2, 'Priya Sharma', '2025-03-22', '2025-03-25', '14:45:00', '2025-03-22 14:45:00'),
(3, 'Aman Gupta', '2025-06-10', '2025-06-18', '09:15:00', '2025-06-10 09:15:00'),
(4, 'Sneha Iyer', '2025-08-05', '2025-08-07', '18:00:00', '2025-08-05 18:00:00'),
(5, 'Karan Mehta', '2025-11-30', '2025-12-05', '11:20:00', '2025-11-30 11:20:00'),
(6, 'Divya Nair', '2026-02-14', '2026-02-16', '16:10:00', '2026-02-14 16:10:00'),
(7, 'Rohit Verma', '2026-05-01', '2026-05-03', '08:00:00', '2026-05-01 08:00:00'),
(8, 'Anjali Singh', '2026-07-10', NULL, '13:25:00', '2026-07-10 13:25:00');
select * from Orders;

#current Date/Time
select curdate() as Today,
curtime() as now_time,
now() as Current_date_time;

#Extraxt parts of a date (Year,Month,Day)
select order_date,
year(order_date) as order_year,
month(order_date) as order_month,
day(order_date) as order_day
from Orders;

#Get Dayname / Month Name
select Order_date,
dayname(order_date) as day_of_week,
monthname(order_date) as month_name
from orders;

#Add or Substract Days from a date
select Order_date,
date_add(order_date,interval 7 day) as add_7days,
date_sub(order_date,interval 7 day) as sub_7days
from Orders;

#Difference between two dates
select order_id,order_date,delivery_date,
datediff(delivery_date,Order_date) as Total_days
from Orders;

#Extract hour, minute, second from time
select order_time,
hour(order_time) as Order_hour,
minute(order_time) as Order_minute,
second(order_time) as Order_second
from orders;

#Format a date into custom display
select order_date,
date_format(order_date, "%d-%m-%Y") as formatted_date
from Orders;

#Find orders not yet delivered
select order_id,customer_name
from Orders
where delivery_date is Null;

#how old the order is from todays date
select order_id,order_date,
datediff(curdate(),order_date) as Days_ago
from Orders;

#Quarter of year
select Order_date,
quarter(order_date) as Quarter_of_year
from Orders;

#Add hours/minutes to a datetime
select last_updated,
date_add(last_updated,interval 2 hour) as updated_2_hour,
date_add(last_updated,interval 30 minute) as updated_30_minute
from Orders;

#week number of a date
select order_date,
week(order_date) as week_number_of_year
from orders;

#Find orders placed in a specific month and year
select order_id,customer_name
from orders
where month(order_date)= 6
and
year(order_date)= 2025;
