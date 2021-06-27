-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2021 at 03:27 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_laundry`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `IDAdmin` varchar(10) NOT NULL,
  `User_Name` varchar(50) NOT NULL,
  `Nama_Admin` varchar(50) DEFAULT NULL,
  `Tgl_Lahir` date DEFAULT NULL,
  `NomorTlp` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`IDAdmin`, `User_Name`, `Nama_Admin`, `Tgl_Lahir`, `NomorTlp`) VALUES
('A0001', 'admin', 'Administrator', '2021-05-30', '081394833244');

-- --------------------------------------------------------

--
-- Table structure for table `alamat`
--

CREATE TABLE `alamat` (
  `KodePos` varchar(50) NOT NULL,
  `IDPelanggan` varchar(10) NOT NULL,
  `NoLaundry` varchar(10) NOT NULL,
  `Jalan` varchar(50) DEFAULT NULL,
  `KotaKabupaten` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `daftar`
--

CREATE TABLE `daftar` (
  `User_Name` varchar(50) NOT NULL,
  `Nama_Depan` varchar(50) DEFAULT NULL,
  `Nama_Belakang` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `daftar`
--

INSERT INTO `daftar` (`User_Name`, `Nama_Depan`, `Nama_Belakang`, `Password`) VALUES
('admin', 'Administrator', '', 'administrator'),
('username1', 'CHRISTIANTINUS', 'NESI', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `IDDelivery` varchar(10) NOT NULL,
  `IDPemesanan` varchar(10) NOT NULL,
  `HargaDelivery` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`IDDelivery`, `IDPemesanan`, `HargaDelivery`) VALUES
('D0001', 'PS0001', '5000');

-- --------------------------------------------------------

--
-- Table structure for table `jadwalkerja`
--

CREATE TABLE `jadwalkerja` (
  `IDJam` varchar(10) NOT NULL,
  `IDAdmin` varchar(10) NOT NULL,
  `Shift` varchar(50) DEFAULT NULL,
  `Waktu` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `laundry`
--

CREATE TABLE `laundry` (
  `NoLaundry` varchar(50) NOT NULL,
  `Nama_Laundry` varchar(50) DEFAULT NULL,
  `NomorTlp` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `laundry`
--

INSERT INTO `laundry` (`NoLaundry`, `Nama_Laundry`, `NomorTlp`) VALUES
('L0001', 'MyLaundry', '123456789');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `User_Name` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`User_Name`, `Password`) VALUES
('username1', 'admin123'),
('admin', 'administrator');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `IDPelanggan` varchar(10) NOT NULL,
  `User_Name` varchar(50) NOT NULL,
  `NamaPelanggan` varchar(50) DEFAULT NULL,
  `NomorTlp` varchar(13) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`IDPelanggan`, `User_Name`, `NamaPelanggan`, `NomorTlp`, `Email`) VALUES
('P0001', 'username1', 'CHRISTIANTINUS NESI', '081394833244', 'ciscoustic@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `IDPembayaran` varchar(10) NOT NULL,
  `IDPemesanan` varchar(10) NOT NULL,
  `IDDelivery` varchar(10) NOT NULL,
  `Jumlah` decimal(10,0) DEFAULT NULL,
  `Status_Pembayaran` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`IDPembayaran`, `IDPemesanan`, `IDDelivery`, `Jumlah`, `Status_Pembayaran`) VALUES
('INV0001', 'PS0001', 'D0001', '22000', 'LUNAS');

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `IDPemesanan` varchar(10) NOT NULL,
  `IDAdmin` varchar(10) DEFAULT NULL,
  `IDPelanggan` varchar(10) DEFAULT NULL,
  `BeratPakaian` decimal(10,0) DEFAULT NULL,
  `TipePakaian` varchar(50) DEFAULT NULL,
  `KondisiPakaian` varchar(50) DEFAULT NULL,
  `HariPengerjaan` decimal(10,0) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `TanggalPemesanan` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pemesanan`
--

INSERT INTO `pemesanan` (`IDPemesanan`, `IDAdmin`, `IDPelanggan`, `BeratPakaian`, `TipePakaian`, `KondisiPakaian`, `HariPengerjaan`, `Status`, `TanggalPemesanan`) VALUES
('PS0001', NULL, 'P0001', '1', 'Jeans', 'Baik', '6', 'PROSES', '2021-05-30 11:27:50');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_delivery`
-- (See below for the actual view)
--
CREATE TABLE `v_delivery` (
`IDDelivery` varchar(10)
,`HargaDelivery` decimal(10,0)
,`IDPemesanan` varchar(10)
,`IDAdmin` varchar(10)
,`IDPelanggan` varchar(10)
,`BeratPakaian` decimal(10,0)
,`TipePakaian` varchar(50)
,`KondisiPakaian` varchar(50)
,`HariPengerjaan` decimal(10,0)
,`Status` varchar(20)
,`TanggalPemesanan` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pembayaran`
-- (See below for the actual view)
--
CREATE TABLE `v_pembayaran` (
`IDPembayaran` varchar(10)
,`Jumlah` decimal(10,0)
,`Status_Pembayaran` varchar(50)
,`IDPemesanan` varchar(10)
,`IDAdmin` varchar(10)
,`IDPelanggan` varchar(10)
,`BeratPakaian` decimal(10,0)
,`TipePakaian` varchar(50)
,`KondisiPakaian` varchar(50)
,`HariPengerjaan` decimal(10,0)
,`Status` varchar(20)
,`TanggalPemesanan` timestamp
,`IDDelivery` varchar(10)
,`HargaDelivery` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pemesanan`
-- (See below for the actual view)
--
CREATE TABLE `v_pemesanan` (
`IDPemesanan` varchar(10)
,`IDAdmin` varchar(10)
,`IDPelanggan` varchar(10)
,`BeratPakaian` decimal(10,0)
,`TipePakaian` varchar(50)
,`KondisiPakaian` varchar(50)
,`HariPengerjaan` decimal(10,0)
,`Status` varchar(20)
,`TanggalPemesanan` timestamp
,`NamaPemesan` varchar(50)
,`NomorTlp` varchar(13)
,`NamaAdmin` varchar(50)
,`IDPembayaran` varchar(10)
,`Jumlah` decimal(10,0)
,`Status_Pembayaran` varchar(50)
,`HargaDelivery` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Structure for view `v_delivery`
--
DROP TABLE IF EXISTS `v_delivery`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_delivery`  AS   (select `delivery`.`IDDelivery` AS `IDDelivery`,`delivery`.`HargaDelivery` AS `HargaDelivery`,`pemesanan`.`IDPemesanan` AS `IDPemesanan`,`pemesanan`.`IDAdmin` AS `IDAdmin`,`pemesanan`.`IDPelanggan` AS `IDPelanggan`,`pemesanan`.`BeratPakaian` AS `BeratPakaian`,`pemesanan`.`TipePakaian` AS `TipePakaian`,`pemesanan`.`KondisiPakaian` AS `KondisiPakaian`,`pemesanan`.`HariPengerjaan` AS `HariPengerjaan`,`pemesanan`.`Status` AS `Status`,`pemesanan`.`TanggalPemesanan` AS `TanggalPemesanan` from (`delivery` join `pemesanan` on(`pemesanan`.`IDPemesanan` = `delivery`.`IDPemesanan`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `v_pembayaran`
--
DROP TABLE IF EXISTS `v_pembayaran`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pembayaran`  AS   (select `pembayaran`.`IDPembayaran` AS `IDPembayaran`,`pembayaran`.`Jumlah` AS `Jumlah`,`pembayaran`.`Status_Pembayaran` AS `Status_Pembayaran`,`pemesanan`.`IDPemesanan` AS `IDPemesanan`,`pemesanan`.`IDAdmin` AS `IDAdmin`,`pemesanan`.`IDPelanggan` AS `IDPelanggan`,`pemesanan`.`BeratPakaian` AS `BeratPakaian`,`pemesanan`.`TipePakaian` AS `TipePakaian`,`pemesanan`.`KondisiPakaian` AS `KondisiPakaian`,`pemesanan`.`HariPengerjaan` AS `HariPengerjaan`,`pemesanan`.`Status` AS `Status`,`pemesanan`.`TanggalPemesanan` AS `TanggalPemesanan`,`delivery`.`IDDelivery` AS `IDDelivery`,`delivery`.`HargaDelivery` AS `HargaDelivery` from ((`pembayaran` join `pemesanan` on(`pemesanan`.`IDPemesanan` = `pembayaran`.`IDPemesanan`)) join `delivery` on(`delivery`.`IDDelivery` = `pembayaran`.`IDDelivery`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `v_pemesanan`
--
DROP TABLE IF EXISTS `v_pemesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pemesanan`  AS   (select `pemesanan`.`IDPemesanan` AS `IDPemesanan`,`pemesanan`.`IDAdmin` AS `IDAdmin`,`pemesanan`.`IDPelanggan` AS `IDPelanggan`,`pemesanan`.`BeratPakaian` AS `BeratPakaian`,`pemesanan`.`TipePakaian` AS `TipePakaian`,`pemesanan`.`KondisiPakaian` AS `KondisiPakaian`,`pemesanan`.`HariPengerjaan` AS `HariPengerjaan`,`pemesanan`.`Status` AS `Status`,`pemesanan`.`TanggalPemesanan` AS `TanggalPemesanan`,`pelanggan`.`NamaPelanggan` AS `NamaPemesan`,`pelanggan`.`NomorTlp` AS `NomorTlp`,`admin`.`Nama_Admin` AS `NamaAdmin`,`pembayaran`.`IDPembayaran` AS `IDPembayaran`,`pembayaran`.`Jumlah` AS `Jumlah`,`pembayaran`.`Status_Pembayaran` AS `Status_Pembayaran`,`delivery`.`HargaDelivery` AS `HargaDelivery` from ((((`pemesanan` join `pelanggan` on(`pelanggan`.`IDPelanggan` = `pemesanan`.`IDPelanggan`)) left join `admin` on(`admin`.`IDAdmin` = `pemesanan`.`IDAdmin`)) join `pembayaran` on(`pembayaran`.`IDPemesanan` = `pemesanan`.`IDPemesanan`)) join `delivery` on(`delivery`.`IDPemesanan` = `pemesanan`.`IDPemesanan`)))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`IDAdmin`),
  ADD KEY `Admin_Daftar_FK` (`User_Name`);

--
-- Indexes for table `alamat`
--
ALTER TABLE `alamat`
  ADD PRIMARY KEY (`KodePos`),
  ADD KEY `Alamat_Pelannggan_FK` (`IDPelanggan`),
  ADD KEY `Alamat_Laundry_FK` (`NoLaundry`);

--
-- Indexes for table `daftar`
--
ALTER TABLE `daftar`
  ADD PRIMARY KEY (`User_Name`),
  ADD UNIQUE KEY `Password` (`Password`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`IDDelivery`),
  ADD KEY `Delivery_Pemesanan_FK` (`IDPemesanan`);

--
-- Indexes for table `jadwalkerja`
--
ALTER TABLE `jadwalkerja`
  ADD PRIMARY KEY (`IDJam`),
  ADD KEY `JadwalKerja_Admin_FK` (`IDAdmin`);

--
-- Indexes for table `laundry`
--
ALTER TABLE `laundry`
  ADD PRIMARY KEY (`NoLaundry`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD KEY `Login_Daftar_FK` (`User_Name`),
  ADD KEY `Login_Daftar1_FK` (`Password`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`IDPelanggan`),
  ADD KEY `Pelanggan_Daftar_FK` (`User_Name`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`IDPembayaran`),
  ADD KEY `Pembayaran_Delivery_FK` (`IDDelivery`),
  ADD KEY `Pembayaran_Pemesanan_FK` (`IDPemesanan`);

--
-- Indexes for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`IDPemesanan`),
  ADD KEY `Pemesanan_Admin_FK` (`IDAdmin`),
  ADD KEY `Pemesanan_Pelanggan_FK` (`IDPelanggan`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `Admin_Daftar_FK` FOREIGN KEY (`User_Name`) REFERENCES `daftar` (`User_Name`);

--
-- Constraints for table `alamat`
--
ALTER TABLE `alamat`
  ADD CONSTRAINT `Alamat_Laundry_FK` FOREIGN KEY (`NoLaundry`) REFERENCES `laundry` (`NoLaundry`),
  ADD CONSTRAINT `Alamat_Pelannggan_FK` FOREIGN KEY (`IDPelanggan`) REFERENCES `pelanggan` (`IDPelanggan`);

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `Delivery_Pemesanan_FK` FOREIGN KEY (`IDPemesanan`) REFERENCES `pemesanan` (`IDPemesanan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jadwalkerja`
--
ALTER TABLE `jadwalkerja`
  ADD CONSTRAINT `JadwalKerja_Admin_FK` FOREIGN KEY (`IDAdmin`) REFERENCES `admin` (`IDAdmin`);

--
-- Constraints for table `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `Login_Daftar1_FK` FOREIGN KEY (`Password`) REFERENCES `daftar` (`Password`),
  ADD CONSTRAINT `Login_Daftar_FK` FOREIGN KEY (`User_Name`) REFERENCES `daftar` (`User_Name`);

--
-- Constraints for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD CONSTRAINT `Pelanggan_Daftar_FK` FOREIGN KEY (`User_Name`) REFERENCES `daftar` (`User_Name`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `Pembayaran_Delivery_FK` FOREIGN KEY (`IDDelivery`) REFERENCES `delivery` (`IDDelivery`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Pembayaran_Pemesanan_FK` FOREIGN KEY (`IDPemesanan`) REFERENCES `pemesanan` (`IDPemesanan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD CONSTRAINT `Pemesanan_Admin_FK` FOREIGN KEY (`IDAdmin`) REFERENCES `admin` (`IDAdmin`),
  ADD CONSTRAINT `Pemesanan_Pelanggan_FK` FOREIGN KEY (`IDPelanggan`) REFERENCES `pelanggan` (`IDPelanggan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
