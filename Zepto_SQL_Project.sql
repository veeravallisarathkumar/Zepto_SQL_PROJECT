drop table if exists zepto;

create table zepto(
 sku_id SERIAL PRIMARY KEY,
 category VARCHAR(120),
 name VARCHAR(150) NOT NULL,
 mrp NUMERIC(8,2),
 discountPercent NUMERIC(5,2),
 availableQuantity INTEGER,
 discountedSellingPrice NUMERIC(8,2),
 weightInGms INTEGER,
 outofStock BOOLEAN,
 quantity INTEGER
);

---data exploration

---count of rows
SELECT COUNT(*) FROM zepto;

---sample data
SELECT * FROM  zepto
LIMIT 10;

--null values
SELECT 
COUNT(*) AS total_rows,
COUNT(*) - COUNT(category) AS Null_category,
COUNT(*) - COUNT(name) AS name,
COUNT(*) - COUNT(mrp) AS mrp,
COUNT(*) - COUNT(discountpercent) AS discountpercent,
COUNT(*) - COUNT(availablequantity) AS availablequantity,
COUNT(*) - COUNT(discountedsellingprice) AS discountedsellingprice,
COUNT(*) - COUNT(weightInGms) AS weightInGms,
COUNT(*) - COUNT(outOfStock) AS outOfStock
FROM zepto

--different product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

--products in stock vs out of stock
SELECT outofStock, COUNT(*) AS product_count
FROM zepto
GROUP BY outofStock

--product names present multiple times
SELECT name, COUNT(sku_id) AS  "Number of skus"
FROM zepto
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;

--Data cleaning

--Product with price = 0
SELECT * FROM zepto
WHERE mrp = 0 or discountedSellingPrice =0 ;

DELETE FROM zepto
WHERE mrp = 0;

--convert paise to rupees
UPDATE zepto
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp, discountedSellingPrice FROM zepto

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--Q2. What are the Products with High MRP but Out of Stock
SELECT DISTINCT name, mrp 
FROM zepto
WHERE outofStock = True and mrp > 300
ORDER BY mrp DESC

--Q3. Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

--Q4. Find all products where MRP is greater than rs500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

--Q5. Identify the top 5 categories offering the highest average discount percentage
SELECT category, avg(discountPercent) AS avg_discount
From zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT  5

--Q6.  Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >=100
ORDER BY price_per_gram;

--Q7. Group the products into categories like Low, Medium, Bulk,
SELECT DISTINCT name, weightInGmS,
CASE WHEN weightInGms < 1000 Then 'Low'
     WHEN weightInGms < 5000 Then 'Medium'
     ELSE 'Bulk'
     END AS weight_category
FROM zepto

--Q8. What is the Total Inventory weight Per Category
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;

--Constraints & Validation
ALTER TABLE zepto
ADD CONSTRAINT chk_valid_mrp CHECK (mrp >= 0),
ADD CONSTRAINT chk_valid_discount CHECK (discountPercent BETWEEN 0 AND 100);

--User Roles and Permissions (simulation)
CREATE ROLE analyst LOGIN PASSWORD 'analystpass';
GRANT SELECT ON zepto TO analyst;

CREATE ROLE editor LOGIN PASSWORD 'editorpass';
GRANT SELECT, UPDATE ON zepto TO editor;

--Indexing for Performance
CREATE INDEX idx_outofstock ON zepto(outofStock);
CREATE INDEX idx_category_name ON zepto(category, name);

--Monitoring Table Usage
SELECT
  COUNT(*) AS row_count,
  pg_size_pretty(pg_total_relation_size('zepto')) AS table_size
FROM zepto;










