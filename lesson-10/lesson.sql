use lesson10;

use lesson9;

select * from Employees_new;
--President
select *, 0 as Depth from Employees_new where ManagerID is NULL;

select *, 1 as Depth from Employees_new where ManagerID = (
	select EmployeeID from Employees_new where ManagerID is NULL
)

select emp.*, 1 as Depth from Employees_new emp
join (
	select EmployeeID from Employees_new where ManagerID is NULL
) mgr
	on emp.ManagerID = mgr.EmployeeID

select *, 2 as Depth from Employees_new where ManagerID = (
	select EmployeeID from Employees_new where ManagerID = (
		select EmployeeID from Employees_new where ManagerID is NULL
	)
)


select *, 2 as Depth from Employees_new emp2
	join (
	select emp1.EmployeeID from Employees_new emp1
		join (
			select EmployeeID from Employees_new where ManagerID is NULL
		) mgr
	on emp1.ManagerID = mgr.EmployeeID ) mgr1
on emp2.ManagerID = mgr1.EmployeeID

select * from Employees_new emp3 
	join(
	select emp2.EmployeeID from Employees_new emp2
		join (
		select emp1.EmployeeID from Employees_new emp1
			join (
				select EmployeeID from Employees_new where ManagerID is NULL
			) mgr
		on emp1.ManagerID = mgr.EmployeeID ) mgr1
	on emp2.ManagerID = mgr1.EmployeeID) mgr2
on emp3.ManagerID = mgr2.EmployeeID

--////////////////////////////
;with cte as(
	select *, 0 as Depth from Employees_new where ManagerID is NULL

	union all

	select emp.*, Depth + 1 as Depth from Employees_new emp
	join cte mgr
		on emp.ManagerID = mgr.EmployeeID
) select * from cte;

--//////end of lesson9//////

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Orders VALUES 
	(1, 'Alice', '2024-03-01'),
	(2, 'Bob', '2024-03-02'),
	(3, 'Charlie', '2024-03-03');

INSERT INTO OrderDetails VALUES 
	(1, 1, 'Laptop', 1, 1000.00),
	(2, 1, 'Mouse', 2, 50.00),
	(3, 2, 'Phone', 1, 700.00),
	(4, 2, 'Charger', 1, 30.00),
	(5, 3, 'Tablet', 1, 400.00),
	(6, 3, 'Keyboard', 1, 80.00);

select * from Orders
select * from OrderDetails
/*
1	Alice	Laptop	1	1000.00
2	Bob		Phone	1	700.00
3	Charlie Tablet	1	400.00
*/
select distinct ord.OrderID, ord.CustomerName, ordd.ProductName, ordd.Quantity, 
Max(ordd.UnitPrice) over(partition by ordd.OrderID) as max_sold
from Orders ord
join OrderDetails ordd
on ord.OrderID = ordd.OrderID

--select CutomerName, ProductName, Quantity from
--(select ord.CustomerName, row_number() over(partition by ord.CustomerName order by od.UnitPrice) as rnk 
--from Orders ord
--join OrderDetails od
--on od.OrderID = ord.OrderID) t1

select OrderID, CustomerName, 
(select max(UnitPrice)
	from OrderDetails od
	where od.OrderID = o.OrderID
)
from Orders o

--1:10:00

select OrderId, customerName,
(
	select top 1 UnitPrice from OrderDetails od
	where od.OrderID=o.OrderID
	order by UnitPrice desc
) as UnitPrice,
(
	select top 1 ProductName from OrderDetails od
	where od.OrderID=o.OrderID
	order by UnitPrice desc
) as ProductName
from Orders o;

select UnitPrice, OrderID from OrderDetails order by UnitPrice desc;


select o.OrderId, customerName, od.ProductName, od.UnitPrice
from Orders o
cross apply (
	select top 3 OrderID, ProductName, UnitPrice from OrderDetails od
	where od.OrderID=o.OrderID
	order by UnitPrice desc
) as od

select * from Orders

select top 2 OrderID, ProductName, UnitPrice from OrderDetails od
where od.OrderID=1
order by UnitPrice desc




CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);

INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

select * from TestMax;

select Year1, GREATEST(Max1, Max2, Max3) as maxVal from TestMax;

select Year1, IIF(Max1 > Max2, Max1, 
	IIF(Max2> Max3, Max2, Max3)
) as absmax from TestMax;

select Year1, max(Max1)
from (
	select Year1, Max1 from TestMax
	union all
	select Year1, Max2 from TestMax
	union all 
	select Year1, Max3 from TestMax
) t
group by Year1

select Year1,
	case
		when Max1 > Max2 then (case when Max1>Max3 then Max1 else Max3 end)
		else (case when Max2 > Max3 then Max2 else Max3 end)
		end  as absmax
	from TestMax
	
select Year1, (
	select Max(mx) from (
	select Max1 as mx from TestMax t1 where t1.Year1 = t.Year1
	union all
	select Max2 from TestMax t1 where t1.Year1 = t.Year1
	union all
	select Max3 from TestMax t1 where t1.Year1 = t.Year1
	) as mx
) absmax from TestMax t

--=================================================
--Values
--=================================================
create table demo(
	col1 int, col2 int
)

insert into demo
values (1,2), (2,3), (3,4), (4,5);

insert into demo
select 1,2
union all
select 2,3
union all
select 4,3 

select col1, col2 from (
	values (1,2), (2,3), (3,4)
) demo(col1, col2)

select * from demo;

select Year1,
	(
		select max(val) from (
			values (Max1), (Max2), (Max3)
		) t (val)
	) as max_val
from TestMax
/*
2001	101
2002	103
2003	89
2004	91
*/
