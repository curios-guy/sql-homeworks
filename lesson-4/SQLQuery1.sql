use lesson4;
use lesson3;

select getdate()

-- Aggregate Functions
-- 1. COUNT()
-- 2. SUM()
-- 3. AVG()
-- 4. MIN()
-- 5. MAX()
-- 6. STRING_AGG()

select * from Products;
select count(ProductName) from Products;
--58:00


select
	category,
	STRING_AGG(ProductName, '--') within group (order by productid)
from products
group by category;

select * from Products;

select 
	STRING_AGG(ProductName, '--') within group (order by productid)
from products;

select category, STRING_AGG(ProductName, '--') from products group by category;

-- Question

create table agents
(
	name varchar(50),
	office varchar(50),
	isheadoffice varchar(3)
);

insert into agents
values
	('Rich', 'UK', 'yes'),
	('Rich', 'US', 'no'),
	('Rich', 'NZ', 'no'),
	('Brandy', 'US', 'yes'),
	('Brandy', 'UK', 'no'),
	('Brandy', 'AUS', 'no'),
	('Karen', 'NZ', 'yes'),
	('Karen', 'UK', 'no'),
	('Karen', 'RUS', 'no'),
	('Mary', 'US', 'yes'),
	('Mary', 'UK', 'no'),
	('Mary', 'CAN', 'no'),
	('Charles', 'US', 'yes'),
	('Charles', 'UZB', 'no'),
	('Charles', 'AUS', 'no');

select * from agents;

-- Find agents who has head office in 'US' and also regular office in 'UK';
--Brandy
--Mary

select *,
	case
		when office = 'US' and isheadoffice = 'yes' then 'yes'
		when office = 'UK' and isheadoffice = 'yes' then 'no'
	end as balance
from agents;

SELECT *, 
       CASE 
           WHEN office = 'US' AND isheadoffice = 'yes' THEN 'Head Office'
           WHEN office = 'UK' AND isheadoffice = 'yes' THEN 'Head Office'
           ELSE 'Not Head Office'
       END AS office_status
FROM agents;

-- Question 2
create table parent
(
	pname varchar(50),
	cname varchar(50),
	gender char(1)
);

insert into parent
values
	('Karen', 'John', 'M'),
	('Karen', 'Steve', 'M'),
	('Karen', 'Ann', 'F'),
	('Rich', 'Cody', 'M'),
	('Rich', 'Stacy', 'F'),
	('Rich', 'Mike', 'M'),
	('Tom', 'John', 'M'),
	('Tom', 'Ross', 'M'),
	('Tom', 'Rob', 'M'),
	('Roger', 'Brandy', 'F'),
	('Roger', 'Jennifer', 'F'),
	('Roger', 'Sara', 'F')


select 
	pname, 
	count(gender) as number_of_children, 
	count(distinct gender) as child_gender, 
	IIF(count(distinct gender) = 2, 'male and female', 'male/female') as smt
from parent 
group by pname;

select * from parent;

select count(gender) as ji, count(distinct gender) as wq
from parent;

-- Number Functions
-- 1. SQRT
select sqrt(4);
select sqrt(10);

select *, sqrt(price) as rooted_price from Products

-- 2. ABS
select ABS(-10);
select ABS(10);

-- 3. ROUND
select *, round(sqrt(price), 2) as rounded_rooted from Products

-- 4. CEILING - yuqoriga yaxlitlash
select ceiling(1.1);

-- 5. FLOOR - quyiga yaxlitlash
select floor(1.9);

-- 6. POWER
select POWER(2, 5)

-- 7. EXP => value of e
select EXP(1)

-- 8. LOG = LN
--select LOG(100, 10)
select log(exp(1))

-- 9. LOG10
select LOG10(100)

-- 10. SIGN

select sign(-10), sign(0), sign(100)

-- 11. RAND - (0, 1)
select RAND()

select ceiling(100 * rand())

-- ================================================
-- String Functions

-- 1. LEN
select productname, len(productname) from Products

-- 2. LEFT/RIGHT
select productname, 
	len(productname),
	left(productname, 3),
	right(productname, 2)
from Products

-- 3. SUBSTRING

select productname, 
	len(productname),
	left(productname, 3),
	right(productname, 3),
	SUBSTRING(productname, 2, 3),
	SUBSTRING(productname, -2, 5)
from Products;

select
	productname
from Products;

-- 4. REVERSE
select productname, REVERSE(SUBSTRING(productname, 2, 2)) from Products

-- 5. CHARINDEX
select productname, CHARINDEX('o', productname) from Products

select 'demo coffe', CHARINDEX('o', 'demo coffe'), CHARINDEX('o', 'demo coffe', 5)

select 'demo coffe', CHARINDEX('o', 'demo coffe', CHARINDEX('o', 'demo coffe')+1)


-- 6. REPLACE
select replace('sql server 2019', '2019', '2022')

select productname from Products

select replace(productname, 'o', '*') from Products

-- 7. TRIM, LTRIM, RTRIM

select '     something         ', 
	ltrim('     something         '),
	rtrim('     something         '),
	TRIM('     something         '),
	ltrim(rtrim('     something         '))


-- 8. UPPPER/LOWER
select 
	productname, 
	UPPER(productname), 
	LOWER(productname) 
from Products

-- 9. CONCAT
select 'Hello ' + 'World'
select CONCAT('Hello ', 'World', ' Another')

select trim(CONCAT('Hello ', NULL, space(10), trim('        World')))
select 'Hello ' + NULL + ' World'

-- 10. STRING_AGG()

-- 11. SPACE
select 'Hello' + space(10) + 'World'

-- 12. REPLICATE

select 'apple' * 10
--Conversion failed when converting the varchar value 'apple' to data type int.
select replicate('apple ', 10)

-- 13.STRING_SPLIT

SELECT value, ordinal+2 FROM string_split('apple,banana,lemon', ',', 1);

SELECT * FROM string_split('apple,banana,lemon', ',');

-- 1. GETDATE(), CURRENT_TIMESTAMP
select GETDATE(), CURRENT_TIMESTAMP

-- 2. MONTH, YEAR, DAY
select getdate(), year(getdate()), month(getdate()), day(getdate())
select year('2025-02-19 22:07:02.063')

-- 3. Ikki sana orasadagi vaqt
select DATEDIFF(DAY,'2023-03-20', '2025-02-19');
select DATEDIFF(MONTH,'2023-03-20', '2025-02-19');
select DATEDIFF(YEAR,'2023-03-20', '2025-02-19');

-- 4. Sanani ustiga ma'lum bir muddat qo'shish

select * from table
where sana between DATEADD(MINUTE,-5,GETDATE()) and getdate()

-- 5. EOMONTH
select getdate(), EOMONTH(getdate())


-- CAST
--select cast(<value> as <datatype>)

select cast('a' as int)
select 'a' * 5

select try_cast('a' as int), try_cast('54' as int)

-- Homework:

create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

select * from letters order by letter;

--letter

--b
--a
--a
--a
--c
--d
--e
--f

-- 1. Order by with letter but 'b' must be first/last
-- 2. Order by with letter but 'b' must be 2nd

--a
--b
--a
--a
--c
--d
--e
--f

-- Window Functions




CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

select * from [dbo].[TestMultipleZero]


CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

select * from TestMax

--2001 101
--2002 103
--2003 89
--2004 91






-- Date and/or Time Functions



