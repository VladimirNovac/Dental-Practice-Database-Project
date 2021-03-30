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
-- A select command to see what treatment a certain patient has.
--

SELECT patientchart.FirstName, patientchart.LastName,
treatmentfees.Treatment FROM patientchart, appointmentdiary,
visitcard, treatmentfees
WHERE patientchart.PatientChartID = appointmentdiary.PatientChartID
and appointmentdiary.AppointmentID = visitcard.AppointmentID
and appointmentdiary.TreatmentFeesID = treatmentfees.TreatmentFeesID;

-- --------------------------------------------------------

--
-- An insert command that adds a new patient information.
--

INSERT INTO `patientchart` (`FirstName`, `LastName`, `Address`, `AlternateAdress`, `Telephone`, `Email`) VALUES
('Carmelina', 'Lindall', '2664 Lewis Rd, Littleton', NULL, '212-674-9610', 'tawna@gmail.com');

-- --------------------------------------------------------

--
-- An insert command that sets up an appointment for a treatment for a patient named "Lindall".
--

INSERT INTO `appointmentdiary` (`PatientChartID`, `Date`, `Time`, `TreatmentFeesID`, `ContactMethod`, `LateCancellation`)
SELECT
patientchart.PatientChartID,
'2020-03-16',
'18:00',
'2',
'Phone',
'0'
FROM
patientchart
WHERE
patientchart.LastName = "Lindall";

-- --------------------------------------------------------

--
-- An insert command that creates a visit card for a patient named "Lindall".
--

INSERT INTO visitcard (`AppointmentID`, `Treated`, `Referred`, `FollowUp`)
SELECT
appointmentdiary.AppointmentID,
1,
0,
"acrylic dentures fitted"
FROM appointmentdiary, patientchart
WHERE patientchart.LastName = "Lindall" and patientchart.PatientChartID = appointmentdiary.PatientChartID;

-- --------------------------------------------------------

--
-- An insert command that creates a bill for a patient named "Lindall".
--

INSERT INTO bill (`VisitCardID`, `Date`, `Paid`)
SELECT
visitcard.VisitCardID,
appointmentdiary.Date,
'0'
FROM appointmentdiary, visitcard, patientchart
WHERE patientchart.LastName = "Lindall" and patientchart.PatientChartID = appointmentdiary.PatientChartID and appointmentdiary.AppointmentID = visitcard.AppointmentID;

-- --------------------------------------------------------

--
-- An update command that adds a phone number to a previous null field.
--

UPDATE patientchart
SET Telephone = "212-875-1296"
WHERE LastName = "Butt";

-- --------------------------------------------------------

--
-- If a patient has a late cancellation, a new entry can be made in the appointmentdiary with "late cancellation" (number 9 in treatmentfees) as treatment. This can be made into a visitcard and subsequantially a bill
--

INSERT INTO appointmentdiary (PatientChartId, Date, time, TreatmentFeesID, ContactMethod, lateCancellation)
values
((SELECT patientchart.PatientChartID FROM patientchart WHERE LastName = "Corrio"), '2020-03-16', '13:30:00', '9', 'phone', '1');

-- --------------------------------------------------------

--
-- An delete command that removes an appointment entry based on a persons name.
--

DELETE appointmentdiary FROM appointmentdiary JOIN patientchart ON appointmentdiary.PatientChartID=patientchart.PatientChartID WHERE patientchart.LastName = "Charles";

-- --------------------------------------------------------

--
-- A create command that sets up a view called patient bill where the user can see all the bills issued to the patients
--


CREATE VIEW PatientBill (PatientChartID, FirstName, LastName, Address, VisitCardID, Treatment, BillID, Total, Date, SumRemaining)
AS
SELECT patientchart.PatientChartID, patientchart.FirstName, patientchart.LastName, patientchart.Address, visitcard.VisitCardID, treatmentfees.Treatment, bill.BillID, treatmentfees.TreatmentFee, bill.Date, treatmentfees.TreatmentFee - (SELECT CASE WHEN sum(payment.Amount) IS NULL THEN 0 ELSE sum(payment.Amount) END
FROM payment WHERE payment.BillID=bill.BillID)
FROM patientchart, bill, treatmentfees, appointmentdiary, visitcard
WHERE patientchart.PatientChartID=appointmentdiary.PatientChartID and appointmentdiary.AppointmentID=visitcard.AppointmentID and visitcard.VisitCardID=bill.VisitCardID and appointmentdiary.TreatmentFeesID=treatmentfees.TreatmentFeesID and bill.paid = 0;

-- --------------------------------------------------------

--
-- A create command that sets up a view called patient history where the user can see all the patient records.
--


CREATE VIEW PatientHistory (PatientChartID, FirstName, LastName, Address, AppointmentID, Date, Time, VisitCardID, Treatment, referred, FollowUp)
AS
SELECT patientchart.PatientChartID, patientchart.FirstName, patientchart.LastName, patientchart.Address, appointmentdiary.AppointmentID, appointmentdiary.Date, appointmentdiary.Time, visitcard.VisitCardID, treatmentfees.Treatment, visitcard.Referred, visitcard.FollowUp
FROM patientchart, treatmentfees, appointmentdiary, visitcard
WHERE patientchart.PatientChartID=appointmentdiary.PatientChartID and appointmentdiary.AppointmentID=visitcard.AppointmentID and appointmentdiary.TreatmentFeesID=treatmentfees.TreatmentFeesID
ORDER BY patientchart.LastName;

-- --------------------------------------------------------

--
-- An update command that uses the patienbill view to update a patient's name
--

UPDATE PatientBillSET FirstName = 'Nick'WHERE LastName = "Paprocki";

-- --------------------------------------------------------

--
-- An insert command that registers a full payment made by the patient Lindall.
--

INSERT INTO payment (PatientChartID, BillID, PaymentMethod, Amount)
SELECT
patientchart.PatientChartID,
bill.BillID,
'cash',
'30'
FROM bill, patientchart, appointmentdiary, visitcard
WHERE patientchart.LastName = 'Lindall' and patientchart.PatientChartID = appointmentdiary.PatientChartID and appointmentdiary.AppointmentID = visitcard.AppointmentID and visitcard.VisitCardID = bill.VisitCardID;


-- --------------------------------------------------------

--
-- An update command that changes the field paid in the bill table to true. The patientbill view will not show the bill anymore.
--

UPDATE bill, patientbill
SET bill.Paid = 1
WHERE patientbill.LastName = "Lindall" and patientbill.SumRemaining = 0 and patientbill.BillID = bill.BillID;


-- --------------------------------------------------------

--
-- An insert command that registers a partial payment made by a patient. The patientbill view is automatically updated with the new value.
--

INSERT INTO payment (PatientChartID, BillID, PaymentMethod, Amount)
SELECT
patientchart.PatientChartID,
bill.BillID,
'cash',
'30'
FROM bill, patientchart, appointmentdiary, visitcard
WHERE patientchart.LastName = 'Morasca' and patientchart.PatientChartID = appointmentdiary.PatientChartID and appointmentdiary.AppointmentID = visitcard.AppointmentID and visitcard.VisitCardID = bill.VisitCardID;


-- --------------------------------------------------------


COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
