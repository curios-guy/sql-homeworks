use lesson12;

--TASK1--
DECLARE @sql NVARCHAR(MAX) = N''

SELECT @sql = @sql + '
SELECT 
    ''' + name + ''' AS DatabaseName, 
    s.name AS SchemaName, 
    t.name AS TableName, 
    c.name AS ColumnName, 
    ty.name AS DataType
FROM ' + QUOTENAME(name) + '.sys.schemas s
JOIN ' + QUOTENAME(name) + '.sys.tables t ON s.schema_id = t.schema_id
JOIN ' + QUOTENAME(name) + '.sys.columns c ON t.object_id = c.object_id
JOIN ' + QUOTENAME(name) + '.sys.types ty ON c.user_type_id = ty.user_type_id
' 
FROM sys.databases 
WHERE state_desc = 'ONLINE' AND name NOT IN ('master', 'tempdb', 'model', 'msdb')

EXEC sp_executesql @sql


--TASK2--


go
create proc sp_get_info @database_name varchar(90) = NULL
as
begin
	declare @sql_cmnd nvarchar(max) = N'';
	if @database_name is NULL
	begin
		select @sql_cmnd = @sql_cmnd + '
		select ''' + name + ''' as DatabaseName,
		p.name as Procedures,
		s.name as SchemaName, 
		par.name as Parameters,
		ty.name as TypeName,
		case
			when cast(par.max_length as varchar) = '''+ '-1' +''' then ''' + 'max' + '''
			else cast(par.max_length as varchar)
		end as MaxLength
		from ' + QUOTENAME(name) + '.sys.procedures p
		join ' + QUOTENAME(name) + '.sys.parameters par on p.object_id = par.object_id
		join ' + QUOTENAME(name) + '.sys.schemas s on s.schema_id = p.schema_id
		join ' + QUOTENAME(name) + '.sys.types ty on par.user_type_id = ty.user_type_id;'
		FROM sys.databases 
		WHERE state_desc = 'ONLINE' AND name NOT IN ('master', 'tempdb', 'model', 'msdb')
	end
	else
	begin
		select @sql_cmnd =  '
		select ''' + @database_name + ''' as DatabaseName,
		p.name as Procedures,
		s.name as SchemaName, 
		par.name as Parameters,
		ty.name as TypeName,
		case
			when cast(par.max_length as varchar) = '''+ '-1' +''' then ''' + 'max' + '''
			else cast(par.max_length as varchar)
		end as MaxLength
		from ' + QUOTENAME(@database_name) + '.sys.procedures p
		join ' + QUOTENAME(@database_name) + '.sys.parameters par on p.object_id = par.object_id
		join ' + QUOTENAME(@database_name) + '.sys.schemas s on s.schema_id = p.schema_id
		join ' + QUOTENAME(@database_name) + '.sys.types ty on par.user_type_id = ty.user_type_id;'
	end

	exec sp_executesql @sql_cmnd
end
go

execute sp_get_info lesson12;

--select * from sys.parameters;
--		select * from sys.types;
--		select * from sys.schemas;
--		select * from sys.procedures p;
--		select * from sys.parameter_type_usages


--QUOTENAME ensures name is encapsulated safely
/*select 'NewDB' as DatabaseName,
s.name as SchemaName,
t.name as TableName,
c.name as ColumnName,
ty.name as Type
from NewDB.sys.schemas s
join NewDB.sys.tables t on s.schema_id = t.schema_id
join NewDB.sys.columns c on t.object_id = c.object_id
join NewDB.sys.types ty on c.user_type_id = ty.user_type_id;
select * from sys.columns;*/

--ignore this
/*select * from lesson12.INFORMATION_SCHEMA.COLUMNS
select name as DatabaseName,
(select * from INFORMATION_SCHEMA.Tables)
from sys;

select * from sys.tables;

select t.lesson1 from sys.databases;
select * from INFORMATION_SCHEMA.Tables;
*/



