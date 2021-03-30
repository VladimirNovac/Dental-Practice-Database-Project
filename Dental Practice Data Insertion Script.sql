-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2020 at 09:44 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dentalpractice`
--

--
-- Dumping data for table `patientchart`
--

INSERT INTO `patientchart` (`PatientChartID`, `FirstName`, `LastName`, `Address`, `AlternateAdress`, `Telephone`, `Email`) VALUES
(1, 'John', 'Butt', '6649 N Blue Gum St, New Orleans', '2371 Jerrold Ave', NULL, 'jbutt@gmail.com'),
(2, 'Lenna', 'Paprocki', '639 Main St, Anchorage', NULL, '215-874-1229', 'lpaprocki@hotmail.com'),
(3, 'Simona', 'Morasca', '3 Mcauley Dr, Ashland, Ashland', '69734 E Carrillo St', '631-335-3414', 'simona@morasca.com'),
(4, 'Ammie', 'Corrio', '74874 Atlantic Ave, Columbus', NULL, '614-801-9788', 'ammie@corrio.com'),
(5, 'Stevens', 'Charles', '840 15th Ave, Waco', NULL, '254-782-8569', 'danica_bruschke@gmail.com');

-- --------------------------------------------------------

--
-- Dumping data for table `treatmentfees`
--

INSERT INTO `treatmentfees` (`TreatmentFeesID`, `Treatment`, `TreatmentFee`) VALUES
(1, 'Examination', 45),
(2, 'X-Ray', 30),
(3, 'Crown', 750),
(4, 'Root Canal Treatment', 650),
(5, 'Orthodontics', 3000),
(6, 'Routine Extraction', 120),
(7, 'Composite Filling', 140),
(8, 'Full Acrylic Denture', 1000),
(9, 'Late Cancellation', 10);

-- --------------------------------------------------------

--
-- Dumping data for table `appointmentdiary`
--

INSERT INTO `appointmentdiary` (`AppointmentID`, `PatientChartID`, `Date`, `Time`, `TreatmentFeesID`, `ContactMethod`, `LateCancellation`) VALUES
(1, 1, '2020-03-01', '15:00:00', '3', 'Phone', '0'),
(2, 2, '2020-02-05', '11:00:00', '4', 'Email', '0'),
(3, 3, '2020-03-12', '16:00:00', '6', 'Post', '0'),
(4, 2, '2020-03-14', '12:00:00', '7', 'Phone', '0'),
(5, 4, '2020-03-16', '13:30:00', '5', 'Email', '1'),
(6, 5, '2020-03-17', '15:30:00', '1', 'Email', '0');


-- --------------------------------------------------------

--
-- Dumping data for table `visitcard`
--

INSERT INTO `visitcard` (`VisitCardID`, `AppointmentID`, `Treated`, `Referred`, `FollowUp`) VALUES
(1, 2, 1, 0, 'Dentures Fitted with no problem'),
(2, 1, 1, 0, 'Root Canal Completed, patient to return for different treatment'),
(3, 3, 0, 1, 'Patient sent to get X-ray from specialist'),
(4, 4, 1, 0, 'Crown fitted');


-- --------------------------------------------------------

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`BillID`, `VisitCardID`, `Date`, `Paid`) VALUES
(1, 1, '2020-02-05', '1'),
(2, 3, '2020-03-12', '0'),
(3, 2, '2020-03-01', '0'),
(4, 4, '2020-03-14', '0');

-- --------------------------------------------------------

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`PaymentID`, `PatientChartID`, `BillID`, `PaymentMethod`, `Amount`) VALUES
(1, 1, 3, 'check', 350),
(2, 2, 1, 'cash', 120),
(3, 1, 3, 'check', 300),
(4, 3, 2, 'debit card', 30);

-- --------------------------------------------------------
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
