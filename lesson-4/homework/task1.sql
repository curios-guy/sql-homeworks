use lesson4;

CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

select * 
from TestMultipleZero
where A != 0 or B != 0 or C != 0 or D != 0;

--another version
select *
from TestMultipleZero
where not (A = 0 and B = 0 and C = 0 and D = 0);
--where case when A = 0 and B = 0 and C = 0 and D = 0 then 0 else 1 end = 1;


--another one
select * 
from TestMultipleZero
where coalesce(A,0) + coalesce(B,0) + coalesce(C,0) + coalesce(D,0) <> 0;


