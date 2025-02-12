

if OBJECT_ID('newbie') is null
begin 
	create table newbie (
	id int not null,
	name nvarchar(max) not null,
	description nvarchar(max) null
);
end

drop table employee;
create table employee (
	id int not null,
	name nvarchar(max) not null,
	description nvarchar(max) null
);

Insert into employee values (1, 'asdasd', 'asdasdasdasd'), (2, 'dasdas', 'asdqeqweq'), (3, 'asdasd', null);
SELECT * from employee;
