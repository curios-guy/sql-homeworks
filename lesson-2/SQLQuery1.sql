--create database lesson2;

/* COMMON DATA TYPES */

-- INTEGER
/*
1. TINYINT = (0, 255)
2. SMALLINT = (-32,..., 32,...)
3. INT = (-2B, 2B)
4. BIGINT = (-2^63, 2^63-1)
*/

create table forTest(
	id smallint primary key identity,
	price int,
	viewers bigint,
	budget tinyint
)

insert into forTest values(
	120000000, 200000000000000000, 213
)

select * from forTest;

-- DECIMAL
drop table if exists product;
create table product(
	id int primary key identity,
	name varchar(255),
	price decimal(5, 2)
);

insert into product
select 'cherry', 50.256;

SELECT * FROM product

-- FLOAT

drop table if exists product;
create table product(
	id int primary key identity,
	name varchar(255),
	price float
);

insert into product
select 'cherry', 50.256;

/* String */

/* CHAR(50), NCHAR(50), VARCHAR(50), NVARCHAR(50) */
/* TEXT, NTEXT */
/* NVARCHAR(MAX) */

drop table if exists blog;
create table blog(
	id int,
	title varchar(255),
	body varchar(MAX)
);

select * from blog;


/* DATE AND TIME */

/*
DATE = YYYY-MM-DD
TIME = HH:MM:SS
DATETIME = YYYY-MM-DD HH:MM:SS
*/

drop table person;
create table person(
	name varchar(50),
	birthday date,
	time_born time,
	overall datetime
)

insert into person values ('sallo', '1987-12-12', '12:21:12', '1987-01-11 12:21:12');

select * from person;

-- DATETIME
SELECT GETDATE();

--2025-02-14 20:34:50.883

create table orders
(
	item varchar(50),
	price int,
	created_datetime datetime
	--updated_datetime datetime
);

insert into orders
select 'apple', 1000, GETDATE();

insert into orders
values ('cherry', 3000, GETDATE());


SELECT * FROM orders;

SELECT GETDATE();
SELECT GETUTCDATE();
--2025-02-14 15:39:53.993

-- DATETIME2 => gives more precision to datetime milliseconds

/* GUID */
create table emp
(
	id UNIQUEIDENTIFIER,
	name varchar(50)
);

SELECT NEWID();

insert into emp
select 'D7950DDB-E289-41C1-9FF4-F36BE0FB1832', 'jane';

select * from emp;

--D7950DDB-E289-41C1-9FF4-F36BE0FB1832

/* IMAGE HANDLING */


create table file_handler(
	file_id int primary key identity,
	file_name nvarchar(100),
	file_type nvarchar(100),
	file_data varbinary(max)
)

insert into file_handler(file_name, file_type, file_data)
select 'something', '.pdf', * from openrowset(
	bulk 'C:\Users\user\Downloads\Week 1.pdf.pdf', single_blob
) as pdf_document;

insert into file_handler(file_name, file_type, file_data)
select 'image', 'png', * from openrowset(
	bulk 'C:\Users\user\Downloads\image.png', single_blob
) as img_file;

select * from file_handler;

select @@SERVERNAME
drop table employee;
create table employee(
	id int,
	name varchar(100)
);

BULK INSERT employee
FROM 'G:\AI and BI talents\sql\lesson-2\table.csv'
WITH (
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n'
);

--bulk insert employee 
--from '‪‪‪‪G:\AI and BI talents\sql\lesson-2\table.csv'
--with (
--	firstrow=2,
--	fieldterminator=',',
--	rowterminator='\n'
--);

select * from employee;

/* DROP vs DELETE vs TRUNCATE */

DELETE FROM employee WHERE id=2;
TRUNCATE TABLE employee;

SELECT * FROM employee;


DROP TABLE employee;

--28:00