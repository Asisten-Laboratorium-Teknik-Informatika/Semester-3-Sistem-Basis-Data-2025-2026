MariaDB [(none)]> create database db_ptn;
MariaDB [(none)]> use db_ptn;
MariaDB [db_ptn]> select * from ptn;
MariaDB [db_ptn]> select * from prodi;

1. MariaDB [db_ptn]> alter table prodi 
    -> CHANGE COL 1 kode_prodi VARCHAR(50),
    -> CHANGE COL 2 nama_prodi VARCHAR(255),
    -> CHANGE COL 3 jenjang VARCHAR(20),
    -> CHANGE COL 4 daya_tampung_2025 INT,
    -> CHANGE COL 5 jenis_portofolio VARCHAR(100),
    -> CHANGE COL 6 passing_grade VARCHAR(20);

2. MariaDB [db_ptn]> select * from prodi
    -> where daya_tampung_2025 > 100;

3. MariaDB [db_ptn]> select * from prodi
    -> where jenis_portofolio = 'Olahraga';

4. MariaDB [db_ptn]> select * from prodi
    -> where jenis_portofolio IN ('Seni Rupa', 'Musik', 'Tari');

5. MariaDB [db_ptn]> select * from prodi
    -> order by daya_tampung_2025 desc
    -> limit 10;

6. MariaDB [db_ptn]> select count(*) AS jumla_prodi_S1 from prodi
    -> where jenjang ='S1';

7. MariaDB [db_ptn]> select count(*) AS jumla_prodi_D3 from prodi
    -> where jenjang ='D3';

8. MariaDB [db_ptn]> select * from ptn
    -> where kode_ptn = 1111;

9. MariaDB [db_ptn]> SELECT nama_prodi, jenjang
    -> FROM prodi;

10. MariaDB [db_ptn]> select distinct jenis_portofolio
    -> from prodi;

11. MariaDB [db_ptn]> select * from prodi
    -> where nama_prodi like 'T%';

12. MariaDB [db_ptn]> select * from prodi
    -> where daya_tampung_2025 between 50 and 100;

13. MariaDB [db_ptn]> select * from prodi
    -> order by nama_prodi asc
    -> limit 10;

14. MariaDB [db_ptn]> select sum(daya_tampung_2025) as total_daya_tampung
    -> from prodi;

15. MariaDB [db_ptn]> select nama_prodi, passing_grade
    -> from prodi
    -> where passing_grade >700;

16. MariaDB [db_ptn]> select * from prodi
    -> where kode_prodi = '11121032';

17. MariaDB [db_ptn]> update prodi
    -> set jenjang = 'D3'
    -> where kode_prodi = '11121032';

18. MariaDB [db_ptn]> select * from prodi
    ->  where kode_prodi = '11121032';

19. MariaDB [db_ptn]> select * from ptn
    -> where kode_ptn = 1121;

20. MariaDB [db_ptn]> select * from ptn
    -> limit 10;

21. MariaDB [db_ptn]> select * from ptn
    -> order by kode_ptn desc;

22. MariaDB [db_ptn]> select * from ptn
    -> order by kode_ptn asc;

23. MariaDB [db_ptn]> select * from ptn
    -> where nama_ptn like 'U%';

24. MariaDB [db_ptn]> select * from ptn
    -> where nama_ptn like 'I%';

