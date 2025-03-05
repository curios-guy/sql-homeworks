use lesson5;

CREATE TABLE Saless (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    SaleDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL
);


INSERT INTO Saless (SaleDate, Amount) VALUES
('2024-01-01', 100),
('2024-01-02', 200),
('2024-01-03', 150),
('2024-01-04', 300),
('2024-01-05', 250),
('2024-01-06', 400),
('2024-01-07', 350),
('2024-01-08', 450),
('2024-01-09', 500),
('2024-01-10', 100);


select *, 
	ROW_NUMBER() OVER(order by amount asc) as rn_asc,
	--row_number() over(order by saledate desc) as rn_desc,
	dense_rank() over(order by amount asc) as dnr_asc, --gives same rank for same amounts
	rank() over(order by amount asc) as r_asc --if same rank given to same amounts then next amount will be given 3rd or 4th
from Saless
order by SaleID


-- Aggregate-Window Functions
-- SUM, COUNT, MIN, MAX, AVG

drop table if exists Employees;
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);


INSERT INTO Employees ([Name], Department, Salary, HireDate) VALUES
('Alice', 'HR', 50000, '2020-06-15'),
('Bob', 'HR', 60000, '2018-09-10'),
('Charlie', 'IT', 70000, '2019-03-05'),
('David', 'IT', 80000, '2021-07-22'),
('Eve', 'Finance', 90000, '2017-11-30'),
('Frank', 'Finance', 75000, '2019-12-25'),
('Grace', 'Marketing', 65000, '2016-05-14'),
('Hank', 'Marketing', 72000, '2019-10-08'),
('Ivy', 'IT', 67000, '2022-01-12'),
('Jack', 'HR', 52000, '2021-03-29');

select *, (select sum(amount) from saless)
from Saless

select sum(amount) from saless

select *, sum(amount) OVER()
from saless;


select *, sum(salary) over()
from employees; 

select 
	*,
	sum(salary) over(partition by department)
from Employees;

select department, sum(salary)
from Employees
group by department

select 
	*,
	max(salary) over(partition by department)
from Employees;

select department, max(salary)
from Employees
group by department;

--========================================================
select * from(
	select *,
	dense_rank() over(partition by department order by salary desc) as rnk
	from Employees
) newT
--where rnk = 2
order by department, rnk;

--============================================================

select 
		*,
		sum(salary) over(), -- Running Total
		sum(salary) over(order by HireDate) -- Cumulativ
from Employees
order by HireDate;

-- Running Total
-- Cumulativ

select 
		*,
		sum(salary) over() as col1,
		sum(salary) over(order by HireDate) as col2,
		sum(salary) over(partition by department order by HireDate) as res
from Employees
order by department;

select 
		*,
		sum(salary) over(order by HireDate) as res0,
		sum(salary) over(order by HireDate rows between 1 preceding and current row) as res1,
		sum(salary) over(order by HireDate rows between 1 preceding and 1 following) as res2,
		sum(salary) over(order by HireDate rows between unbounded preceding and current row) as res3,
		sum(salary) over(order by HireDate rows between current row and unbounded following) as res4
from Employees
order by HireDate;


select *, sum(salary) over() as sal, CAST((salary /sum(salary) over()) * 100 as decimal(5,2))  as perc
from Employees;

select *, AVG(salary) over(order by Hiredate rows between 2 preceding and current row) as res
from Employees

select *, AVG(salary) over(order by Hiredate rows between 1 preceding and 1 following) as res
from Employees
order by EmployeeID
