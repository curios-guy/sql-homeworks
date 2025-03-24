create table for_fun(
	n1 int,
	n2 int
)

;with cte(n1, n2) as(
	select 1, 2 
	union all 
	select n2, n2+1 from cte
	where n2 < 100
)
select * from cte;