-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 12 Nov 2025 pada 16.22
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `car_database`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `car_make`
--

CREATE TABLE `car_make` (
  `make_id` int(11) NOT NULL,
  `make_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `car_make`
--

INSERT INTO `car_make` (`make_id`, `make_name`) VALUES
(4, '1'),
(13, '10'),
(14, '11'),
(15, '12'),
(16, '13'),
(17, '14'),
(18, '15'),
(19, '16'),
(20, '17'),
(21, '18'),
(22, '19'),
(5, '2'),
(23, '20'),
(24, '21'),
(25, '22'),
(26, '23'),
(27, '24'),
(28, '25'),
(29, '26'),
(30, '27'),
(31, '28'),
(32, '29'),
(6, '3'),
(33, '30'),
(34, '31'),
(35, '32'),
(36, '33'),
(37, '34'),
(38, '35'),
(39, '36'),
(40, '37'),
(41, '38'),
(7, '4'),
(8, '5'),
(9, '6'),
(10, '7'),
(11, '8'),
(12, '9'),
(2, 'Ferrari'),
(3, 'Lamborghini'),
(1, 'Porsche');

-- --------------------------------------------------------

--
-- Struktur dari tabel `car_model`
--

CREATE TABLE `car_model` (
  `model_id` int(11) NOT NULL,
  `make_id` int(11) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  `year` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `car_model`
--

INSERT INTO `car_model` (`model_id`, `make_id`, `model_name`, `year`) VALUES
(911, 1, '2022', '2001'),
(1, 1, '911', '2022'),
(912, 2, '2021', '2002'),
(2, 2, '488 GTB', '2022'),
(488, 3, '2022', '2003'),
(3, 3, 'Huracan', '2021'),
(913, 4, '2022', '2004'),
(720, 5, '2021', '2005'),
(914, 6, '2022', '2006'),
(915, 7, '2021', '2007'),
(916, 8, '2021', '2008'),
(917, 9, '2022', '2009'),
(918, 10, '2021', '2010'),
(919, 11, '2021', '2011'),
(920, 12, '2021', '2012'),
(921, 13, '2022', '2013'),
(922, 14, '2022', '2014'),
(923, 15, '2021', '2015'),
(924, 16, '2021', '2016'),
(925, 17, '2021', '2017'),
(926, 18, '2021', '2018'),
(927, 19, '2021', '2001'),
(928, 20, '2022', '2019'),
(929, 21, '2021', '2020'),
(930, 22, '2021', '2021'),
(931, 23, '2022', '2005'),
(932, 24, '2021', '2022'),
(933, 25, '2021', '2023'),
(934, 27, '2022', '2025'),
(935, 28, '2022', '2001'),
(936, 29, '2021', '2002'),
(937, 30, '2021', '2003'),
(938, 31, '2022', '2004'),
(939, 32, '2021', '2005'),
(940, 33, '2022', '2006'),
(941, 34, '2015', '2007'),
(942, 35, '2021', '2008'),
(943, 36, '2022', '2009'),
(370, 37, '2021', '2010'),
(944, 38, '2022', '2001'),
(945, 39, '2021', '2002'),
(946, 40, '2021', '2003'),
(947, 41, '2022', '2004');

-- --------------------------------------------------------

--
-- Struktur dari tabel `car_specs`
--

CREATE TABLE `car_specs` (
  `spec_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `engine_size_l` decimal(3,1) DEFAULT NULL,
  `horsepower` int(11) DEFAULT NULL,
  `torque_lbft` int(11) DEFAULT NULL,
  `accel_0_60_sec` decimal(3,1) DEFAULT NULL,
  `price_usd` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `car_specs`
--

INSERT INTO `car_specs` (`spec_id`, `model_id`, `engine_size_l`, `horsepower`, `torque_lbft`, `accel_0_60_sec`, `price_usd`) VALUES
(1, 1, 3.0, 379, 331, 4.0, 101200.00),
(2, 2, 3.9, 661, 561, 3.0, 333750.00),
(3, 3, 5.2, 630, 443, 2.8, 274390.00),
(14, 3, 99.9, 295, 5, 70.0, 14.00),
(19, 2, 99.9, 280, 5, 62.0, 19.00),
(20, 3, 99.9, 443, 4, 78.0, 20.00),
(21, 2, 99.9, 243, 3, 75.0, 21.00),
(23, 3, 99.9, 531, 3, 99.9, 23.00),
(26, 2, 99.9, 738, 4, 99.9, 26.00),
(32, 3, 99.9, 531, 3, 99.9, 32.00),
(33, 3, 99.9, 479, 4, 72.0, 33.00),
(38, 3, 99.9, 472, 4, 99.9, 408.00),
(41, 3, 99.9, 369, 4, 57.0, 41.00),
(43, 2, 99.9, 420, 4, 99.9, 43.00),
(45, 2, 99.9, 280, 5, 58.0, 45.00),
(51, 3, 99.9, 331, 5, 87.0, 57.00),
(52, 3, 99.9, 369, 4, 52.0, 60.00),
(56, 3, 99.9, 443, 4, 75.0, 64.00),
(57, 3, 99.9, 406, 4, 58.0, 65.00),
(63, 3, 99.9, 331, 5, 88.0, 75.00),
(64, 3, 99.9, 354, 4, 67.0, 76.00),
(68, 2, 99.9, 280, 5, 61.0, 82.00),
(74, 2, 99.9, 151, 7, 26.0, 93.00),
(80, 3, 99.9, 368, 4, 43.0, 101.00),
(82, 3, 99.9, 354, 3, 67.0, 106.00),
(91, 3, 99.9, 309, 5, 68.0, 138.00),
(93, 3, 99.9, 369, 4, 63.0, 143.00),
(95, 3, 99.9, 369, 4, 56.0, 151.00),
(96, 3, 99.9, 406, 4, 84.0, 153.00),
(106, 3, 99.9, 368, 4, 43.0, 173.00),
(109, 2, 99.9, 280, 5, 61.0, 176.00),
(112, 2, 99.9, 254, 5, 81.0, 882.00),
(114, 2, 99.9, 254, 5, 81.0, 194.00),
(121, 3, 99.9, 406, 4, 59.0, 218.00),
(130, 2, 99.9, 258, 4, 67.0, 237.00),
(131, 3, 99.9, 443, 4, 77.0, 238.00),
(132, 3, 99.9, 406, 4, 58.0, 239.00),
(135, 3, 99.9, 290, 5, 38.0, 247.00),
(139, 3, 99.9, 443, 4, 75.0, 270.00),
(145, 3, 99.9, 376, 5, 52.0, 287.00),
(146, 3, 99.9, 443, 4, 76.0, 291.00),
(150, 3, 99.9, 339, 5, 63.0, 522.00),
(161, 2, 99.9, 236, 4, 71.0, 366.00),
(162, 3, 99.9, 406, 4, 71.0, 368.00),
(165, 3, 99.9, 443, 4, 75.0, 403.00),
(168, 3, 99.9, 479, 4, 75.0, 413.00),
(179, 3, 99.9, 443, 4, 75.0, 444.00),
(180, 3, 99.9, 384, 5, 62.0, 447.00),
(182, 2, 99.9, 280, 5, 62.0, 453.00),
(186, 2, 99.9, 258, 4, 67.0, 479.00),
(187, 3, 99.9, 443, 4, 76.0, 483.00),
(189, 2, 99.9, 280, 5, 62.0, 492.00),
(190, 3, 99.9, 354, 4, 67.0, 495.00),
(191, 3, 99.9, 406, 4, 71.0, 496.00),
(195, 3, 99.9, 290, 5, 38.0, 538.00),
(210, 3, 99.9, 384, 5, 96.0, 597.00),
(218, 3, 99.9, 350, 4, 40.0, 639.00),
(220, 3, 99.9, 368, 4, 43.0, 644.00),
(227, 2, 99.9, 280, 5, 63.0, 705.00),
(230, 2, 99.9, 184, 4, 99.9, 716.00),
(236, 3, 99.9, 354, 4, 68.0, 774.00),
(238, 2, 99.9, 295, 5, 50.0, 776.00),
(247, 3, 99.9, 479, 4, 74.0, 833.00),
(249, 3, 99.9, 384, 5, 59.0, 841.00),
(250, 2, 99.9, 354, 4, 50.0, 860.00),
(260, 3, 99.9, 538, 3, 99.9, 990.00),
(261, 3, 99.9, 406, 4, 58.0, 996.00),
(262, 2, 99.9, 350, 5, 27.0, 999.00);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `car_make`
--
ALTER TABLE `car_make`
  ADD PRIMARY KEY (`make_id`),
  ADD UNIQUE KEY `make_name` (`make_name`),
  ADD KEY `idx_make_name` (`make_name`);

--
-- Indeks untuk tabel `car_model`
--
ALTER TABLE `car_model`
  ADD PRIMARY KEY (`model_id`),
  ADD UNIQUE KEY `make_id` (`make_id`,`model_name`,`year`),
  ADD KEY `idx_model_name` (`model_name`);

--
-- Indeks untuk tabel `car_specs`
--
ALTER TABLE `car_specs`
  ADD PRIMARY KEY (`spec_id`),
  ADD KEY `fk_car_specs_model` (`model_id`),
  ADD KEY `idx_price` (`price_usd`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `car_make`
--
ALTER TABLE `car_make`
  MODIFY `make_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT untuk tabel `car_model`
--
ALTER TABLE `car_model`
  MODIFY `model_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=949;

--
-- AUTO_INCREMENT untuk tabel `car_specs`
--
ALTER TABLE `car_specs`
  MODIFY `spec_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=263;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `car_model`
--
ALTER TABLE `car_model`
  ADD CONSTRAINT `fk_car_model_make` FOREIGN KEY (`make_id`) REFERENCES `car_make` (`make_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `car_specs`
--
ALTER TABLE `car_specs`
  ADD CONSTRAINT `fk_car_specs_model` FOREIGN KEY (`model_id`) REFERENCES `car_model` (`model_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
