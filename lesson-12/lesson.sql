use lesson12;

-- Stored Procedure

/*
CREATE PROC/PROCEDURE <name>
AS
BEGIN
	<statement 1>
	<statement 2>
	<statement 3>
END;

EXEC <name>
EXECUTE <name>
*/
go
ALTER procedure sp_tvs @some_int int
as 
begin
	create table #temp(
		number int,
		text varchar(50)
	);
	insert into #temp
	select top 100 BusinessEntityID, FirstName from [AdventureWorks2022].[Person].[Person];

	select * from #temp;
end;
GO

truncate table lesson12;

go
create procedure sp_tvs @some_int int
as 
begin
	create table #temp(
		number int,
		text varchar(50)
	);
	insert into #temp
	select top 100 BusinessEntityID, FirstName from [AdventureWorks2022].[Person].[Person];

	select * from #temp;
end;
go

execute sp_tvs 23












alter procedure sp_sales_for_date @date_key int
as
begin
	create table #temp
	(
		ProductKey int,
		UnitPrice decimal(10, 2),
		ExtendedAmount decimal(10, 2)
	);

	insert into #temp
	select 
		ProductKey, 
		UnitPrice,
		ExtendedAmount
	from [AdventureWorksDW2019].[dbo].[FactInternetSales]
	where OrderDateKey=@date_key;

	select * from #temp;
end

go


EXECUTE sp_sales_for_date @date_key=20110111;

GO

ALTER procedure [dbo].[sp_sales_for_date]
as
begin
	create table #temp
	(
		ProductKey int,
		UnitPrice decimal(10, 2),
		ExtendedAmount decimal(10, 2),
		OrderDateKey int
	);

	insert into #temp
	select 
		ProductKey, 
		UnitPrice,
		ExtendedAmount,
		OrderDateKey
	from [AdventureWorksDW2019].[dbo].[FactInternetSales]
	where OrderDateKey=20110111;

	select * from #temp;
end;


-- IF and WHILE

declare @num int = 11;

if @num % 2 = 0
begin
	PRINT 'Juft Son'
end
else
begin
	PRINT 'Toq Son'
end;

go

declare @num int = 0;

while @num < 10
begin
	select @num;
	
	set @num = @num + 1;

	--select @num = @num + 1;
end;
go
create procedure sp_generate_num @num int
as
begin
	declare @upto int = 0
	declare @numbers table (num int);

	while @upto <= @num
	begin
		insert into @numbers
		select @upto

		set @upto = @upto + 1;

	end;
	select num from @numbers
end;
go

exec sp_generate_num 20

create table emp(
	id int,
	name varchar(50)
)

insert into emp
values 
	(1, 'name1'),
	(4, 'name4'),
	(7, 'name7'),
	(11, 'name11'),
	(19, 'name19')

declare @t table (
	num int
)
insert into @t
execute sp_generate_num 20

select num from @t
left join emp
on num = emp.id
where emp.id is null
select * from emp
left join @t 
on emp.id = @t.num

-- BREAK - loopni sindiradi
go

declare @num int = 0;

while @num < 10
begin
	PRINT @num;
	
	set @num = @num + 1;

	if @num = 5
		break
end;


-- CONTINUE - loopni bitta qadamini sindiradi
go

declare @num int = 0;

while @num < 10
begin
	
	set @num = @num + 1;
	PRINT @num;

	if @num = 5
		continue

	print 'nimadir';
end;



--======================================
--Dynamic SQL
--======================================

declare @sql_cmd varchar(max) = 'SELECT * FROM '

set @sql_cmd = @sql_cmd + 'emp'

exec(@sql_cmd)

go 
create proc sp_call_for_action @table_name varchar(max), @top_k int
as
begin
declare @sql_command varchar(max) = 'SELECT top ' + cast(@top_k as varchar(20)) + ' * FROM  '

set @sql_command = @sql_command + @table_name

exec(@sql_command)
end

execute sp_call_for_action '[AdventureWorks2022].[Person].[Person]'
--use CONCAT and distinct variable like Mardon did

--FOR EDITING
GO

ALTER proc [dbo].[sp_call_for_action] @table_name varchar(max), @top_k int = NULL
as
begin
if @top_k is not NULL
begin
	declare @sql_command varchar(max) = 'SELECT top ' + cast(@top_k as varchar(20)) + ' * FROM  '

	set @sql_command = @sql_command + @table_name

	exec(@sql_command)
end
else 
begin
	declare @sql_command2 varchar(max) = 'SELECT * FROM  '

	set @sql_command2 = @sql_command2 + @table_name

	exec(@sql_command2)
end
end
GO





--============================
--WHATEVER THIS IS

select 
	TABLE_CATALOG as DatabaseName,
	TABLE_SCHEMA as SchemaName,
	TABLE_NAME as TableName,
	COLUMN_NAME as ColumnName,
	concat(
		DATA_TYPE,'('+ 
			case when cast(CHARACTER_MAXIMUM_LENGTH as varchar) = '-1'
			then 'max'
			else cast(CHARACTER_MAXIMUM_LENGTH as varchar) end
		+')'
	) as DataType
from class10.INFORMATION_SCHEMA.COLUMNS;


declare @name varchar(255);
declare @i int = 1;
declare @count int;
select @count = count(1)
from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')


while @i < @count
begin
	;with cte as (
		select name, ROW_NUMBER() OVER(order BY name) as rn
		from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')
	)
	select @name=name from cte
	where rn = @i;

	--select 
	--	TABLE_CATALOG as DatabaseName,
	--	TABLE_SCHEMA as SchemaName,
	--	TABLE_NAME as TableName,
	--	COLUMN_NAME as ColumnName,
	--	concat(
	--		DATA_TYPE,'('+ 
	--			case when cast(CHARACTER_MAXIMUM_LENGTH as varchar) = '-1'
	--			then 'max'
	--			else cast(CHARACTER_MAXIMUM_LENGTH as varchar) end
	--		+')'
	--	) as DataType
	--from @name.INFORMATION_SCHEMA.COLUMNS;


	set @i = @i + 1;

end