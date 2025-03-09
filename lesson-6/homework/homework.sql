use lesson6;
-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DepartmentID INT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

-- Create Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    EmployeeID INT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert data into Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

-- Insert data into Employees
INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

-- Insert data into Projects
INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);

--task1
select *
from Employees as e
inner join Departments as d
on e.DepartmentID = d.DepartmentID
--or
select EmployeeID, Name, DepartmentName
from Employees as e
inner join Departments as d
on e.DepartmentID = d.DepartmentID


--task2
select *
from Employees as e
left join Departments as d
on e.DepartmentID = d.DepartmentID


--task3
select *
from Employees as e
right join Departments as d
on e.DepartmentID = d.DepartmentID

--task4
select *
from Employees
full outer join Departments
on Employees.DepartmentID = Departments.DepartmentID

--task5
select d.DepartmentName,
	sum(salary) as salary_per_department
from Employees as e
join Departments as d
on e.DepartmentID = d.DepartmentID
group by DepartmentName;


--task6
select *
from Departments as d
cross join Projects as p;


--task7
select 
    e.EmployeeID, 
    e.Name as EmployeeName, 
    d.DepartmentName, 
    p.ProjectName
from Employees e
left join Departments d on e.DepartmentID = d.DepartmentID
left join Projects p on e.EmployeeID = p.EmployeeID;
--or
select e.EmployeeID, 
    e.name as EmployeeName, 
    d.DepartmentName,  
	STRING_AGG(p.ProjectName, ', ') as ProjectNames
from Employees e
left join Departments d on e.DepartmentID = d.DepartmentID
left join Projects p on e.EmployeeID = p.EmployeeID
group by e.EmployeeID, e.name, d.DepartmentName;
