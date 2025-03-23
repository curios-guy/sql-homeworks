use lesson13;
go

declare @year int = 2025, @month int = 3;

with dateseries as (
    -- generate all days of the month using a tally table approach
    select datefromparts(@year, @month, n) as calendardate
    from (select top (31) row_number() over (order by (select null)) as n from master.dbo.spt_values) as numbers
    where n <= day(eomonth(datefromparts(@year, @month, 1)))
),
dateinfo as (
    -- add weekday and week grouping
    select 
        calendardate,
        datepart(weekday, calendardate) as weekdaynum, -- 1 = sunday, 7 = saturday
        dense_rank() over (order by datepart(week, calendardate)) as weeknum
    from dateseries
)
select 
    weeknum,
    max(case when weekdaynum = 1 then calendardate end) as sunday,
    max(case when weekdaynum = 2 then calendardate end) as monday,
    max(case when weekdaynum = 3 then calendardate end) as tuesday,
    max(case when weekdaynum = 4 then calendardate end) as wednesday,
    max(case when weekdaynum = 5 then calendardate end) as thursday,
    max(case when weekdaynum = 6 then calendardate end) as friday,
    max(case when weekdaynum = 7 then calendardate end) as saturday
from dateinfo
group by weeknum
order by weeknum;

--ignore this 
/*create function create_calendar(@date date)
returns #date_info table(
	sunday int,
	monday int,
	tuesday int,
	wednesday int,
	thursday int,
	friday int,
	saturday int
)
as
insert into @date_info;*/