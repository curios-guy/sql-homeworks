use lesson5;
-- while grading remember that I am using SSMS
CREATE TABLE Employees_new (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees_new(EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Alice Johnson', 'HR', 60000.00, '2015-06-15'),
(2, 'Bob Smith', 'IT', 75000.00, '2018-03-22'),
(3, 'Charlie Brown', 'Finance', 80000.00, '2016-11-10'),
(4, 'David Wilson', 'Marketing', 65000.00, '2019-09-05'),
(5, 'Emma Davis', 'Sales', 70000.00, '2020-01-20'),
(6, 'Frank Thomas', 'HR', 60000.00, '2017-07-30'),
(7, 'Grace Lee', 'IT', 75000.00, '2014-12-15'),
(8, 'Henry Adams', 'Finance', 81000.00, '2019-06-01'),
(9, 'Isabella White', 'Marketing', 67000.00, '2021-04-25'),
(10, 'Jack Harris', 'Sales', 70000.00, '2022-08-14'),
(11, 'Karen Scott', 'HR', 64000.00, '2013-05-18'),
(12, 'Leo Martinez', 'IT', 77000.00, '2016-02-28'),
(13, 'Mia Robinson', 'Finance', 82000.00, '2018-10-07'),
(14, 'Nathan Young', 'Marketing', 69000.00, '2020-12-12'),
(15, 'Olivia King', 'Sales', 73000.00, '2017-09-09'),
(16, 'Peter Allen', 'HR', 63000.00, '2015-04-04'),
(17, 'Quinn Wright', 'IT', 76000.00, '2021-11-20'),
(18, 'Rachel Evans', 'Finance', 83000.00, '2019-07-17'),
(19, 'Samuel Carter', 'Marketing', 68000.00, '2022-03-08'),
(20, 'Tina Baker', 'Sales', 72000.00, '2014-06-22'),
(21, 'Umar Nelson', 'HR', 60000.00, '2018-08-30'),
(22, 'Victor Turner', 'IT', 75000.00, '2019-01-17'),
(23, 'Wendy Hughes', 'Finance', 80000.00, '2017-05-23'),
(24, 'Xavier Lopez', 'Marketing', 65000.00, '2020-10-10'),
(25, 'Yasmine Perry', 'Sales', 70000.00, '2021-02-19'),
(26, 'Zachary Bennett', 'HR', 64000.00, '2016-09-28'),
(27, 'Abigail Morris', 'IT', 77000.00, '2013-11-15'),
(28, 'Benjamin Reed', 'Finance', 81000.00, '2015-03-02'),
(29, 'Charlotte Brooks', 'Marketing', 67000.00, '2018-12-07'),
(30, 'Daniel Foster', 'Sales', 72000.00, '2019-07-21');


--task1
select *,
	row_number() over(order by salary asc) as unique_num
from Employees_new;

--task2
select *, 
	DENSE_RANK() over(order by salary asc) as salary_rank
from Employees_new;
--or
select *,
	RANK() over(order by salary asc) as salary_rank --but it will assign different ranks then previous code, introduces gaps 
from Employees_new;

--task3
select * from(
select *,
	DENSE_RANK() over(partition by Department order by salary desc) as salary_rank
from Employees_new) as ranked_salaries
where salary_rank <= 2
order by Department, salary_rank;

--task4
select *,
	min(salary) over(partition by Department) as lowest_salary
from Employees_new;
---or
SELECT * FROM Employees_new
WHERE Salary = (SELECT MIN(Salary) FROM Employees_new e2 WHERE e2.Department = Employees_new.Department);

--task5
select *,
	sum(salary) over( ORDER BY Department) as salary_per_department --running total 
from Employees_new;


--ignore this
--select sum(salary), Department
--from Employees_new
--group by Department;

--task6
select distinct Department,
	sum(salary) over(partition by Department) as salary_per_department
from Employees_new
--or
select distinct Department, total_salaries from
(
	select Department, 
		sum(salary) over(partition by Department) as total_salaries
		from Employees_new
) as t

--task7
select distinct Department,
	CAST(avg(salary) over(partition by department) as decimal(10,2)) as average_salary
	from Employees_new;
--or
select distinct Department, avg_salaries from(
	select Department,
	avg(salary) over(partition by Department) as avg_salaries
	from Employees_new
) as t

--task8
select *,
	CAST(avg(salary) over(partition by Department) as decimal(10,2)) as department_average, 
	CAST(avg(salary) over(partition by Department) as decimal(10,2)) - Salary as employee_difference
	from Employees_new

--task9
select *,
	cast(avg(salary) over(order by EmployeeID rows between 1 preceding and 1 following) as decimal(10,2)) as employee_average
	from Employees_new;

--task10
select top 3 sum(salary) over(order by Hiredate desc) as emp, * from Employees_new;
--or
select top 3 sum(salary) over(order by HireDate desc rows between UNBOUNDED PRECEDING and CURRENT ROW) as emp, * 
from Employees_new

--task11
select *,
	sum(salary) over(order by Hiredate asc) as running_salary
	from Employees_new;

--task12
select *,
	max(salary) over(order by HireDate rows between 2 preceding and 2 following) as max_salary
	from Employees_new;
--or
select *,
	max(salary) over(partition by Department order by HireDate rows between 2 preceding and 2 following) as max_salary
	from Employees_new;

--task13
select *,
	sum(salary) over(partition by department) as department_sum,
	cast(salary / sum(salary) over(partition by department) * 100 as decimal(10,3)) as emp_percentage_contribution
	from Employees_new;

