Create Database Project_SBD;
Use Project_SBD;

CREATE TABLE brand (
    brand_id VARCHAR(20) PRIMARY KEY,
    brand_name VARCHAR(100)
);

CREATE TABLE brand_origin (
    brand_id VARCHAR(20),
    origin VARCHAR(50)
);

CREATE TABLE produk (
    product_id INT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    product_category VARCHAR(50),
    product_position VARCHAR(50),
    sales_volume INT,
    brand_id VARCHAR(20)
);

CREATE TABLE produk_detail (
    detail_id VARCHAR(20) PRIMARY KEY,
    product_id INT,
    terms VARCHAR(50),
    section VARCHAR(50),
    season VARCHAR(50),
    material VARCHAR(100)
);

--Query
--Query 1
SELECT 
    b.brand_name, 
    SUM(p.price * p.sales_volume) AS total_pendapatan
FROM brand b
JOIN produk p ON b.brand_id = p.brand_id
GROUP BY b.brand_name
ORDER BY total_pendapatan DESC;

--Query 2
SELECT 
    bo.origin AS negara_asal, 
    SUM(p.sales_volume) AS total_terjual
FROM brand_origin bo
JOIN produk p ON bo.brand_id = p.brand_id
GROUP BY bo.origin
ORDER BY total_terjual DESC;

--Query 3
SELECT 
    p.name AS nama_produk, 
    p.price, 
    pd.season, 
    pd.material
FROM produk p
JOIN produk_detail pd ON p.product_id = pd.product_id
ORDER BY p.price DESC
LIMIT 5;

--Query 4
SELECT 
    product_position, 
    ROUND(AVG(price), 2) AS rata_rata_harga,
    COUNT(*) AS jumlah_produk
FROM produk
GROUP BY product_position
ORDER BY rata_rata_harga DESC;

--Query 5
SELECT 
    pd.material, 
    SUM(p.sales_volume) AS total_terjual
FROM produk_detail pd
JOIN produk p ON pd.product_id = p.product_id
WHERE pd.season = 'Winter'
GROUP BY pd.material
ORDER BY total_terjual DESC;

---Query 6
SELECT 
    b.brand_name, 
    bo.origin, 
    p.name AS nama_produk, 
    pd.material,
    p.sales_volume,
    CASE 
        WHEN p.sales_volume >= 1500 THEN 'Best Seller'
        WHEN p.sales_volume >= 1000 THEN 'Laris'
        ELSE 'Kurang Laku'
    END AS status_penjualan
FROM produk p
JOIN brand b ON p.brand_id = b.brand_id
JOIN brand_origin bo ON b.brand_id = bo.brand_id
JOIN produk_detail pd ON p.product_id = pd.product_id
ORDER BY p.sales_volume DESC;

--Query 7
SELECT 
    p.name, 
    p.product_category, 
    p.price, 
    (SELECT ROUND(AVG(price),2) FROM produk WHERE product_category = p.product_category) AS rata_rata_kategori
FROM produk p
WHERE p.price > (
    SELECT AVG(price) FROM produk WHERE product_category = p.product_category
)
ORDER BY p.product_category;

--Query 8
SELECT 
    name, 
    price,
    CASE
        WHEN price > 70 THEN 'Premium'
        WHEN price BETWEEN 30 AND 70 THEN 'Standard'
        ELSE 'Budget'
    END AS kategori_harga
FROM produk;

--Query 9
SELECT 
    b.brand_name, 
    COUNT(DISTINCT pd.material) AS jumlah_jenis_bahan,
    SUM(p.sales_volume) AS total_terjual
FROM brand b
JOIN produk p ON b.brand_id = p.brand_id
JOIN produk_detail pd ON p.product_id = pd.product_id
GROUP BY b.brand_name
HAVING COUNT(DISTINCT pd.material) > 1 
   AND SUM(p.sales_volume) > 2000;

--Query 10
SELECT 
    pd.season, 
    SUM(p.price * p.sales_volume) AS pendapatan_musim,
    ROUND(
        SUM(p.price * p.sales_volume) / (SELECT SUM(price * sales_volume) FROM produk) * 100
    , 2) AS persentase_kontribusi
FROM produk_detail pd
JOIN produk p ON pd.product_id = p.product_id
GROUP BY pd.season
ORDER BY persentase_kontribusi DESC;
