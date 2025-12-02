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
