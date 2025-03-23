use lesson13;
-- CURSOR

declare my_cursor cursor for 
	select name, database_id from sys.databases where name not in 
	('master', 'tempdb');

open my_cursor;

declare @db_name table(name varchar(255), database_id int);
fetch next from my_cursor into @db_name;

while @@FETCH_STATUS = 0
begin 
	PRINT @db_name;
	fetch next from my_cursor into @db_name;
end;
close my_cursor;
deallocate my_cursor;


declare @db_namey varchar(255);
declare new_cursor cursor for 
	select name from sys.databases where name not in 
	('master', 'tempdb');

open new_cursor;

fetch next from new_cursor into @db_namey;

while @@FETCH_STATUS = 0
begin
	print @db_namey;
	fetch next from new_cursor into @db_namey;
end;

close new_cursor;
deallocate new_cursor;




--=======================================
--FUNCTIONS
--=======================================
-- Functions
-- 1. Scalar function
-- 2. Table Valued function
	-- 2.1 Inline
	-- 2.2 Multiline

go
create function makesquare(@num int)
returns int
as
begin
	return @num*@num;
end;

go

alter function makesquare(@num int = NULL)
returns int
as
begin
/*
	if @num is null
	begin
		return 0;
	end
	return @num * @num;
*/	
	--IIF can used only in return and select batch
	--return iif(@num is null, 0, @num * @num);
	return case when @num is null then 0 else @num * @num end;
end;

go

select dbo.makesquare(2.9999)

select top 100 DepartmentID, name, dbo.makesquare(DepartmentID) as squared_id from [AdventureWorks2022].[HumanResources].[Department]


----

create table emails
(
	id int,
	email varchar(255)
);

insert into emails
values 
	(1, 'example1@gmail.com'),
	(2, 'example2@gmail.com
	'),
	(3, 'example3@gmail.com
'),
	(4, '	example4@gmail.com')


go

create function dbo.clean_field(@field nvarchar(255))
returns nvarchar(max)
as
begin
	return trim(replace(
		replace(
			replace(@field, char(13), ''),
			char(9), ''
		),
		char(10), ''
	))
end

go


select *
from emails where dbo.clean_field(email) = 'example2@gmail.com'

----

-- 2. Table Valued function

-- 2.1 Inline
go
create function my_tvf(@dep_id int)
returns table
as
return
(
	select *
	from [AdventureWorks2022].[HumanResources].[Department]
	where DepartmentID = isnull(@dep_id, DepartmentID)
	--where store_id = store_id -- TRUE
)

go

select * from my_tvf(1)

go

select top 100 * from [AdventureWorks2022].[HumanResources].[Department]

-- 2.2 Multiline


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID),
    Role VARCHAR(50),
    HoursWorked DECIMAL(10,2),
    PRIMARY KEY (EmployeeID, ProjectID)
);


INSERT INTO Employees (FullName, Department) VALUES
    ('Alice Johnson', 'IT'),
    ('Bob Smith', 'IT'),
    ('Charlie Brown', 'HR'),
    ('David White', 'Finance');

INSERT INTO Projects (ProjectName, StartDate, EndDate) VALUES
    ('ERP System', '2023-01-01', '2024-06-30'),
    ('Website Redesign', '2023-05-15', '2023-12-31'),
    ('HR Automation', '2023-07-01', '2024-03-15'),
    ('Financial Forecasting', '2023-08-01', NULL); -- Ongoing project

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role, HoursWorked) VALUES
    (1, 1, 'Developer', 400),
    (1, 2, 'Lead Developer', 300),
    (2, 1, 'QA Engineer', 250),
    (2, 3, 'Consultant', 150),
    (3, 3, 'HR Specialist', 350),
    (4, 4, 'Analyst', 200);


select * from EmployeeProjects
select * from Projects
select * from Employees

-- EmployeeName, Department, TotalProject, TotalHoursWorked, LatestProjectEndDate
go
alter function get_info()
returns table
as
return (
	select emp.FullName as EmployeeName, emp.Department as Department, p.ProjectName as TotalProject, 
	sum(ep.HoursWorked) over(partition by ep.EmployeeID) as TotalHoursWorked,
	case when p.EndDate is NULL then convert(varchar(70), p.EndDate) else p.EndDate end as LatestProjectEndDate
	from Employees emp 
	join EmployeeProjects ep 
	on emp.EmployeeID = ep.EmployeeID
	join Projects p
	on p.ProjectID = ep.ProjectID
	--group by emp.FullName, emp.Department, p.ProjectName
)

select * from get_info()

--difference between multiline and inline is that multiline creates temp table within and returns it, while inline returns only table without creating the temp table