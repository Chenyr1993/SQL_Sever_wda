--一(一)1.
select* from Employees
where City='London'

--一(一)2.
select* from Employees
where HireDate >= '1993-01-01'

--一(一)3.
select* from Orders
where ShipCity='Reims'or ShipCity='Lander' or ShipCity='Madrid'
order by ShipCity

--一(一)4.
select top 6  with ties*
from Products
order by UnitsInStock desc

--一(一)5.
select OrderID,ProductID from OrderDetails
where OrderID=10847

--一(一)6.
select * from Orders
where ShippedDate is null

--一(一)7.
select * from Customers
where City in('Montreal','Lisboa','Lyon','Stavern','Geneve','Bruxelles','Madrid')
order by City

--一(一)8.
select* from OrderDetails
where Quantity Between 20 and 40
order by Quantity

--一(二)1.
select ProductID,CategoryID,AVG(UnitPrice) as 平均單價  from Products
where CategoryID=2
group by ProductID, CategoryID

--一(二)2.
select * from Products
where UnitsInStock<=ReorderLevel and UnitsOnOrder=0 and Discontinued=0

--一(二)3.
select OrderID ,count(*) as 包含商品數 from OrderDetails
group by OrderID 
having count(*)>5

--一(二)4.
select *,UnitPrice*Quantity*(1-Discount) as 小計 from OrderDetails
where OrderID=10263

--一(二)5.利用group by 加總同個OrderID
select SupplierID,COUNT(*) as 提供產品數 from Products
group by SupplierID

--一(二)6.
select CustomerID,EmployeeID,count(*) as 員工服務次數 from Orders
group by CustomerID,EmployeeID

--一(二)7.因為表單上已經有單價及數量，直接平均即可

select ProductID,AVG(UnitPrice) as 平均單價, AVG(ProductID) as 平均銷售數量 
from OrderDetails
group by ProductID
having AVG(ProductID)>10
order by ProductID

--二1.


Select o.OrderID as 訂單號碼 ,cg.CategoryName as 產品類別 ,p.ProductName as 產品名稱 ,od.UnitPrice as 訂購單價 ,od.Quantity as 訂購數量,
Round(od.UnitPrice*od.Quantity*(1-od.Discount),0) as 產品價格小計,o.CustomerID as 客戶編號,o.ShipName as 客戶名稱,c.ContactName as 收貨人姓名,
o.OrderDate as 訂購日期,(e.FirstName+e.LastName) as 處理員工姓名,sh.CompanyName as 貨運公司,s.CompanyName as 供應商

from OrderDetails as od inner join Orders as o
on od.OrderID=o.OrderID
inner join Shippers as sh
on o.ShipVia=sh.ShipperID
inner join Products as p
on od.ProductID=p.ProductID
inner join Categories as cg
on p.CategoryID=cg.CategoryID
inner join Customers as c
on o.CustomerID=c.CustomerID
inner join Employees as e
on o.EmployeeID=e.EmployeeID
inner join Suppliers as s
on p.SupplierID=s.SupplierID
where (o.OrderDate between '1996-07-01' and '1996-07-31') and sh.CompanyName='United Package'
group by o.OrderID ,cg.CategoryName ,p.ProductName ,od.UnitPrice,od.Quantity,
o.CustomerID,o.ShipName ,c.ContactName,od.Discount,e.FirstName,e.LastName,
o.OrderDate,sh.CompanyName,s.CompanyName 

--二2.
Select * from Orders
Select * from Customers
Select* from Products
Select * from OrderDetails
Select * from Shippers
Select* from Employees
Select* from Suppliers

select o.CustomerID,c.ContactName,p.ProductName,sum(od.Quantity) as Quantity
from Orders as o inner join OrderDetails as od
on o.OrderID=od.OrderID
inner join Customers as c
on o.CustomerID=c.CustomerID
inner join Products as p
on od.ProductID=p.ProductID
where o.CustomerID='ANTON'
group by o.CustomerID,c.ContactName,p.ProductName
order by P.ProductName

--二3.
select *
from Customers
where not exists (select* from Orders where Customers.CustomerID=Orders.CustomerID )

--二4.

select Employees.EmployeeID,(Employees.FirstName+','+Employees.LastName) as Name,Employees.Title,Employees.Extension,Employees.Notes  
from Employees
where EmployeeID
in(select EmployeeID  from Orders) 

--二5.
select*from Orders
--合併查詢
select p.ProductID,p.ProductName,p.QuantityPerUnit,p.UnitPrice,p.UnitsInStock,p.UnitsOnOrder,p.CategoryID,p.Discontinued,p.SupplierID,p.ReorderLevel,SUM(od.Quantity) as Quanity
from Products as p
left outer join OrderDetails as od
on p.ProductID=od.ProductID
inner join Orders as o
on od.OrderID=o.OrderID
where (o.OrderDate between '1998-01-01' and '1998-12-31') 
group by p.ProductID,p.ProductName,p.QuantityPerUnit,p.UnitPrice,p.UnitsInStock,p.UnitsOnOrder,p.CategoryID,p.Discontinued,p.SupplierID,p.ReorderLevel
order by p.ProductID

--子查詢(記得要把所有資料表拉關聯！！！)

select *
from Products 
where exists (select * from OrderDetails 
where exists (select * from Orders 
where OrderDate between '1998-01-01' and '1998-12-31' 
and OrderDetails.OrderID=Orders.OrderID 
and Products.ProductID=OrderDetails.ProductID) )

select *
from Products 
where ProductID in (select ProductID from OrderDetails 
where OrderID in (select OrderID from Orders 
where OrderDate between '1998-01-01' and '1998-12-31'
) )

