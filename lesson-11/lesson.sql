use lesson11;
use lesson10;
--;WITH cte AS (	
--SELECT 1 AS days	
--UNION ALL	
--SELECT days + 1 FROM cte	
--WHERE days < 40),
--AdjustedTable AS (	
--SELECT top 40 		
--C.days AS Days,		
--ISNULL(S.Num, 0) AS Numbers,		
--ROW_NUMBER() OVER(ORDER BY ISNULL(S.Num, 0)) rnk,		
--count(days) over() as total	FROM cte C	LEFT JOIN Shipments S		
--ON C.days = S.N	order by rnk), cte2 as (	
--select *, count(1) over() as cnt	
--from AdjustedTable)

--select * from cte2 order by rnkSELECT 	avg(Numbers*1.0) as medianFROM cte2where rnk IN (	(cnt + 1) / 2,	cnt / 2  + 1);
--1
--2
--3
--4
--5

--select (5+1) / 2 -- 3
--select 5 / 2 + 1 -- 3

--1
--2
--3
--4
--5
--6

--select (6+1) / 2 -- 3
--select 6 / 2 + 1 -- 4

--========================================
--SQL VARIABLES
--========================================

declare @txt varchar(max) = 'TEsting';
--set @txt = 'test';
select @txt;

declare @num int;
select @num;
set @num = 1;
select @num;
select @num = 2;  --sets @num at 2
select @num;

declare @nummy int;
select 1, @nummy = 2;
--A SELECT statement that assigns a value to a variable must not be combined with data-retrieval operations.

DECLARE @num int;
declare @num int;
--The variable name '@num' has already been declared. Variable names must be unique within a query batch or stored procedure.

;with cte as (
	select 1 as n
	union all
	select n+ 1  from cte
	where n < 10
)
select * into numbers from cte


go
declare @num int = 0;
select @num = @num + n from numbers-- order by n desc;
select @num;

select * from numbers;

select @@SERVERNAME;
select @@IDENTITY;

create table emp
(
	id int primary key identity,
	name varchar(50)
);

insert into emp(name)
values ('asdas'), ('asdas')

select @@ROWCOUNT

select @@ERROR;  --returns the error code

select @@VERSION; --returns version of currrent server (my laptop)

select @@TRANCOUNT; --how many transactions are successully completed
select * from emp;

begin tran t1
insert into emp(name)
values ('adam');

commit tran t1;  --after 'begin' expression reaches the destination
rollback tran t1;	--before commiting the transaction, useful to put transaction in place


--===========Table Variable==============

--temp table
--table variable
create table newtable (
	name varchar (50)
)
declare @dept table (
	name varchar (20)
)

insert into @dept
values ('asdasda') 

select * from @dept;

--you can save the table variables values into existing new table;

insert into newtable 
select * from @dept

select * from newtable


--========================
--SQL server temporary tables
--========================
-- works during the sessions -that is opening the new page or new query

create table #sales(
	name varchar(20)
)

insert into #sales
values ('asdasda')

select * from #sales

--=============================
--SQL server Global Temp Table
--=============================
--works on every sessions, only discards when closing the SSMS
create table ##rec(
	name varchar (50)
)

insert into ##rec
values ('asdasdas'), ('asdasda')

select * from ##rec;

-- ==============================
-- SQL Server View
-- ==============================

CREATE VIEW SalesAnalysis AS
SELECT  
		dp.EnglishProductName,
		dd.EnglishDayNameOfWeek,
		dc.FirstName
FROM [AdventureWorksDW2019].[dbo].[FactInternetSales] fis
JOIN [AdventureWorksDW2019].[dbo].[DimProduct] dp
	on fis.ProductKey = dp.ProductKey
JOIN  [AdventureWorksDW2019].[dbo].[DimDate] dd
	on fis.OrderDateKey = dd.DateKey
JOIN [AdventureWorksDW2019].[dbo].[DimCustomer] dc
	on dc.CustomerKey = fis.CustomerKey

go

ALTER VIEW SalesAnalysisByDay AS
SELECT
		dd.EnglishDayNameOfWeek as NewColName,
		SUM(fis.ExtendedAmount) TotalSales
FROM [AdventureWorksDW2019].[dbo].[FactInternetSales] fis
JOIN  [AdventureWorksDW2019].[dbo].[DimDate] dd
	on fis.OrderDateKey = dd.DateKey
GROUP BY dd.EnglishDayNameOfWeek
go

select * from SalesAnalysisByDay

update SalesAnalysisByDay
set TotalSales = 0
where EnglishDayNameOfWeek = 'Wednesday'

-- Update or insert of view or function 'SalesAnalysisByDay' failed because it contains a derived or constant field.


select * from [AdventureWorksDW2019].[dbo].[FactInternetSales]