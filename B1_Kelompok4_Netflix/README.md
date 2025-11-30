# Analisis Deskriptif Dataset Netflix – Basis Data MySQL
## Kom B1 – Kelompok 4
Proyek ini merupakan implementasi sistem basis data menggunakan dataset Netflix Movies and TV Shows, yang diperoleh dari Kaggle. Seluruh proses dilakukan sesuai tahapan penelitian dalam makalah “Analisis Deskriptif Dataset Netflix untuk Mengidentifikasi Tren Konten Global”
---
## Anggota Kelompok
- **Ilman Zuhry Hartarto – 241712047**
- **Alma Murael Gultom – 241712049**
- **Muhammad Rizky P. Lubis – 241712056**

## 1. Deskripsi Proyek
Proyek ini bertujuan membangun database relasional Netflix yang sudah dinormalisasi berdasarkan dataset Kaggle. Data mentah awal mengalami banyak masalah seperti:
- multi-valued attributes (genre, country, cast)
- redundansi sutradara dan rating
- format tanggal tidak konsisten
- data duplikat
---
## 2. Tools yang digunakan
- Kaggle – dataset
- Excel – data cleaning
- VS Code + Python – otomatisasi ID & pemisahan atribut jamak
- Draw.io – ERD
- XAMPP (MySQL) – DBMS
- phpMyAdmin – implementasi & uji query

---
## 3. Struktur Tabel
Database ini terdiri atas:

### **Tabel Utama**
- `Shows`

### **Tabel Referensi**
- `Director`  
- `Rating`  
- `Country`  
- `Genre`  
- `Castmember`

### **Tabel Relasi (Many-to-Many)**
- `Shows_Genre`  
- `Shows_Country`  
- `Shows_Casts`

---

## 4. Pengujian Query
Repository ini berisi 10 query SQL yang digunakan untuk menjawab pertanyaan analisis seperti:
### Show dari Germany + Genre Documentaries
```sql
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
```
Semua query dapat dilihat pada file:
**`10_query_netflix.sql`**

---
## 5. File dalam Repository
- **netflix.sql** → implementasi database MySQL  
- **10_query_netflix.sql** → kumpulan query analisis  
- **README.md** → dokumentasi proyek  

---

## 6. Kesimpulan
Database berhasil diimplementasikan secara relasional dan memenuhi prinsip normalisasi. Semua relasi many-to-many berhasil dimodelkan melalui tabel penghubung sehingga data lebih konsisten dan efisien untuk dianalisis.
