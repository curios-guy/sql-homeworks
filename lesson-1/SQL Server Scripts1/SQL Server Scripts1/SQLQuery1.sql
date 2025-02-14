--create database forTest;

use forTest;
--create table test1(
--	id int not null,
--	name varchar(100) not null
--);

--insert into dbo.test1 values (1, 'hello'), (2, 'hero');

select * from test1;

select * from dbo.test1;

select * from forTest.dbo.test1;

/* INSERING VALUES USING SELECT STATEMENT*/

insert into test1
select 4, 'demo4'
union all
select 5, 'demo5';

select distinct * from test1;

/* CONSTRAINT - Limit, Cheklov*/
drop table if exists test1;
create table test1(
	id int not null unique,
	name varchar(100)
)

insert into test1(id, name)
values 
	(1, 'Jphn'),
	(2, 'as'),
	(2, 'reqwe');

select * from test1;

alter table test1
add unique(id);

alter table test1
add constraint UC_person_id unique(id);

alter table test1
drop constraint UC_person_id;


/* PRIMARY KEY */
DROP TABLE IF EXISTS test1;
create table test1 (
	id int primary key,
	name varchar(50)
);
--primary key => not null + unique id + index
insert into test1(id,name)
values (1, 'John')

/* FOREIGN KEY */
drop table if exists test1;

create table test1 (
	id int primary key,
	name varchar(50),
	department varchar(50)
);

insert into test1 values (1, 'John', 'HR');

insert into test1 values (2, 'alish', 'pr');

select * from test1;


------------
create table department(
	id int primary key,
	name varchar(100)
)

drop table employee;
create table employee(
	id int primary key,
	name varchar(60),
	department_id int foreign key references department(id)
);

insert into employee values (1, 'asda',1), (2, 'qwrq',1), (3, 'egfss',3), (4, 'xcvx',2)

insert into department values (1, 'fg'), (2, 'sdas'), (3, 'ced')

select * from employee;
select * from department;

/* CHECK CONSTRAINT AND DEFAULT*/
drop table person;
CREATE TABLE person(
	id int primary key,
	name varchar(50),
	age int check (age > 0),
	email varchar(50) not null default 'No Email'
);

insert into person(id, name, age)
select 30, 'john', 1
union all
select 12, 'asdas', 21

insert into person values(
 32, 'asdas', 21, 'asdas')

select * from person;

/* IDENTITY */
drop table if exists person;
create table person
(
	id int primary key identity(900, 1),
	name varchar(50)
);

insert into person( name)
values ( 'John')

--An explicit value for the identity column in table 'person' can only be specified when a column list is used and IDENTITY_INSERT is ON.

insert into person(id, name)
values (6,'John')

select * from person

SET IDENTITY_INSERT person OFF