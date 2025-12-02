CREATE DATABASE IF NOT EXISTS superstore_fix;
USE superstore_fix;

DROP TABLE IF EXISTS shipmodes;
CREATE TABLE shipmodes (
    ship_mode_id VARCHAR(8) PRIMARY KEY,
    ship_mode VARCHAR(50) NOT NULL
);
LOAD DATA INFILE 'C:/Users/User/Downloads/fix/shipmodes.csv'
INTO TABLE shipmodes
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ship_mode_id, ship_mode);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id VARCHAR(8) PRIMARY KEY,
    Category VARCHAR(50) NOT NULL,
    Sub_Category VARCHAR(50) NOT NULL
);
LOAD DATA INFILE 'C:/Users/User/Downloads/fix/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id, Category, Sub_Category);

DROP TABLE IF EXISTS locations;
CREATE TABLE locations (
    location_id VARCHAR(8) PRIMARY KEY,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Postal_Code INT NOT NULL
);
LOAD DATA INFILE 'C:/Users/User/Downloads/fix/locations.csv'
INTO TABLE locations
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(location_id, City, State, Postal_Code);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id VARCHAR(8) PRIMARY KEY,
    Segment VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Region VARCHAR(50) NOT NULL
);
LOAD DATA INFILE 'C:/Users/User/Downloads/fix/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, Segment, Country, Region);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    sales_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(8),
    location_id VARCHAR(8),
    product_id VARCHAR(8),
    ship_mode_id VARCHAR(8),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (ship_mode_id) REFERENCES shipmodes(ship_mode_id)
);
LOAD DATA INFILE 'C:/Users/User/Downloads/fix/sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(sales_id, customer_id, location_id, product_id, ship_mode_id, Sales, Quantity, Discount, Profit);

SELECT product_id, 
       (SELECT Category FROM products p WHERE p.product_id = s.product_id) AS Category,
       SUM(Sales) AS total_sales
FROM sales s
GROUP BY product_id
HAVING SUM(Sales) = (
    SELECT MAX(total_sales)
    FROM (
        SELECT SUM(Sales) AS total_sales
        FROM sales
        GROUP BY product_id
    ) AS t
);

SELECT customer_id,
       (SELECT Segment FROM customers c WHERE c.customer_id = s.customer_id) AS Segment,
       SUM(Profit) AS total_profit
FROM sales s
GROUP BY customer_id
HAVING SUM(Profit) = (
    SELECT MAX(tp)
    FROM (
        SELECT SUM(Profit) AS tp
        FROM sales
        GROUP BY customer_id
    ) AS x
);

SELECT Region, avg_sales
FROM (
    SELECT Region, AVG(Sales) AS avg_sales
    FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
    GROUP BY Region
) AS t
WHERE avg_sales = (
    SELECT MAX(avg_sales)
    FROM (
        SELECT Region, AVG(Sales) AS avg_sales
        FROM sales s
        JOIN customers c ON s.customer_id = c.customer_id
        GROUP BY Region
    ) AS y
);

SELECT *
FROM sales
WHERE Profit > (
    SELECT AVG(Profit)
    FROM sales
);

SELECT State, total_trans
FROM (
    SELECT l.State, COUNT(*) AS total_trans
    FROM sales s
    JOIN locations l ON s.location_id = l.location_id
    GROUP BY l.State
) AS t
WHERE total_trans > (
    SELECT AVG(total_trans)
    FROM (
        SELECT COUNT(*) AS total_trans
        FROM sales s
        JOIN locations l ON s.location_id = l.location_id
        GROUP BY l.State
    ) AS x
);

SELECT product_id, Category, total_qty
FROM (
    SELECT pr.product_id,
           pr.Category,
           SUM(s.Quantity) AS total_qty
    FROM sales s
    JOIN products pr ON s.product_id = pr.product_id
    GROUP BY pr.product_id, pr.Category
) AS t
WHERE total_qty = (
    SELECT MAX(total_qty)
    FROM (
        SELECT product_id, SUM(Quantity) AS total_qty
        FROM sales
        GROUP BY product_id
    ) AS y
);

SELECT City, total_profit
FROM (
    SELECT l.City, SUM(s.Profit) AS total_profit
    FROM sales s
    JOIN locations l ON s.location_id = l.location_id
    GROUP BY l.City
) AS t
WHERE total_profit > (
    SELECT AVG(Profit)
    FROM sales
);

SELECT customer_id
FROM sales
WHERE ship_mode_id = (
    SELECT ship_mode_id 
    FROM shipmodes
    WHERE ship_mode = 'Standard Class'
);

SELECT Category, avg_discount
FROM (
    SELECT pr.Category, AVG(s.Discount) AS avg_discount
    FROM sales s
    JOIN products pr ON s.product_id = pr.product_id
    GROUP BY pr.Category
) AS t
WHERE avg_discount = (
    SELECT MAX(avg_discount)
    FROM (
        SELECT pr.Category, AVG(s.Discount) AS avg_discount
        FROM sales s
        JOIN products pr ON s.product_id = pr.product_id
        GROUP BY pr.Category
    ) AS x
);

SELECT *
FROM sales
WHERE location_id IN (
    SELECT location_id
    FROM locations
    WHERE State = (
        SELECT State
        FROM (
            SELECT l.State, SUM(s.Sales) AS total_sales
            FROM sales s
            JOIN locations l ON s.location_id = l.location_id
            GROUP BY l.State
            ORDER BY total_sales DESC
            LIMIT 1
        ) AS t
    )
);
