-- Buat table badges
CREATE TABLE badges (
    badge_id VARCHAR(10) PRIMARY KEY,
    badge_name VARCHAR(50)
);
-- Import data
LOAD DATA LOCAL INFILE 'E:/download/BADGES_TB.csv'
INTO TABLE badges
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(badge_id, badge_name);

-- Buat table models
CREATE TABLE models (
    model_id VARCHAR(10) PRIMARY KEY,
    model_name VARCHAR(100)
);
-- Import data
LOAD DATA LOCAL INFILE 'E:/download/MODELS_TB.csv'
INTO TABLE models
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(model_id, model_name);

-- Buat table variants
CREATE TABLE variants (
    varian_id VARCHAR(10) PRIMARY KEY,
    varian_name VARCHAR(100),
    model_id VARCHAR(10),
    FOREIGN KEY (model_id) REFERENCES models(model_id)
);
-- Import data
LOAD DATA LOCAL INFILE 'E:/download/VARIANS_TB.csv'
INTO TABLE variants
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(varian_id, varian_name, model_id);

-- Buat table Reviews
CREATE TABLE reviews (
    review_id VARCHAR(10) PRIMARY KEY,
    review DECIMAL(3,1),
    review_count INT
);
-- Import data
LOAD DATA LOCAL INFILE 'E:/download/REVIEWS_TB.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(review_id, review, review_count);


-- Buat table used_car_list
create table used_car_list(
    car_list_id varchar(10) primary key,
    varian_id varchar(10),
    tahun int,
    price int,
    mileage int,
    badge_id varchar(10),
    review_id varchar(10),
    foreign key (varian_id) references variants(varian_id),
    foreign key (badge_id) references badges(badge_id),
    foreign key (review_id) references reviews(review_id)
);
-- Import data
load data infile 'E:/download/USED_CAR_LIST_TB.csv'
into table used_car_list
fields terminated by ','
ignore 1 rows;

-- Perintah SQL
-- 1.Cari mobil dengan harga di bawah rata-rata, tetapi mileage di atas rata-rata.
SELECT *
FROM used_car_list
WHERE price < (SELECT AVG(price) FROM used_car_list)
  AND mileage > (SELECT AVG(mileage) FROM used_car_list);

-- 2.Cari badge paling sering muncul di mobil keluaran tahun 2020–2022
SELECT badge_id, COUNT(*) AS total
FROM used_car_list
WHERE tahun BETWEEN 2020 AND 2022
GROUP BY badge_id
ORDER BY total DESC;

-- 3.Cari mobil yang overpriced
SELECT
    used_car_list.car_list_id,
    used_car_list.tahun,
    used_car_list.price,
    tahun_avg.avg_price AS tahun_avg_price
FROM used_car_list
JOIN (
        SELECT 
            used_car_list.tahun, 
            AVG(used_car_list.price) AS avg_price
        FROM used_car_list
        GROUP BY used_car_list.tahun
    ) AS tahun_avg
    ON used_car_list.tahun = tahun_avg.tahun
WHERE used_car_list.price > tahun_avg.avg_price;

-- 4.Menghitung Total Nilai Jual Kumulatif Berdasarkan Tahun Pembuatan, Diurutkan dari Tertinggi ke Terendah
SELECT
  tahun,
  SUM(price) AS total_price
FROM used_car_price.used_car_list
GROUP BY tahun
ORDER BY total_price DESC;

-- 5.Melihat semua varian dari terbanyak ke tersedikit
SELECT
  varian_name,
  COUNT(*) AS total_varian
FROM used_car_price.used_car_list
JOIN used_car_price.variants
USING (varian_id)
GROUP BY varian_name
ORDER BY total_varian DESC;

-- 6.Menampilkan 5 Varian dengan Kondisi Terbaik (Mileage Terendah)
SELECT
  V.varian_name,
  ROUND(AVG(C.mileage), 0) AS Rata_Rata_KM,
  COUNT(C.car_list_id) AS Jumlah_Unit
FROM used_car_list AS C
JOIN variants AS V ON C.varian_id = V.varian_id
GROUP BY V.varian_name
ORDER BY Rata_Rata_KM ASC
LIMIT 5;

-- 7.Perbandingan Harga Rata-Rata per Badge
SELECT
    B.badge_name,
    ROUND(AVG(C.price), 2) AS Rata_Rata_Harga,
    COUNT(C.car_list_id) AS Total_Unit
FROM
    used_car_list AS C
JOIN
    badges AS B ON C.badge_id = B.badge_id
GROUP BY
    B.badge_name
ORDER BY
    Rata_Rata_Harga ASC;

-- 8.Tampilkan Model Mobil dengan Rasio Kualitas per Harga (Review/Price) tertinggi.
SELECT
    M.MODEL_NAME,
    ROUND(AVG(R.REVIEW) / AVG(C.PRICE), 7) AS Rasio_Kualitas_per_Harga
FROM
    CAR_LISTINGS AS C
JOIN
    REVIEWS AS R ON C.REVIEW_ID = R.REVIEW_ID
JOIN
    VARIAN_TB AS V ON C.VARIAN_ID = V.VARIAN_ID
JOIN
    MODELS_TB AS M ON V.MODEL_ID = M.MODEL_ID
GROUP BY
    M.MODEL_NAME
ORDER BY
    Rasio_Kualitas_per_Harga DESC
LIMIT 5;

-- 9.Menemukan Model dengan 'Value for Money' Terbaik (Harga per KM)
SELECT
    M.model_name,
    ROUND(AVG(C.price) / AVG(C.mileage), 2) AS Harga_Per_KM
FROM
    used_car_list AS C
JOIN
    variants AS V ON C.varian_id = V.varian_id
JOIN
    models AS M ON V.model_id = M.model_id
GROUP BY
    M.model_name
ORDER BY
    Harga_Per_KM ASC
LIMIT 5;

-- 10.Varian Termahal untuk Mobil "Tahun Muda" (\>2019) 
SELECT
    M.model_name, 
    V.varian_name, 
    MAX(C.price) AS Harga_Tertinggi
FROM used_car_list AS C
JOIN variants AS V ON C.varian_id = V.varian_id
JOIN models AS M ON V.model_id = M.model_id
WHERE C.tahun > 2019
GROUP BY M.model_name, V.varian_name
ORDER BY Harga_Tertinggi DESC
LIMIT 10;

-- 11.Menampilkan Urutan Badge dengan Jumlah Stok Terbanyak
SELECT
    B.badge_name,
    COUNT(C.car_list_id) AS Total_Stok,
    ROUND(AVG(C.price), 0) AS Rata_Rata_Harga
FROM
    used_car_list AS C
JOIN
    badges AS B ON C.badge_id = B.badge_id
WHERE B.badge_name IS NOT NULL
GROUP BY
B.badge_name
ORDER BY
    Total_Stok DESC;

-- 12.Menampilkan Ranking Harga Mobil Termahal per Model
SELECT
    M.MODEL_NAME, C.TAHUN, C.PRICE,
    RANK() OVER (PARTITION BY M.MODEL_NAME ORDER BY C.PRICE DESC) AS Peringkat_Harga_Model
FROM
    CAR_LISTINGS_TB AS C
JOIN VARIAN_TB AS V ON C.VARIAN_ID = V.VARIAN_ID
JOIN MODELS_TB AS M ON V.MODEL_ID = M.MODEL_ID
WHERE
    C.PRICE IS NOT NULL
ORDER BY
    M.MODEL_NAME, Peringkat_Harga_Model
LIMIT 20;

