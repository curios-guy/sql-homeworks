use lesson8;

CREATE TABLE step_status (
    step_number INT PRIMARY KEY,
    status VARCHAR(10) CHECK (status IN ('Passed', 'Failed'))
);

INSERT INTO step_status (step_number, status) VALUES 
(1, 'Passed'),
(2, 'Passed'),
(3, 'Passed'),
(4, 'Passed'),
(5, 'Failed'),
(6, 'Failed'),
(7, 'Failed'),
(8, 'Failed'),
(9, 'Failed'),
(10, 'Passed'),
(11, 'Passed'),
(12, 'Passed');

--ignore this
--SELECT COUNT(*) AS passed_count
--FROM step_status
--WHERE status = 'Passed';

--select count(*) t
--from (select * from step_status where status = 'Passed') t;

--task1
select status, count(*) as consecutive_count
from (
    select 
        step_number,
        status,
        step_number - 
        row_number() over(partition by status order by step_number) as group_id
    from step_status
) as ConsecutiveGroups
group by status, group_id
order by min(step_number);


--task2
CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
);

INSERT INTO EMPLOYEES_N (EMPLOYEE_ID, FIRST_NAME, HIRE_DATE) VALUES
(1, 'John', '1975-03-15'),
(2, 'Alice', '1976-07-21'),
(3, 'Bob', '1977-11-02'),
(4, 'Mike', '1979-05-23'),
(5, 'Sara', '1980-08-10'),
(6, 'Tom', '1982-12-30'),
(7, 'Anna', '1983-06-18'),
(8, 'David', '1984-09-14'),
(9, 'Emma', '1985-04-25'),
(10, 'Liam', '1990-01-08'),
(11, 'Sophia', '1997-07-12'),
(12, 'James', '2000-05-19'),
(13, 'Olivia', '2005-09-23'),
(14, 'Mason', '2010-12-01'),
(15, 'Charlotte', '2015-03-15'),
(16, 'Ethan', '2017-06-28'),
(17, 'Isabella', '2018-09-11'),
(18, 'Noah', '2020-02-22'),
(19, 'Ava', '2022-07-05'),
(20, 'Lucas', '2023-10-30');

select a.year + 1 as Start_Year, b.year - 1 as End_Year
from (select distinct year(HIRE_DATE) as year from EMPLOYEES_N) a
join (select distinct year(HIRE_DATE) as year from EMPLOYEES_N) b
on a.year + 1 < b.year;