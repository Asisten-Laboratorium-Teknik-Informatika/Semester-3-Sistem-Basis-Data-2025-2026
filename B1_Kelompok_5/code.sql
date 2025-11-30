CREATE DATABASE IF NOT EXISTS BMW;
USE BMW;

CREATE TABLE model (
    Model_ID INT PRIMARY KEY,
    Model_Name VARCHAR(100),
    Engine_Size_L FLOAT,
    Fuel_Type VARCHAR(50),
    Transmission VARCHAR(50)
);

CREATE TABLE region (
    Region_ID INT PRIMARY KEY,
    Region_Name VARCHAR(100)
);

CREATE TABLE sales (
    Sale_ID INT PRIMARY KEY,
    Model_ID INT,
    Region_ID INT,
    Year INT,
    Color VARCHAR(50),
    Mileage_KM INT,
    Price_USD DECIMAL(10,2),
    Sales_Volume INT,
    FOREIGN KEY (Model_ID) REFERENCES model(Model_ID),
    FOREIGN KEY (Region_ID) REFERENCES region(Region_ID)
);

LOAD DATA LOCAL INFILE '/Users/...../Downloads/csv/model.csv'
INTO TABLE model
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Model_ID, Model_Name, Engine_Size_L, Fuel_Type, Transmission);

LOAD DATA LOCAL INFILE '/Users/...../Downloads/csv/region.csv'
INTO TABLE region
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Region_ID, Region_Name);

LOAD DATA LOCAL INFILE '/Users/...../Downloads/csv/sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Sale_ID, Model_ID, Region_ID, Year, Color, Mileage_KM, Price_USD, Sales_Volume);


-- Query

-- 1. Cari model dengan harga rata-rata tertinggi
SELECT 
    m.Model_Name,
    (SELECT AVG(s.Price_USD) 
     FROM sales s 
     WHERE s.Model_ID = m.Model_ID) AS Avg_Price
FROM model m
ORDER BY Avg_Price DESC;

-- 2. Tampilkan region yang total penjualannya di atas rata-rata seluruh region
SELECT 
    r.Region_Name,
    SUM(s.Sales_Volume) AS Total_Sales
FROM region r
JOIN sales s ON r.Region_ID = s.Region_ID
GROUP BY r.Region_ID
HAVING SUM(s.Sales_Volume) >
       (SELECT AVG(Total_Sales) 
        FROM (
            SELECT SUM(s2.Sales_Volume) AS Total_Sales
            FROM sales s2
            GROUP BY s2.Region_ID
        ) AS t);

-- 3. Nested query untuk mencari model dengan harga di atas harga rata-rata global per tahun
SELECT 
    m.Model_Name,
    s.Year,
    s.Price_USD
FROM sales s
JOIN model m ON m.Model_ID = s.Model_ID
WHERE s.Price_USD >
    (SELECT AVG(s2.Price_USD)
     FROM sales s2
     WHERE s2.Year = s.Year);

-- 4. Nested query untuk mencari region yang paling dominan untuk setiap model
SELECT 
    m.Model_Name,
    r.Region_Name,
    s.Sales_Volume
FROM sales s
JOIN model m ON m.Model_ID = s.Model_ID
JOIN region r ON r.Region_ID = s.Region_ID
WHERE s.Sales_Volume =
    (SELECT MAX(s2.Sales_Volume)
     FROM sales s2
     WHERE s2.Model_ID = s.Model_ID);

-- Query 5 : Untuk menghitung total pendapatan penjualan.
SELECT 
    Sale_ID,
    Model_ID,
    Region_ID,
    Year,
    Color,
    Mileage_KM,
    Price_USD,
    Sales_Volume,
    (Price_USD * Sales_Volume) AS Total_Revenue
FROM sales
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Query 6 : Untuk menghitung total omzet per model, lalu menampilkan 3 model dengan omzet tertinggi.
SELECT Model, total_omzet
FROM (
    SELECT 
        m.Model,
        SUM(s.Price_USD * s.Sales_Volume) AS total_omzet
    FROM sales s
    JOIN model m ON s.Model_ID = m.Model_ID
    GROUP BY m.Model
) AS x
ORDER BY total_omzet DESC
LIMIT 3;

-- Query 7 : Average harga per transaksi per region menggunakan AVG price_USD.
SELECT 
    r.Region,
    AVG(s.Price_USD) AS avg_transaksi
FROM sales s
JOIN region r ON s.Region_ID = r.Region_ID
GROUP BY r.Region
ORDER BY avg_transaksi DESC
LIMIT 5;

-- Query 8 : Untuk mengambil tahun dan menghitung total penjualan per tahun.
SELECT year, SUM(sales_volume) AS total_tahunan
FROM sales
GROUP BY year
ORDER BY year;

-- Query 9 : Untuk mencari wilayah (region) yang memiliki total penjualan terbesar.
SELECT r.region_name, SUM(s.Sales_Volume) AS total_penjualan
FROM sales s
JOIN region r ON s.region_id = r.region_id
GROUP BY r.region_name
ORDER BY total_penjualan DESC
LIMIT 1;

-- Query 10 : Untuk menentukan model mobil dengan rata-rata harga (Price_USD) tertinggi berdasarkan data tabel sales dan model.
SELECT 
    m.Model_ID,
    AVG(CAST(s.Price_USD AS DECIMAL(10,2))) AS rata_harga
FROM sales s
JOIN model m ON s.Model_ID = m.Model_ID
GROUP BY m.Model_ID
ORDER BY rata_harga DESC
LIMIT 1;

