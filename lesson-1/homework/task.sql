--create database lesson1
--use lesson1

--task1
create table student (
	id int not null,
	name varchar(60) null,
	age int null
)
insert into student values(21, 'salom', 12)

ALTER TABLE student
ALTER COLUMN id INT NULL;

select * from student;

--task2
drop table product
create table product (
	product_id int unique,
	product_name varchar(100),
	price decimal(5,2),
)
insert into product values (1, 'apple', 12.03), (2, 'grape', 23.01);
alter table product drop constraint UQ__product__47027DF433EA3152;

alter table product
add constraint UQ_product_product_id unique(product_id);

alter table product add constraint UC_product_name unique (product_name);

select * from product;

--task3
create table orders (
	order_id int primary key,
	customer_name varchar(100),
	order_date date
);
alter table orders drop constraint PK__orders__465962297D422167;

alter table orders add constraint PK__order_id primary key (order_id)

select * from orders;

--task4
create table category(
	category_id int primary key,
	category_name varchar(200)
);

create table item(
	item_id int primary key,
	itam_name varchar(200),
	category_id int foreign key references category(category_id)
)


alter table item drop constraint FK__item__category_i__5DCAEF64;

alter table item add constraint FK_item_category 
foreign key (category_id) references category(category_id);

select * from item;
select * from category;

--task5
create table account (
	account_id int primary key,
	balance decimal(5,2) check (balance >= 0),
	account_type varchar(50) check (account_type in ('Saving', 'Checking'))
);

alter table account drop constraint CK__account__account__628FA481;
alter table account drop constraint CK__account__balance__619B8048;

alter table account add constraint CK_account_balance check (balance >= 0);
alter table account add constraint CK_account_account_type check (account_type in ('Saving', 'Checking'))

--task6
create table customer(
	customer_id int primary key,
	name text,
	city text default 'Unknown'
)

alter table customer drop DF__customer__city__68487DD7;

alter table customer add constraint DF_customer_city default 'Unknown' for city;

select * from customer;

--task7
--drop table invoice;
create table invoice(
	invoice_id int identity,
	amount decimal(5,2)
);

insert into invoice (amount)
values (12.32), (32.12), (100.03)

SET IDENTITY_INSERT invoice ON

insert into invoice (invoice_id, amount)
values (100, 12.32), (101, 03.2)

select * from invoice;

--task8
create table books (
	book_id int primary key identity,
	title varchar(70) check (title != ''),
	price decimal(7,2) check (price > 0),
	genre varchar(70) default 'Unknown'
);

insert into books (title, price, genre)
values
('asdaas', 321.123, 'loppo'),
('qeeqqq', 6543, 'mfod'),
('erer', 234.432, 'rew')

insert into books (title, price) values('qweq', 562.23)

insert into books (title, price) values('qweq', -562.23)

select * from books;

--task9
--drop table book;
--drop table member;
--drop table loan;
create table book(
	book_id int primary key identity,
	title varchar(70) check (title != ''),
	author varchar(50) check (author != ''),
	published_year int default 'unknown'
);

create table member(
	member_id int primary key identity,
	name varchar(70) check (name != ''),
	email varchar(70) default 'no email',
	phone_number varchar(80) check (phone_number != '')
);

create table loan(
	loan_id int primary key identity,
	book_id int foreign key references book(book_id),
	member_id int foreign key references member(member_id),
	loan_date date not null,
	return_date date not null,
);


insert into book (title, author, published_year) 
values ('Gopher G', 'Gulam', 1987), ('SADD', 'dasdas', 3213), ('QWERRT', 'dasdas', 3212);

insert into member (name, email, phone_number)
values ('Alish', 'asdasd@adasd', '2131232'), ('sadsad', 'asdasd', '2313123123'), ('asdasd', 'bvvbc', '312213');

insert into loan (book_id, member_id, loan_date, return_date)
values (1,2,'2025-02-14', '2025-02-15'), (2,1,'2025-02-14', '2025-02-15'), (3,1,'2025-02-14', '2025-02-15');

select * from book;
select * from member;
select * from loan;


--bonus_task

create table suppliers(
	supplier_id int primary key,
	supplier_name varchar(70) check (supplier_name != ''),
	phone_number varchar(70) default 'no number',
	address varchar(80) check (address != '')
);

create table categories(
	category_id int primary key,
	category_name varchar(70) check (category_name != ''),
	description varchar(max) check (description != '')
)

create table products(
	product_id int primary key,
	supplier_id int foreign key references suppliers(supplier_id),
	category_id int foreign key references categories(category_id),
	product_name varchar(70) check (product_name != '')
);

create table employees(
	employee_id int primary key,
	lastname varchar(50),
	firstname varchar(50)
)

create table customers(
	customer_id int primary key,
	customer_name varchar(70),
	contact_number varchar(60) check (contact_number != '')
)

create table shippers(
	shipper_id int primary key,
	shipper_name varchar(70)
)

create table orderss (
	order_id int primary key,
	customer_id int foreign key references customers(customer_id),
	employee_id int foreign key references employees(employee_id),
	shipper_id int foreign key references shippers(shipper_id),
	order_date date
);

create table order_details(
	orderDetail_id int primary key,
	order_id int foreign key references orderss(order_id),
	product_id int foreign key references products(product_id),
	quantity int check (quantity > 0),
);
