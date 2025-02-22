use lesson3;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

insert into employees(FirstName, LastName, Department, Salary, HireDate)
values ('Cassandra', 'Melicho', 'Pedagogy', 12000, '2022-12-12'),
('Cas', 'Van de Pol', 'Mechanics', 20000, '2019-03-12'),
('Brocoli', 'notVegetable', 'Chemistry', 30200, '2008-11-25'),
('Fera', 'Saloni', 'Pharma', 24000, '2017-10-16'),
('Noname', 'Johnson', 'AURA', 100000, '2009-04-12'),
('John', 'Stackton', 'Golem', 42000, '1998-06-29'),
('Malish', 'BigBoyev', 'Kindergarten', 12000, '2025-06-19'),
('Salom', 'VA', 'Pedagogy', 13000, '2022-11-25')

select 
top 10 percent *
from Employees;

select Department, AVG(Salary) as Average_salary
from Employees
group by Department;

select Salary,
	IIF(Salary >= 80000, 'High',
		IIF(Salary > 50000 and Salary < 80000, 'Medium', 'Low'
		)
	) as AverageSalary
from Employees
order by salary desc
OFFSET 2 ROWS
FETCH NEXT 5 ROWS ONLY;






