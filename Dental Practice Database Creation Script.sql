-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 21, 2020 at 03:31 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dentalpractice`
--
CREATE DATABASE IF NOT EXISTS `dentalpractice` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dentalpractice`;

-- --------------------------------------------------------

--
-- Table structure for table `patientchart`
--

DROP TABLE IF EXISTS `patientchart`;
CREATE TABLE `patientchart` (
  `PatientChartID` int(11) NOT NULL,
  `FirstName` tinytext NOT NULL,
  `LastName` tinytext NOT NULL,
  `Address` mediumtext NOT NULL,
  `AlternateAdress` mediumtext DEFAULT NULL,
  `Telephone` mediumtext DEFAULT NULL,
  `Email` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Patient table with patient information';

-- --------------------------------------------------------

--
-- Table structure for table `treatmentfees`
--

DROP TABLE IF EXISTS `treatmentfees`;
CREATE TABLE `treatmentfees` (
  `TreatmentFeesID` int(11) NOT NULL,
  `Treatment` mediumtext NOT NULL,
  `TreatmentFee` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Table structure for table `appointmentdiary`
--

DROP TABLE IF EXISTS `appointmentdiary`;
CREATE TABLE `appointmentdiary` (
  `AppointmentID` int(11) NOT NULL,
  `PatientChartID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `TreatmentFeesID` int(11) NOT NULL,
  `ContactMethod` tinytext NOT NULL,
  `LateCancellation` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Appointment table with the ongoing patient appoinments';


-- --------------------------------------------------------

--
-- Table structure for table `visitcard`
--

DROP TABLE IF EXISTS `visitcard`;
CREATE TABLE `visitcard` (
  `VisitCardID` int(11) NOT NULL,
  `AppointmentID` int(11) NOT NULL,
  `Treated` tinyint(1) NOT NULL,
  `Referred` tinyint(1) NOT NULL,
  `FollowUp` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
CREATE TABLE `bill` (
  `BillID` int(11) NOT NULL,
  `VisitCardID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Paid` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `PaymentID` int(11) NOT NULL,
  `PatientChartID` int(11) NOT NULL,
  `BillID` int(11) NOT NULL,
  `PaymentMethod` tinytext NOT NULL,
  `Amount` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Stand-in structure for view `patient_appointment`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `patient_appointment`;
CREATE TABLE `patient_appointment` (
`PatientChartID` int(11)
,`FirstName` tinytext
,`LastName` tinytext
,`Address` mediumtext
,`AppointmentID` int(11)
,`Date` date
,`Time` time
,`Treatment` mediumtext
);

-- --------------------------------------------------------

--
-- Structure for view `patient_appointment`
--
DROP TABLE IF EXISTS `patient_appointment`;

DROP VIEW IF EXISTS `patient_appointment`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_appointment`  AS  select `patientchart`.`PatientChartID` AS `PatientChartID`,`patientchart`.`FirstName` AS `FirstName`,`patientchart`.`LastName` AS `LastName`,`patientchart`.`Address` AS `Address`,`appointmentdiary`.`AppointmentID` AS `AppointmentID`,`appointmentdiary`.`Date` AS `Date`,`appointmentdiary`.`Time` AS `Time`,`treatmentfees`.`Treatment` AS `Treatment` from ((`patientchart` join `appointmentdiary`) join `treatmentfees`) where `appointmentdiary`.`PatientChartID` = `patientchart`.`PatientChartID` and `appointmentdiary`.`LateCancellation` <> 1 and `appointmentdiary`.`TreatmentFeesID` = `treatmentfees`.`TreatmentFeesID` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointmentdiary`
--
ALTER TABLE `appointmentdiary`
  ADD PRIMARY KEY (`AppointmentID`),
  ADD KEY `PatientChart.PatientChartID` (`PatientChartID`),
  ADD KEY `TreatmentFees.TreatmentFeesID` (`TreatmentFeesID`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`BillID`),
  ADD UNIQUE KEY `VisitCardID` (`VisitCardID`);

--
-- Indexes for table `patientchart`
--
ALTER TABLE `patientchart`
  ADD PRIMARY KEY (`PatientChartID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`PaymentID`),
  ADD KEY `PatientChart.PatientChartID` (`PatientChartID`),
  ADD KEY `BillID` (`BillID`);

--
-- Indexes for table `treatmentfees`
--
ALTER TABLE `treatmentfees`
  ADD PRIMARY KEY (`TreatmentFeesID`);

--
-- Indexes for table `visitcard`
--
ALTER TABLE `visitcard`
  ADD PRIMARY KEY (`VisitCardID`),
  ADD KEY `AppointmentID` (`AppointmentID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointmentdiary`
--
ALTER TABLE `appointmentdiary`
  MODIFY `AppointmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `BillID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patientchart`
--
ALTER TABLE `patientchart`
  MODIFY `PatientChartID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `treatmentfees`
--
ALTER TABLE `treatmentfees`
  MODIFY `TreatmentFeesID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `visitcard`
--
ALTER TABLE `visitcard`
  MODIFY `VisitCardID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointmentdiary`
--
ALTER TABLE `appointmentdiary`
  ADD CONSTRAINT `PatientChart.PatientChartID` FOREIGN KEY (`PatientChartID`) REFERENCES `patientchart` (`PatientChartID`),
  ADD CONSTRAINT `TreatmentFees.TreatmentFeesID` FOREIGN KEY (`TreatmentFeesID`) REFERENCES `treatmentfees` (`TreatmentFeesID`);

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`VisitCardID`) REFERENCES `visitcard` (`VisitCardID`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `patientchart_ibfk2` FOREIGN KEY (`PatientChartID`) REFERENCES `patientchart` (`PatientChartID`),
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`BillID`) REFERENCES `bill` (`BillID`);

--
-- Constraints for table `visitcard`
--
ALTER TABLE `visitcard`
  ADD CONSTRAINT `visitcard_ibfk_1` FOREIGN KEY (`AppointmentID`) REFERENCES `appointmentdiary` (`AppointmentID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
