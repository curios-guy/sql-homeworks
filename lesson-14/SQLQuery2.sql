CREATE TABLE NthHighest
(
 Name  varchar(5)  NOT NULL,
 Salary  int  NOT NULL
)
 
--Insert the values
INSERT INTO  NthHighest(Name, Salary)
VALUES
('e5', 45000),
('e3', 30000),
('e2', 49000),
('e4', 36600),
('e1', 58000)
 
--Check data
SELECT Name,Salary FROM NthHighest

select *,
MAX(Salary) over() 
from NthHighest;

select * from NthHighest order by Salary desc offset 1 row;

select top 1 * from (select * from NthHighest order by Salary desc offset 1 row) s