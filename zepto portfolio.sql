SELECT COUNT(*) FROM zepto2;
--DATA OVERVEIW
----sample data
select *from zepto2
limit 10;
--null values analysis
select * from zepto2 
where name is null
OR
category is null
OR
mrp is null
OR
discountPercent is null
OR
discountedSellingPrice is null
OR
availableQuantity is null
OR
outOfStock is null
OR
quantity is null;S
--DIFFRENT CATEGORY PRODUCTS IN STOCK
SELECT DISTINCT CATEGORY FROM zepto2
ORDER BY CATEGORY;

---PRODUCTS IN STOCK VS OUT OF STOCK
SELECT outOfStock, COUNT(sku_id)
from zepto2
GROUP BY outOfStock;

--PRODUCT NAMES PRESENT MULTIPLE TIMES
select name, COUNT(sku_id) as "number of SKUs"
from zepto2
GROUP BY name
HAVING COUNT(sku_id)>1

order by count(sku_id) DESC;
--DATA CLEANING

--PRODUCT WITH PRICE =0
select * from zepto
where mrp = 0 OR discountedSellingPrice = 0;

--CONVERT PAISE TO RUPEE
UPDATE zepto2
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp, discountedSellingPrice from zepto2;
----BUSINESS QUESTION
---Q1. FIND THE TOP 10 BEST VALUE WITH HIGH MRP BASED ON DISCOUNT PERCENT.
select distinct name, mrp, discountPercent
from zepto2
order by discountPercent DESC
limit 10

-----Q2. PRODUCTS WITH HIGH MRP BUT OUT OF STOCK.
select distinct name, mrp
FROM zepto2
where outOfStock = TRUE AND mrp > 300
ORDER BY mrp DESC

---CALCULATE ESTIMATED CATEGORY REVENUE FOR EACH CATEGORY
SELECT category,
sum(discountedSellingPrice * availableQuantity) As total_revenue
from zepto2 
group by category
order by total_revenue;

---FIND ALL PRODUCTS WHERE PRICE IS GREATER THAN 500 AND DISCOUNT IS LESS THAN 10%.
select distinct name, mrp, discountPercent
from zepto2
where mrp > 500 and discountPercent < 10
order by mrp Desc, discountPercent Desc;

---Q5. IDENTYFY TOP 5 CATEGORIES OFFERING THE HIGHEST AVERAGE DISCOUNT PERCENTAGE.
SELECT category,
 ROUND(avg(discountPercent),2) as avg_discount
 FROM zepto2
 group by category
 order by avg_discount desc
 limit 5;

---Q6. FIND THE PRICE PER GRAM FOR PRODUCTS ABOVE 100G AND SORT BY BEST VALUE.

select distinct name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) as price_per_gram
from zepto2 
where weightInGms >=100
order by price_per_gram;

---Q7. GROUP THE PRODUCTS INTO CATEGORIES LIKE LOW, MIDIUM,BULK.
select distinct name, weightInGms,
CASE WHEN weightInGms <1000 THEN 'low'
 when weightInGms < 5000 Then 'medium'
 else 'bulk'
 end as weight_category
 from zepto2;
 --WHAT IS THE TOTAL INVENTORY WEIGHT PER CATEGORY.
 SELECT category,
 sum(weightInGms * availableQuantity) as total_weight
 from zepto2
 group by category
 order by total_weight;



