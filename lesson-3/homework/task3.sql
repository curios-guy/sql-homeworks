use lesson3;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY identity,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products (ProductName, Category, Price, Stock) VALUES
('Laptop', 'Electronics', 1200.00, 15),
('Smartphone', 'Electronics', 800.00, 30),
('Headphones', 'Electronics', 150.00, 50),
('TV', 'Electronics', 900.00, 10),
('Refrigerator', 'Appliances', 1100.00, 8),
('Microwave', 'Appliances', 300.00, 20),
('Washing Machine', 'Appliances', 700.00, 5),
('Air Conditioner', 'Appliances', 1300.00, 7),
('Sofa', 'Furniture', 550.00, 12),
('Dining Table', 'Furniture', 800.00, 6),
('Office Chair', 'Furniture', 250.00, 20),
('Bed Frame', 'Furniture', 900.00, 4),
('Running Shoes', 'Clothing', 120.00, 40),
('Jacket', 'Clothing', 200.00, 25),
('Jeans', 'Clothing', 60.00, 35),
('T-shirt', 'Clothing', 25.00, 50),
('Wristwatch', 'Accessories', 500.00, 18),
('Backpack', 'Accessories', 90.00, 22),
('Sunglasses', 'Accessories', 150.00, 14),
('Perfume', 'Accessories', 75.00, 30);

select distinct category from Products;

SELECT Category, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

select Stock,
	IIF(Stock = 0, 'Out of Stock', 
		IIF(Stock between 1 and 10, 'Low Stock', 'In Stock')
		) as InStock
from Products;


select Price, Stock,
	IIF(Stock = 0, 'Out of Stock', 
		IIF(Stock between 1 and 10, 'Low Stock', 'In Stock')
		) as InStock
from Products
order by Price desc;

--select category, count(category) as cnt from Products group by Category;
