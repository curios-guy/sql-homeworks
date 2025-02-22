use TSQLV6;

SELECT 
 productid
From Production.Products

Select top 10 percent * from production.products

select 1 as num, * from production.products;

select 1 as num, productid as ID from Production.Products;

select ID = productid, * from Production.Products;

select productid as ID, * from Production.Products;


select *, unitprice * 2 as price2 from Production.Products;

select P.productid from Production.Products as P;

select distinct supplierid, categoryid from production.Products;

select distinct productid, supplierid, categoryid from Production.Products;

/* WHERE */ 
-- to filter information or data
-- ULTIMATE ORDER
/* SELECT
FROM
WHERE
GROUP BY 
HAVING
ORDER BY */


select * from Sales.orders 
where 
	freight > 100 and 
	shipcountry = 'Brazil' and
	empid in (1,2,3,4);

--or
select * from Sales.orders 
where 
	freight > 100 and 
	shipcountry = 'Brazil' and
	(empid = 1 or
	empid = 2 or
	empid = 3 or
	empid = 4 );

select * from Sales.orders 
where 
--shipperid != 1
shipperid <> 1

-- AND, OR, NOT, BETWEEN, IN
-- =, <> or !=, <, >, <=, >=

select distinct empid 
from Sales.Orders
where 
	empid between 3 and 5;

-- same as

select distinct empid 
from Sales.Orders 
where
	empid >=3 and empid <= 5;


create table numss(
	num int
)

insert into numss
values (1), (2), (3), (4), (5), (6);

SELECT *, NULL AS Col1
from numss
where num % 2 != 0 AND num % 3 != 0 
union all
select *, 'HI BYE' as Col1
from numss 
where num % 2 = 0 and num % 3 = 0
union all
select *, 'HI' as Col1
FROM numss
where num % 2 = 0 AND num % 3 != 0
union all
select *, 'BYE' as Col1
from numss
where num % 3 = 0 and num % 2 != 0
order by num



/* 
SELECT everything from table if id is prime number 
*/

/* GROUP BY */ 
-- alternative of distinct, to group data

Select distinct empid
from sales.orders

select empid
from sales.orders
group by empid

/* AGGREGATE functions: SUM, COUNT, MAX, MIN ... */
select count(*)
from sales.orders;

select empid, count(*) as cnt
from sales.orders
group by empid;

select count(*) as cnt
from sales.orders
where empid = 1;


SELECT empid,  COUNT(*) as cnt
FROM [Sales].[Orders]
--WHERE cnt > 50
GROUP BY empid
HAVING cnt > 50;

--invalid column name 'cnt'

/* Syntax order:

SELECT <COLUMNS>
FROM <TABLE NAME>
WHERE <FILTERING CONDITION>
GROUP BY <COLUMNS>
HAVING <FILTERING CONDITION>
ORDER BY
*/


/* Execution order:

FROM <TABLE NAME>
WHERE <FILTERING CONDITION>
GROUP BY <COLUMNS>
HAVING <FILTERING CONDITION>
SELECT <COLUMNS>
ORDER BY
*/

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
WHERE 2 * unitprice > 100
ORDER BY supplierid desc, Price2

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
WHERE 2 * unitprice > 100
ORDER BY discontinued, Price2 DESC;

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
WHERE 2 * unitprice > 100
ORDER BY 2 DESC;

Select 
top 5 *
from Production.Products
where supplierid in (1,2,3,4)
--order by unitprice

/* OFFSET and FECTH */

/*
...
ORDER BY <COLUMNS> [ASC, DESC]
OFFSET <n_rows to skip> {ROW|ROWS}
FETCH {FIRST|NEXT} <n_rows to select> {ROW|ROWS} ONLY
*/

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
ORDER BY productid
OFFSET 1 ROW FETCH NEXT 10 ROWS ONLY;

select *, 2 * unitprice as Price2
from Production.Products
order by productid
OFFSET 1 ROW fetch next 10 rows only;

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
ORDER BY productid
OFFSET 1 ROW FETCH NEXT 30 ROWS ONLY;

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
ORDER BY productid
OFFSET 1 ROW FETCH FIRST 10 ROWS ONLY;
--A TOP can not be used in the same query or sub-query as a OFFSET.


select 
	n,
	case when n % 2 = 0 then 'juft' else 'toq' end as 'col1'
from nums;

select n,
	IIF(n % 2 = 0, 'juft', 'toq')
from nums;

select * from nums