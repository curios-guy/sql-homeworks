use lesson3;
drop table Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY identity,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

insert into Orders(CustomerName, OrderDate, TotalAmount, Status)
values ('Sam Altman', '2025-01-30', 120.45, 'Shipped'),
('Mark Zuckerberg', '2022-12-15', 321.12, 'Cancelled'),
('Tim Cook', '2023-05-31', 1290.80, 'Shipped'),
('Elon Musk', '2025-02-24', 29000.80, 'Pending'),
('Paelo Coelo', '2024-12-30', 12.90, 'Cancelled'),
('Kimsan', '2013-12-12', 120, 'Delivered')

select * 
from Orders
where OrderDate between '2023-01-01' and '2023-12-31';

select Status,
	IIF(Status = 'Shipped' or Status = 'Delivered', 'Completed',
		IIF(Status = 'Pending', 'Pending', 'Cancelled'
		)
	) as OrderStatus
from Orders
group by Status;

select  count(*) as numberOfOrders, sum(TotalAmount) as totalRevenue, Status,
	IIF(Status = 'Shipped' or Status = 'Delivered', 'Completed',
		IIF(Status = 'Pending', 'Pending', 'Cancelled'
		)
	) as OrderStatus
from Orders
group by Status;

select * 
from Orders
where TotalAmount > 5000;


select * 
from Orders
order by TotalAmount desc;