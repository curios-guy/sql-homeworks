use lesson7;
--using SSMS 2022
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);
-- Insert Customers (including users with no orders)
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Brown'),
(4, 'David Wilson'),
(5, 'Emma Davis'),
(6, 'Frank Thomas'),
(7, 'Grace Hall'),
(8, 'Henry Clark'),
(9, 'Ivy Lewis'),
(10, 'Jack White'),
(11, 'Karen Adams'),
(12, 'Liam Scott'),
(13, 'Mia Roberts'),
(14, 'Nathan King'),
(15, 'Olivia Perez'),
(16, 'Paul Wright'),
(17, 'Quincy Young'),
(18, 'Rachel Green'),
(19, 'Samuel Harris'),
(20, 'Tina Turner');

-- Insert Products (including 'Stationery' category)
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Phone', 'Electronics'),
(3, 'Tablet', 'Electronics'),
(4, 'Headphones', 'Accessories'),
(5, 'Monitor', 'Electronics'),
(6, 'Keyboard', 'Accessories'),
(7, 'Mouse', 'Accessories'),
(8, 'Chair', 'Furniture'),
(9, 'Desk', 'Furniture'),
(10, 'Backpack', 'Accessories'),
(11, 'Notebook', 'Stationery'),
(12, 'Pen Set', 'Stationery'),
(13, 'Marker Pack', 'Stationery'),
(14, 'Printer', 'Electronics'),
(15, 'Smartwatch', 'Electronics'),
(16, 'Desk Lamp', 'Furniture'),
(17, 'USB Drive', 'Accessories'),
(18, 'External Hard Drive', 'Electronics'),
(19, 'Whiteboard', 'Stationery'),
(20, 'File Organizer', 'Stationery');

-- Insert Orders (some customers with multiple orders, some with none)
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2024-03-01'),
(2, 2, '2024-03-02'),
(3, 3, '2024-03-03'),
(4, 3, '2024-03-04'),  -- Charlie has 2 orders
(5, 4, '2024-03-05'),
(6, 5, '2024-03-06'),
(7, 5, '2024-03-07'),  -- Emma has 2 orders
(8, 6, '2024-03-08'),
(9, 7, '2024-03-09'),
(10, 7, '2024-03-10'), -- Grace has 2 orders
(11, 8, '2024-03-11'),
(12, 9, '2024-03-12'),
(13, 9, '2024-03-13'), -- Ivy has 2 orders
(14, 10, '2024-03-14'),
(15, 11, '2024-03-15'),
(16, 12, '2024-03-16'),
(17, 13, '2024-03-17'),
(18, 14, '2024-03-18'),
(19, 14, '2024-03-19'), -- Nathan has 2 orders
(20, 15, '2024-03-20');

-- Customers 16, 17, 18, 19, and 20 have NO orders

-- Insert OrderDetails (linked to orders)
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 1000.00),
(2, 1, 2, 2, 500.00),
(3, 2, 3, 1, 300.00),
(4, 3, 4, 3, 150.00),
(5, 4, 5, 1, 200.00),
(6, 5, 6, 2, 50.00),
(7, 6, 7, 1, 30.00),
(8, 7, 8, 1, 120.00),
(9, 7, 9, 2, 250.00),
(10, 8, 10, 1, 80.00),
(11, 9, 11, 5, 15.00),
(12, 10, 12, 3, 25.00),
(13, 11, 13, 2, 40.00),
(14, 12, 14, 1, 150.00),
(15, 13, 15, 1, 200.00),
(16, 14, 16, 2, 75.00),
(17, 15, 17, 4, 20.00),
(18, 16, 18, 1, 120.00),
(19, 17, 19, 1, 90.00),
(20, 18, 20, 3, 35.00);

select * from Customers;
select * from orders;

--task1
select 
c.CustomerID,
c.CustomerName,
o.OrderID,
o.OrderDate
from Customers c
left join Orders o
on  c.CustomerID = o.CustomerID;

--task2
select 
c.CustomerID,
c.CustomerName,
o.OrderID,
o.OrderDate
from Customers c
left join Orders o on  c.CustomerID = o.CustomerID
where o.OrderID is NULL

--task3
select ord.OrderID,
ord_det.Price,
ord_det.Quantity,
p.Category,
p.ProductName
from Orders ord
join OrderDetails ord_det
on ord.OrderID = ord_det.OrderID
join Products p
on p.ProductID = ord_det.ProductID

--task4
select c.CustomerID
from Customers c
join Orders o
on c.CustomerID = o.CustomerID
group by c.CustomerID
having sum(case when o.CustomerID = o.CustomerID then 1 else 0 end) >= 2;

--task5
select o.OrderID,
o.OrderDate,
ord.ProductID,
ord.Price,
p.ProductName,
p.Category,
max(Price) over(partition by ord.OrderID) as max_price
from OrderDetails ord
join Orders o
on o.OrderID = ord.OrderID
join Products p
on p.ProductID = ord.ProductID

--task6
select *,
	max(o.OrderDate) over(partition by c.CustomerID) as  latest_order
from Customers c
join Orders o
on c.CustomerID = o.CustomerID;

--task7
select *
from Customers c
join Orders o
on o.CustomerID = c.CustomerID
join  OrderDetails ord 
on ord.OrderID = o.OrderID
join Products p
on p.ProductID = ord.ProductID 
where p.Category in ('Electronics');

--task8
select *
from Customers c
join Orders o
on o.CustomerID = c.CustomerID
join  OrderDetails ord 
on ord.OrderID = o.OrderID
join Products p
on p.ProductID = ord.ProductID 
where p.Category in ('Stationery');

--task9
select c.CustomerName, c.CustomerID,
	coalesce(sum(ord.Quantity * ord.Price), 0) as TotalSpent
from Customers c
left join Orders o
on o.CustomerID = c.CustomerID
left join OrderDetails ord
on ord.OrderID = o.OrderID
group by c.CustomerID, c.CustomerName

--ignore this
--select *
--from Customers c
--join Orders o
--on o.CustomerID = c.CustomerID
--join OrderDetails ord
--on ord.OrderID = o.OrderID;
