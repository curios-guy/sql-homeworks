use lesson11;

-- ==============================================================
--                          Puzzle 1 DDL                         
-- ==============================================================

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);


create table #EmployeeTransfers(
	EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
)

insert into #EmployeeTransfers
select EmployeeID, Name, case 
		when Department = 'HR' then 'IT'
		when Department = 'IT' then 'Sales'
		when Department = 'Sales' then 'HR'
	end as Department, 
	Salary from Employees;

select * from #EmployeeTransfers;

--ignore this
/*truncate table #EmployeeTransfers;
insert into #EmployeeTransfers(EmployeeID, Name, Department, Salary)
select EmployeeID, Name, 
case 
	when Department is NULL then 'HR' 
	when Department <> NULL then LEAD(Department) over(order by EmployeeID) 
	end, 
	Salary from Employees

select * from #EmployeeTransfers;*/

-- ==============================================================
--                          Puzzle 2 DDL
-- ==============================================================

CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

create table #MissingOrders(
	OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

insert into #MissingOrders
select db1.OrderID, db1.CustomerName, db1.Product, db1.Quantity from Orders_DB1 db1
left join Orders_DB2 db2 
on db1.OrderID = db2.OrderID
where db2.OrderID is NULL;

select * from #MissingOrders;

--ignore this
--truncate table #MissingOrders;
--select * from Orders_DB1 db1
--left join Orders_DB2 db2 
--on db1.OrderID = db2.OrderID
--where db2.OrderID is NULL;

-- ==============================================================
--                          Puzzle 3 DDL
-- ==============================================================

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);


go
create view vw_MonthlyWorkSummary as
select EmployeeID, EmployeeName, e.Department, SUM(HoursWorked) as TotalHoursWorked, d.TotalHoursDepartment, a.AvgHoursDepartment from WorkLog e 
join (
	select Department, Sum(HoursWorked) as TotalHoursDepartment from WorkLog group by Department
) d on e.Department = d.Department
join (
	select Department, AVG(HoursWorked) as AvgHoursDepartment from WorkLog group by Department
) a on a.Department = e.Department
group by e.EmployeeID, e.EmployeeName, e.Department, d.TotalHoursDepartment, a.AvgHoursDepartment
go

select * from vw_MonthlyWorkSummary

--ignore this
/*DELETE FROM WorkLog;
DROP VIEW vw_MonthlyWorkSummary;*/