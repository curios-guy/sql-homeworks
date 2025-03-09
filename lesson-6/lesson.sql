use lesson6;
use lesson5;
create table Vals(
	id int primary key identity,
	type varchar(20),
	Val1 char(10),
	Val2 char(10),
	Val3 char(30)
);

insert into Vals(type, Val1, Val2, Val3)
values('I', 'a', 'b', 'c'),
('O', 'a', 'd','f'),
('I', 'd', 'b', 'a'),
('O', 'b', 'a', 'a'),
('I', 'b', 'a', 'b'),
('I', 'd', 'a', 'a')

--select * distinct type,
--	count('a') over()
--	from Vals

select Type,
	count(CASE When Val1 = 'a' then 1 end) +
	count(case when Val2 = 'a' then 1 end) +
	count(case when Val3 = 'a' then 1 end) 
	--count(case when Val4 = 'a' then 1 end)
	from Vals
	group by Type;

drop table if exists tp;
create table tp(
	id int,
	name varchar(10),
	typed varchar(10)
);

insert into tp(id, name, typed)
values(1, 'A', NULL), (2, NULL, 'B'), (1, 'A', NULL), (1, NULL, 'B');

select * from tp;

-----------------------------------------------------
select * from generate_series(0, 100);

select ROW_NUMBER() over(order by value) as numbers
from string_split(REPLICATE(',', 99), ',');

--=============================
--LAG LEAD
 --lag(expression, offset, default) previous
 --lead(expression, offset, default) next
 --defult should be the same data type as expression

 select * from Employees_new;
 select *,
	Lag(salary, 1, 0) over(partition by Department order by HireDate) as namee
	from Employees_new;

--===================================
--First_value Last_value
--===================================

select *,
	FIRST_VALUE(name) over(partition by Department order by HireDate) as First_emp,
	FIRST_VALUE(name) over(partition by Department order by HireDate desc) as Last_emp,
	LAST_VALUE(name) over(partition by Department order by HireDate rows between unbounded preceding and unbounded following) as Last_emp
	from Employees_new


create table department(
	id int primary key,
	department varchar(50)
)

create table emp(
	id int primary key,
	name nvarchar(50),
	departmentID int foreign key references department(id) 
)
INSERT INTO department (id, department) VALUES 
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

INSERT INTO emp (id, name, departmentID) VALUES 
(1, 'John Doe', 1),
(2, 'Jane Smith', 2),
(3, 'Robert Brown', 3),
(4, 'Emily Davis', 4),
(5, 'Michael Johnson', 5),
(6, 'Sarah Wilson', 1),
(7, 'Chris Taylor', 2),
(8, 'Olivia Martinez', 3),
(9, 'James Anderson', 4),
(10, 'Laura Thomas', 5);

select
	e.*, '|' as '|', d.*
from emp as e -- left table
inner join department as d -- right table
	on e.departmentID <> d.id --and d.id <> 1
where d.id <> 1
order by e.id, e.name

select
	*
from employee as e
left outer join department as d
	on e.dept_id = d.id;

select
	*
from employee as e
right outer join department as d
	on e.dept_id = d.id;


select
	*
from employee as e
full outer join department as d
	on e.dept_id = d.id;

select
	*
from employee
cross join department

select
	*
from employee, department;


select
	*
from employee a
cross join employee b;


--empoloyee
--	id
--	name
--	salary
--	manager_id

--manager
--	id

-- Ambiguous column name 'id'.