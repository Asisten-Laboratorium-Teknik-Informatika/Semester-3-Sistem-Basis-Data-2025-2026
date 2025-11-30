USE proyek_sbd;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE table_customers (
    Customer_ID VARCHAR(50) NOT NULL,
    Gender VARCHAR(20),
    Age INT,
    PRIMARY KEY (Customer_ID)
);

CREATE TABLE table_products (
    Product_ID VARCHAR(100) NOT NULL,
    Product_Category VARCHAR(50),
    Price_per_Unit INT,
    PRIMARY KEY (Product_ID)
);

CREATE TABLE table_transactions (
    Transaction_ID INT NOT NULL,
    Transaction_Date VARCHAR(20), 
    Quantity INT,
    Customer_ID VARCHAR(50),
    Product_ID VARCHAR(100),
    
    PRIMARY KEY (Transaction_ID),
    FOREIGN KEY (Customer_ID) REFERENCES table_customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES table_products(Product_ID)
);

SET FOREIGN_KEY_CHECKS = 1;

-- Soal 1 : Siapa 5 pelanggan yang paling royal jajan?

SELECT 
    C.Customer_ID, 
    C.Gender, 
    SUM(T.Quantity * P.Price_per_Unit) AS Total_Belanja
FROM 
    table_transactions T
JOIN 
    table_customers C ON T.Customer_ID = C.Customer_ID
JOIN 
    table_products P ON T.Product_ID = P.Product_ID
GROUP BY 
    C.Customer_ID, C.Gender
ORDER BY 
    Total_Belanja DESC
LIMIT 5;

-- Soal 2 : Lebih untung jualan ke cowok atau cewek?

SELECT 
    C.Gender, 
    SUM(T.Quantity * P.Price_per_Unit) AS Total_Omzet
FROM 
    table_transactions T
JOIN 
    table_customers C ON T.Customer_ID = C.Customer_ID
JOIN 
    table_products P ON T.Product_ID = P.Product_ID
GROUP BY 
    C.Gender;

-- Soal 3 : Kelompok umur mana yang paling banyak ngabisin duit?

SELECT 
    CASE 
        WHEN C.Age <= 20 THEN 'Remaja (<=20)'
        WHEN C.Age <= 35 THEN 'Dewasa Muda (21-35)'
        WHEN C.Age <= 50 THEN 'Dewasa (36-50)'
        ELSE 'Senior (>50)'
    END AS Kelompok_Usia,
    SUM(T.Quantity * P.Price_per_Unit) AS Total_Omzet
FROM 
    table_transactions T
JOIN 
    table_customers C ON T.Customer_ID = C.Customer_ID
JOIN 
    table_products P ON T.Product_ID = P.Product_ID
GROUP BY 
    Kelompok_Usia
ORDER BY 
    Total_Omzet DESC;

-- Soal 4 : Kategori barang apa yang paling laris?

SELECT 
    P.Product_Category, 
    SUM(T.Quantity) AS Total_Barang_Terjual
FROM 
    table_transactions T
JOIN 
    table_products P ON T.Product_ID = P.Product_ID
GROUP BY 
    P.Product_Category
ORDER BY 
    Total_Barang_Terjual DESC;
    
-- Soal 5 : Kategori barang apa yang paling menguntungkan?

SELECT 
    P.Product_Category, 
    SUM(T.Quantity * P.Price_per_Unit) AS Total_Omzet
FROM 
    table_transactions T
JOIN 
    table_products P ON T.Product_ID = P.Product_ID
GROUP BY 
    P.Product_Category
ORDER BY 
    Total_Omzet DESC;
    
-- Soal 6 : Tiga barang spesifik apa yang jadi 'best seller'?

SELECT 
    P.Product_ID,
    P.Product_Category,
    P.Price_per_Unit,
    SUM(T.Quantity) AS Total_Terjual
FROM 
    table_transactions T
JOIN 
    table_products P ON T.Product_ID = P.Product_ID
GROUP BY 
    P.Product_ID, P.Product_Category, P.Price_per_Unit
ORDER BY 
    Total_Terjual DESC
LIMIT 3;

-- Soal 7 : Gimana sih tren penjualan bulanan di toko ini?

SELECT 
    MONTH(STR_TO_DATE(T.Transaction_Date, '%d/%m/%Y')) AS Bulan,
    SUM(P.Price_per_Unit * T.Quantity) AS Total_Omzet
FROM 
    table_transactions T
JOIN 
    table_products P ON T.Product_ID = P.Product_ID
GROUP BY 
    Bulan
ORDER BY 
    Bulan ASC;
    
-- Soal 8 : Hari apa yang paling rame orang belanja?

SELECT 
    DAYNAME(STR_TO_DATE(T.Transaction_Date, '%d/%m/%Y')) AS Nama_Hari,
    COUNT(T.Transaction_ID) AS Jumlah_Transaksi
FROM 
    table_transactions T
GROUP BY 
    Nama_Hari
ORDER BY 
    Jumlah_Transaksi DESC;
    
-- Soal 9 : Rata-rata orang sekali belanja habis berapa duit?

SELECT 
    AVG(Total_Belanja_Per_Transaksi) AS Rata_Rata_Belanja
FROM (
    SELECT 
        T.Transaction_ID,
        SUM(T.Quantity * P.Price_per_Unit) AS Total_Belanja_Per_Transaksi
    FROM 
        table_transactions T
    JOIN 
        table_products P ON T.Product_ID = P.Product_ID
    GROUP BY 
        T.Transaction_ID
) AS Struk_Belanja;

-- Soal 10 : Barang spesifik apa (Product_ID) yang kasih omzet paling besar?

SELECT 
    P.Product_ID,
    P.Product_Category,
    P.Price_per_Unit,
    SUM(T.Quantity * P.Price_per_Unit) AS Total_Omzet_Barang
FROM 
    table_transactions T
JOIN 
    table_products P ON T.Product_ID = P.Product_ID
GROUP BY 
    P.Product_ID, P.Product_Category, P.Price_per_Unit
ORDER BY 
    Total_Omzet_Barang DESC
LIMIT 5;