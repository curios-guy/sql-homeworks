use lesson2;

--task1
create table test_identity(
	id int primary key identity,
	name varchar(70) not null
)

insert into test_identity (name) values
('name1'), ('name2'), ('name3'), ('name4'), ('name5')

--drop table test_identity;
--delete from test_identity where id = 1;
--truncate table test_identity;

select * from test_identity;

--task2
create table data_types_demo(
	example_tinyint tinyint,
	example_smallint smallint,
	example_int int,
	example_bigint bigint,
	example_char char(10),
	example_nchar nchar(10),
	example_varchar varchar(70),
	example_nvarchar nvarchar(70),
	example_decimal decimal(10,3),
	example_float float,
	example_date date,
	example_time time,
	example_datetime datetime,
	example_guid uniqueidentifier
);
--select NEWID();
insert into data_types_demo values(122, 12332, 31231232, 123123123233, 'a', 'e', 'qweqwewq', 'asdasdasas', 523.6589, 6523.24, '2024-12-02', '15:09', '2024-12-23 15:45', 'CD62B924-7426-46FE-A6C5-F5EB83519D3C')

select * from data_types_demo;

--task3
create table photos(
	id int primary key identity,
	name varchar(70) check (name != ''),
	file_place varbinary(max) not null
)

insert into photos(name, file_place)
select 'rubicks cube', * from openrowset(
	bulk 'G:\AI and BI talents\sql\lesson-2\homework\image.png', single_blob
) as png_file;

select * from photos;

select @@SERVERNAME

--task4
create table student(
	student_id int primary key identity,
	name nvarchar(70) not null check(LEN(name) > 0),
	classes tinyint not null check (classes >= 0),
	tuition_per_class decimal(10,2) not null check (tuition_per_class >= 0),
	total_tuition AS (classes * tuition_per_class) PERSISTED
)

insert into student values
('Alice', 5, 100.00),
('Bob', 3, 120.50),
('Charlie', 4, 90.75);

select * from student;

--task5
create table worker(
	id int primary key identity(1,1),
	name nvarchar(80) not null check (LEN(name) > 0)
)

BULK INSERT worker
FROM 'G:\AI and BI talents\sql\lesson-2\homework\workers.csv'
WITH (
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n',
	codepage = '65001'
);

select * from worker;