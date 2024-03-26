select * from Sales_Channel;
select * from Sales_Data; -- Fact Table
select * from Sales_Product;
select * from Sales_Product_Sub_Cat;
select * from Sales_Promotion;
select * from Sales_State;

with cte as
(
select * , ROW_NUMBER() over(partition by [Order_Date]
      ,[Cost]
      ,[Price]
      ,[Order_Qty]
      ,[Sales]
      ,[ChannelKey]
      ,[PromotionKey]
      ,[ProductKey]
      ,[ProductSubCategoryKey]
      ,[StateID] order by Order_ID) as dup 
from Sales_Data)
select * , dup from cte
where dup > 1;


select min(Order_Date) , max(Order_Date) from Sales_Data; -- 2011-12-06 : 2014-12-05

select sum(Sales) as Total_Sales from Sales_Data; -- 23804322.5079872

select sum(Sales) as Total_Sales from Sales_Data
where year(Order_Date) = 2014; -- 6709664.00720152

select sum(Sales) as Total_Sales from Sales_Data
where year(Order_Date) = 2013; -- 7527909.63784851

select sum(Sales) as Total_Sales from Sales_Data
where year(Order_Date) = 2012; -- 9044178.89108772

select sum(Sales) as Total_Sales from Sales_Data
where year(Order_Date) = 2011; -- 522569.971849442

select sum(Sales)-sum(Cost) as Total_Profit from Sales_Data; -- 21937945.5225172

select sum(Order_Qty) from Sales_Data; -- 251126

select count(distinct ProductName) from Sales_Product; -- 1690

select sum(Sales)
from Sales_Data
where month(Order_Date) = 2 -- 1493568.58029225

select PromotionName, sum(Sales) as Total_Sales
from Sales_Promotion,Sales_Data
where Sales_Promotion.PromotionKey = Sales_Data.PromotionKey
group by PromotionName
order by Total_Sales desc;

select top 10 ProductName, sum(Order_Qty) as Quantity , sum(Sales) as Total_Sales
from Sales_Product,Sales_Data
where Sales_Product.ProductKey = Sales_Data.ProductKey
group by ProductName
order by Total_Sales desc;

select BrandName, sum(Sales) as Total_Sales
from Sales_Product,Sales_Data
where Sales_Product.ProductKey = Sales_Data.ProductKey
group by BrandName
order by Total_Sales desc;

select Product_Category, sum(Sales) as Total_Sales
from Sales_Product_Sub_Cat,Sales_Data
where Sales_Product_Sub_Cat.ProductSubCategoryKey = Sales_Data.ProductSubCategoryKey
group by  Product_Category
order by Total_Sales desc;

select ChannelName, sum(Sales) as Total_Sales
from Sales_Channel,Sales_Data
where Sales_Channel.ChannelKey = Sales_Data.ChannelKey
group by ChannelName
order by Total_Sales desc;

select State, sum(Sales) as Total_Sales
from Sales_State,Sales_Data
where Sales_State.StateID = Sales_Data.StateID
group by State
order by Total_Sales desc;


















