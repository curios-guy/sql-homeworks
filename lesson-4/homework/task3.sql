use lesson4;

CREATE table EmpBirth(
     EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';


select *
from EmpBirth
where month(BirthDate) = 5 and day(BirthDate) between 7 and 15;

--another version
select *, 
IIF(month(BirthDate) = 5 and day(BirthDate) between 7 and 15, 'yes','no')
from EmpBirth;

