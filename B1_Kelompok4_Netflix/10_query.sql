-- 1. menampilkan 15 negara dengan jumlah show terbanyak
SELECT release_year, COUNT(*) AS jumlah_rilis
FROM shows
GROUP BY release_year
ORDER BY jumlah_rilis DESC
LIMIT 15;

-- 2. Menampilkan 20 show teratas dengan durasi lebih dari 100 menit
SELECT title, duration, release_year
FROM shows
WHERE duration LIKE '%min%'
AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 100
ORDER BY release_year DESC
LIMIT 20;

-- 3. Menampilkan data dari tanggal 1 September 2020 sampai 17 September 2020
SELECT title, Date_added
FROM shows
WHERE Date_Added BETWEEN '2020-09-01' AND '2020-09-17';

-- 4. Menampilkan 20 show dengan Type= Movie dan durasinya <60 menit
SELECT title,type, duration
FROM shows
WHERE Type = 'Movie'
 AND Duration LIKE '%min'
 AND CAST(REPLACE(Duration, ' min', '') AS UNSIGNED) < 60
LIMIT 20;

-- 5. Menampilkan acara yang bergenre 'Documentaries' dan berasal dari 'Germany'(Contoh Subquery IN)
SELECT Title, type
FROM Shows
WHERE shows_Id IN (
 SELECT sc.shows_Id
 FROM Shows_Country sc
 JOIN Country c ON sc.Country_Id = c.Country_Id
 WHERE c.Country_Name = 'Germany'
)
AND shows_Id IN (
 SELECT sg.shows_Id
 FROM Shows_Genre sg
 JOIN Genre g ON sg.Genre_Id = g.Genre_Id
 WHERE g.Genre_Name = 'Documentaries'
);

-- 6. Menampilkan semua acara yang dibintangi oleh aktor Tom Hanks
SELECT
 s.Title,
 c.Cast_Name
FROM Shows s
JOIN Shows_Casts sc ON s.shows_Id = sc.shows_Id
JOIN Castmember c ON sc.Cast_Id = c.Cast_Id
WHERE c.Cast_Name = 'Tom Hanks';

-- 7. Menghitung jumlah acara yang dibuat oleh setiap sutradara (Contoh GROUP BY) dibatasi yang ditampilkan hanya 20 baris data teratas
SELECT d.Name, COUNT(s.shows_Id) AS Jumlah_Acara
FROM Director d
JOIN Shows s ON d.Director_Id = s.Director_Id
GROUP BY d.Name
ORDER BY Jumlah_Acara DESC
LIMIT 20;

-- 8. Menampilkan acara yang disutradarai oleh sutradara tertentu (Contoh Subquery=). (Kueri ini tidak terpengaruh oleh perubahan nama kolom)
SELECT Title, Release_Year
FROM Shows
WHERE Director_Id = (
 SELECT Director_Id
 FROM Director
 WHERE Name = 'Christopher Nolan'
);

-- 9. Menampilkan 20 acara yang rilis lebih baru dari rata-rata tahun rilis (Contoh Subquery Agregat) (Kueri ini tidak terpengaruh oleh perubahan nama kolom)
SELECT Title, Release_Year
FROM Shows
WHERE Release_Year > (
 SELECT AVG(Release_Year)
 FROM Shows
) LIMIT 20;

-- 10. Menampilkan semua judul film (Type 'Movie') yang disutradarai oleh 'Mike Flanagan'
SELECT
 S.Title,
 S.Release_Year,
 D.Name AS Director_Name
FROM
 Shows AS S
JOIN
 Director AS D
 ON S.Director_Id = D.Director_Id
WHERE
 D.Name = 'Steven Spielberg'
 AND S.`Type` = 'Movie'