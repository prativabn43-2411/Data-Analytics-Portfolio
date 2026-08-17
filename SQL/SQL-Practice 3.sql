/* ============================================================
   PRACTICE ASSIGNMENT: CONSTRAINTS (PK, FK, NOT NULL, UNIQUE,
   CHECK, DEFAULT) ACROSS FOUR CONNECTED TABLES
   Scenario: Library Management System

   Tables and how they connect:
     Authors  --(author_id)-->  Books
     Books    --(book_id)-->    Transactions
     Members  --(member_id)-->  Transactions

   So Transactions is linked to BOTH Books and Members.
   ============================================================

   WHAT YOU NEED TO DO:
   1. Write the CREATE TABLE statement for each table below,
      following the constraint requirements given in the comments.
   2. Insert 10 rows of realistic data into EACH table.
   3. Create tables and insert data in this ORDER: Authors, Books,
      Members, Transactions (parent tables must exist and have
      data before child tables can reference them).
   4. Write the constraint-violation INSERT statements to test
      each constraint (they should fail when run).
   ============================================================ */


/* ------------------------------------------------------------
   TABLE 1: Authors  (Parent table)
   ------------------------------------------------------------
   1. author_id     -> uniquely identifies each author, cannot be empty
   2. author_name   -> cannot be left empty
   3. country        -> should default to 'India' if not specified
   4. birth_year     -> must only allow years between 1800 and 2015

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */
create table Authors(
author_id int Primary key,
author_name Varchar(50) not null,
country varchar(50) default "India",
birth_year int check (birth_year between 1800 and 2015)
);


/* Insert 10 rows into Authors.
   At least 2 rows should rely on the DEFAULT country. */
insert into Authors values
(101,"Dillip Kumar","USA",1895),
(102,"Dipti Ranjan","England",1960),
(103,"Anshit Kumar","Russia",1965),
(104,"Dibya Jyoti","Japan",1970),
(105,"Prativa B","India",1975),
(106,"Swarna Prava","USA",1980),
(107,"Sukanti Lata","Canada",2000),
(108,"Disha Singh","England",2010);

select * from Authors;

insert into Authors(
author_id,author_name,birth_year) values
(109,"Tuhina Murudi",2003),
(110,"Lipsa Singh",2005);


/* ------------------------------------------------------------
   TABLE 2: Books  (Child of Authors)
   ------------------------------------------------------------
   1. book_id         -> uniquely identifies each book, cannot be empty
   2. title            -> cannot be left empty
   3. isbn              -> must be unique across all books
   4. price              -> must only allow positive values, and
                             should default to 299.00 if not specified
   5. published_year     -> must only allow years between 1900 and 2026
   6. author_id           -> must reference a valid author from the
                              Authors table (Foreign Key)

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */
   
create table Books(
book_id int primary key,
title Varchar(50) not null,
isbn Varchar(50) unique,
price float default 299.00 check (price>0),
published_year int check (published_year between 1900 and 2026),
author_id int,
foreign key (author_id) references authors(author_id)
);


/* Insert 10 rows into Books.
   Distribute books across the author_id values from Authors.
   At least 2 rows should rely on the DEFAULT price. */
   
insert into books values
(1, 'The Silent River', 'ISBN001',399.00,2000, 101),
(2, 'Wings of Hope', 'ISBN002',440.00,2003, 102),
(3, 'The Lost Kingdom', 'ISBN003',560.00,2007, 103),
(4, 'Beyond the Stars', 'ISBN004',545.00,2010,104),
(5, 'A New Beginning', 'ISBN005',299.00,2015, 105),
(6, 'Mystery of the Night', 'ISBN006',560.00,2025,101),
(7, 'Journey Within', 'ISBN007',645.00,2008, 102),
(8, 'The Hidden Truth', 'ISBN008', 345.00,2012, 103);

select * from Books;

insert into books(
book_id,title,isbn,published_year,author_id) values
(9,'Dreams And Destiny','ISBN009',2013,106),
(10,'Echoes of time','ISBN010',2016,107);

/* ------------------------------------------------------------
   TABLE 3: Members  (Parent table)
   ------------------------------------------------------------
   1. member_id      -> uniquely identifies each member, cannot be empty
   2. member_name    -> cannot be left empty
   3. age              -> must only allow members aged 12 or older
   4. email             -> must be unique across all members
   5. membership_type   -> should default to 'Standard' if not specified

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */
create table Members(
member_id int primary key,
member_name Varchar(50) not null,
age int check (age>=12),
email varchar(50) unique,
membership_type varchar(50) default "Standard");



/* Insert 10 rows into Members.
   At least 2 rows should rely on the DEFAULT membership_type.
   At least 1 row should have a NULL email (optional but unique
   when provided). */

insert into Members values
(1, 'Prativa', 23, 'prativa@gmail.com', 'Premium'),
(2, 'Upasana', 22, 'upasana@gmail.com', 'Standard'),
(3, 'Krishna', 24, 'krishna@gmail.com', 'Premium'),
(4, 'Deepti', 25, 'deepti@gmail.com', 'Standard'),
(5, 'Nishith', 29, 'nishith@gmail.com', 'Gold'),
(6, 'Hemant', 26, 'hemant@gmail.com', 'Premium'),
(7, 'Shiba', 25, 'shiba@gmail.com', 'Standard'),
(8, 'Aman', 27, 'aman@gmail.com', 'Gold');

select * from Members;
insert into Members(
member_id,member_name,age,email) values
(9,'Rajmeer',23,'rajmeer@gmail.com'),
(10,'Amrit',24,'amrit@gmail.com');

insert into Members 
values (11, 'Dibya', 25,null,'Standard');

/* ------------------------------------------------------------
   TABLE 4: Transactions  (Child of Books AND Members)
   ------------------------------------------------------------
   1. transaction_id  -> uniquely identifies each transaction, cannot be empty
   2. book_id           -> must reference a valid book from the
                            Books table (Foreign Key)
   3. member_id          -> must reference a valid member from the
                             Members table (Foreign Key)
   4. issue_date          -> cannot be left empty
   5. return_date          -> no constraint (can be NULL if not yet returned)
   6. status                -> should default to 'Issued' if not specified
   7. fine                   -> must only allow values of 0 or more, and
                                 should default to 0.00 if not specified

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */

create table Transactions (
    transaction_id int primary key,
    book_id int not null,
    member_id int not null,
    issue_date date not null,
    return_date date,
    status Varchar(30) default 'Issued',
    fine float default 0.00 CHECK (fine >= 0),
    foreign key (book_id) references Books(book_id),
    foreign key (member_id) references Members(member_id)
);


/* Insert 10 rows into Transactions.
   Mix book_id and member_id values from the tables above.
   At least 2 rows should rely on the DEFAULT status and/or fine.
   At least 2 rows should have a NULL return_date (not yet returned). */

insert into Transactions values
(1, 1, 1, '2026-01-05', '2026-01-15', 'Returned', 0.00),
(2, 2, 2, '2026-01-10', '2026-01-20', 'Returned', 25.00),
(3, 3, 3, '2026-02-01', NULL, 'Issued', 0.00),
(4, 4, 4, '2026-02-05', '2026-02-18', 'Returned', 10.00),
(5, 5, 5, '2026-02-15', NULL, 'Issued', 0.00),
(6, 6, 6, '2026-03-01', '2026-03-12', 'Returned', 0.00),
(7, 7, 7, '2026-03-05', NULL, 'Issued', 0.00),
(8, 8, 8, '2026-03-10', '2026-03-25', 'Returned', 50.00);

select * from Transactions;

insert into Transactions(
transaction_id,book_id,member_id,issue_date,return_date) values
(9,9,9,'2026-04-01','2026-04-25'),
(10,10,10,'2026-05-04','2026-05-26');



/* ============================================================
   CONSTRAINT-BREAKING DEMOS
   Write ONE INSERT statement for each case below. Run it,
   note the error, then write down (as a comment) which
   constraint caused it to fail.
   ============================================================ */

-- 1. Insert an Author with a NULL author_name
insert into Authors 
values (108,Null,"England",108);

-- 2. Insert an Author with birth_year = 1750 (violates CHECK)
insert into Authors 
values (105,"Prativa B","India",1750);

-- 3. Insert a Book with a duplicate isbn
insert into Books
values (11, 'The Hidden Truth', 'ISBN001', 345.00,2012, 103);

-- 4. Insert a Book with price = -100 (violates CHECK)
insert into Books
values (9, 'The Broken Price', 'ISBN009', -100.00, 2020, 101);

-- 5. Insert a Book with an author_id that does not exist in Authors
--    (violates FOREIGN KEY)
insert into Books
values (9,'The Unknown Author', 'ISBN009', 350.00, 2020, 200);

-- 6. Insert a Member with a duplicate member_id
insert into members
values (1, 'Supritee', 25, 'supritee@gmail.com', 'Standard');

-- 7. Insert a Member with age = 9 (violates CHECK)
insert into members
values  (1, 'Supritee', 8, 'supritee@gmail.com', 'Standard');

-- 8. Insert a Member with a duplicate email
insert into members
values (1, 'Prativa', 23, 'upasana@gmail.com', 'Premium');

-- 9. Insert a Transaction with a book_id that does not exist in Books
--    (violates FOREIGN KEY)
insert into Transactions
values (11,'The Hidden Truth', 'ISBN008', 345.00,2012, 103);

-- 10. Insert a Transaction with a member_id that does not exist in Members
--     (violates FOREIGN KEY)
insert into Transactions
values (15, 'Aman', 27, 'aman@gmail.com', 'Gold');

-- 11. Insert a Transaction with a NULL issue_date
insert into Transactions
values (11, 11, 11,null, '2026-03-25', 'Returned', 50.00);

-- 12. Insert a Transaction with fine = -50 (violates CHECK)
insert into Transactions
values (12, 12, 12, '2026-03-01', '2026-03-12', 'Returned', -50.00);
