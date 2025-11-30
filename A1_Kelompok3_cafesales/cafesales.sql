CREATE DATABASE cafesales;
USE cafesales;

SELECT payment_method, COUNT(*) AS jumlah_pemakaian
FROM transaksi_1
GROUP BY payment_method
ORDER BY jumlah_pemakaian DESC
LIMIT 1;

SELECT t.transaction_id, i.item_name, d.quantity
FROM detailtransaksi d
JOIN transaksi_1 t ON d.transaction_id = t.transaction_id
JOIN itemsss i ON d.item_id = i.item_id
WHERE i.item_name = 'Coffee';

SELECT 
    MIN(transaction_date) AS tanggal_pertama,
    MAX(transaction_date) AS tanggal_terakhir
FROM transaksi_1;

SELECT t.transaction_id, SUM(d.quantity) AS total_item
FROM detailtransaksi d
JOIN transaksi_1 t ON d.transaction_id = t.transaction_id
GROUP BY t.transaction_id
HAVING total_item > 3;

SELECT t.transaction_id, i.item_name, d.quantity
FROM detailtransaksi d
JOIN transaksi_1 t ON d.transaction_id = t.transaction_id
JOIN itemsss i ON d.item_id = i.item_id;

SELECT * FROM transaksi_1
WHERE location = 'Takeaway';

SELECT COUNT(*) AS total_transaksi
FROM transaksi_1;

SELECT * FROM itemsss
WHERE price_per_unit = 'Rp3,00';

SELECT i.item_id, i.item_name
FROM itemsss i
LEFT JOIN detailtransaksi d ON i.item_id = d.item_id
WHERE d.item_id IS NULL;

SELECT t.location, SUM(d.quantity) AS total_quantity
FROM detailtransaksi d
JOIN transaksi_1 t ON d.transaction_id = t.transaction_id
GROUP BY t.location;

SELECT t.transaction_id, d.item_id, d.quantity
FROM transaksi_1 t
JOIN detailtransaksi d ON t.transaction_id = d.transaction_id;

SELECT item_id, COUNT(*) AS jumlah_kemunculan
FROM detailtransaksi
GROUP BY item_id
ORDER BY jumlah_kemunculan DESC;

SELECT * FROM transaksi_1
WHERE payment_method = 'Cash';

SELECT i.item_name, SUM(d.quantity) AS total_terjual
FROM detailtransaksi d
JOIN itemsss i ON d.item_id = i.item_id
WHERE i.item_name = 'Coffee';

SELECT payment_method, COUNT(*) AS total_transaksi
FROM transaksi_1
GROUP BY payment_method;

