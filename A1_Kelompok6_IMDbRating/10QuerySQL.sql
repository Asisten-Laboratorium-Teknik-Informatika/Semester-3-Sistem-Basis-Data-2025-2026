1. Menampilkan Film dengan Skor IMDb Tertinggi (Maksimum)
Query ini akan menampilkan judul film yang memiliki skor tertinggi di tabel rating.

SQL
SELECT
    f.title,
    r.imdb_score
FROM
    film f
INNER JOIN
    rating r ON f.id = r.id
ORDER BY
    r.imdb_score DESC
LIMIT 1;
2. Menampilkan 5 Film Teratas Berdasarkan Skor IMDb
Query ini menampilkan 5 film dengan skor tertinggi, dengan minimal 1000 votes untuk hasil yang lebih relevan.

SQL
SELECT
    f.title,
    r.imdb_score,
    r.imdb_votes
FROM
    film f
INNER JOIN
    rating r ON f.id = r.id
WHERE
    r.imdb_votes >= 1000 -- Filter film dengan minimal 1000 votes
ORDER BY
    r.imdb_score DESC
LIMIT 5;
3. Menghitung Rata-rata Skor IMDb Keseluruhan
Query ini memberikan skor rata-rata dari semua film yang ada di tabel rating.

SQL
SELECT
    AVG(imdb_score) AS average_imdb_score
FROM
    rating;
4. Menampilkan Film yang Dirilis Setelah Tahun Tertentu
Query ini menampilkan semua film yang dirilis setelah tahun 2000.

SQL
SELECT
    title,
    release_year
FROM
    film
WHERE
    release_year > 2000
ORDER BY
    release_year DESC;
5. Menampilkan Film dengan Durasi (Runtime) Lebih dari 120 Menit
Query ini menampilkan film yang berdurasi panjang.

SQL
SELECT
    title,
    runtime
FROM
    film
WHERE
    runtime > 120
ORDER BY
    runtime DESC;
6. Menampilkan Film dengan Jumlah Votes IMDb Terbanyak
Query ini menampilkan film mana yang paling banyak dipilih (berdasarkan jumlah imdb_votes).

SQL
SELECT
    f.title,
    r.imdb_votes
FROM
    film f
INNER JOIN
    rating r ON f.id = r.id
ORDER BY
    r.imdb_votes DESC
LIMIT 1;
7. Menghitung Total Jumlah Film dalam Database
Query sederhana untuk mengetahui total baris data di tabel film.

SQL
SELECT
    COUNT(id) AS total_films
FROM
    film;




8. Menampilkan Film dengan Skor IMDb Terendah
Query ini menampilkan film dengan skor terendah (berguna untuk pemeriksaan data).

SQL
SELECT
    f.title,
    r.imdb_score
FROM
    film f
INNER JOIN
    rating r ON f.id = r.id
WHERE
    r.imdb_score IS NOT NULL
ORDER BY
    r.imdb_score ASC
LIMIT 1;




9. Menghitung Jumlah Film per Tahun Rilis
Query ini menggunakan GROUP BY untuk mengelompokkan dan menghitung berapa banyak film yang dirilis setiap tahun.

SQL
SELECT
    release_year,
    COUNT(id) AS count_of_films
FROM
    film
GROUP BY
    release_year
ORDER BY
    release_year DESC;



10.Mencari dengan kata kunci misalnya kata 'Vietnam'
SELECT
    title,
    description
FROM
    film
WHERE
    description LIKE '%Vietnam%'
LIMIT 10;
