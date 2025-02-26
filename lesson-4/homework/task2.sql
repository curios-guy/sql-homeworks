use lesson4;

CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

select Year1, 
IIF(Max1 > Max2 and Max1 > Max3, Max1
	,IIF(Max2 > Max3, Max2, Max3)
) as max_year 
from TestMax 

--anothoer version
select Year1, 
       (select max(val) 
        from (values (Max1), (Max2), (Max3)) as Temp(val)) as max_year
from TestMax;