use lesson5;

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
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

--select name
--from sales
--group by name
--having max(year(date_sold)) = min(year(date_sold))

CREATE TABLE Nobel_Prizes (
    year INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    laureate_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    profession VARCHAR(50) NOT NULL,
    PRIMARY KEY (year, category, laureate_name)
);

INSERT INTO Nobel_Prizes (year, category, laureate_name, country, profession) VALUES
(1970, 'Physics', 'Hannes Alfven', 'Sweden', 'Scientist'),
(1970, 'Physics', 'Louis Neel', 'France', 'Scientist'),
(1970, 'Chemistry', 'Luis Federico Leloir', 'France', 'Scientist'),
(1970, 'Physiology', 'Ulf von Euler', 'Sweden', 'Scientist'),
(1970, 'Physiology', 'Bernard Katz', 'Germany', 'Scientist'),
(1970, 'Literature', 'Aleksandr Solzhenitsyn', 'Russia', 'Linguist'),
(1970, 'Economics', 'Paul Samuelson', 'USA', 'Economist'),
(1970, 'Physiology', 'Julius Axelrod', 'USA', 'Scientist'),
(1971, 'Physics', 'Dennis Gabor', 'Hungary', 'Scientist');

select * from Nobel_Prizes
where year = 1970
order by (
CASE 
	when category = 'Chemistry' or category = 'Economics' then 1 else 0 end
), category asc

--drop table sales
create table sales(
	id int primary key identity,
	name varchar(70),
	date_sold date
);

insert into sales(name, date_sold)
values
	('apple', '2020-10-02'),
	('apple', '2021-09-09'),
	('banana', '2021-02-13'),
	('banana', '2020-09-23'),
	('cherry', '2021-12-12'),
	('cherry', '2020-04-30')

select name from sales
where year(date_sold) = 2020
except
select name from sales
where year(date_sold) <> 2020

select name from sales
group by name
having max(year(date_sold)) = min(year(date_sold)) and year(max(date_sold)) = 2020

SELECT DISTINCT name
FROM sales
WHERE YEAR(date_sold) = 2020;


select * from sales