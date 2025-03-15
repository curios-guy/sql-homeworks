use lesson9;
--task1
;with cte as (
    -- Base case
    select 
        EmployeeID, 
        ManagerID, 
        JobTitle, 
        0 as Depth
    from Employees_new
    where ManagerID is null

    union all
	--Recursive Part
    select 
        e.EmployeeID, 
        e.ManagerID, 
        e.JobTitle, 
        cte.Depth + 1
    from Employees_new e
    join cte on e.ManagerID = cte.EmployeeID
)
select EmployeeID, ManagerID, JobTitle, Depth 
from cte
order by Depth, EmployeeID;

--ignore this
--with cte as(
--select e.EmployeeID, e.JobTitle, '|' as '|', e.ManagerID
--from Employees_new e
--left join Employees_new m
--on e.EmployeeID = m.ManagerID)
-- select distinct EmployeeID, JobTitle, ManagerID 
--from cte
--group by EmployeeID, JobTitle

--mng as (
--select Count(ManagerID) 
--from cte where ManagerID = 2002
--)
--IIF(
--	(LAG(ManagerID) over()) = EmployeeID, 1, 0
--) as Depth

--task2
declare @num int = 10;

with cte as (
    select 1 as fact, 1 as n 
    union all
    select fact * (n + 1), n + 1 from cte
    where n < @num 
)
select n as number, fact as factorial_result from cte;

--task3
declare @fib int = 10

;with cte as (
    select 1 as n, 0 as fib1, 1 as fib2 
    union all
    select n + 1, fib2, fib1 + fib2 
    from cte
    where n < @fib 
	)
select n as term, fib1 as fibonacci_number from cte;