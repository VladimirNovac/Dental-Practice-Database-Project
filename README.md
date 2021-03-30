"# Dental-Practice-Database-Project" 

Database Design and Development Database Project 2020

Database Implementation

The full database can be implemented in the following order:

1. Dental Practice Database Creation Script.sql
should be imported first. This creates the basic tables and relations.
2. Dental Practice Data Insertion Script.sql
should be imported second. This populates the tables
with some user data.
3. Dental Practice query Insertion Script.sql
is the last to be imported. This script adds the queries and also creates
two views.

Database Presentation

The database is comprised of the following tables and views:
Patient Chart - this table stores the patien information such as name, address, contact details.
Appointment Diary - this table stores appointment details like treatment, date, time and cancellations.
Visit Card - this tables stores the visit information for each patient.
Bill - a table used to create bills based on the treatment for each patient.
Payment - a table used to insert patient payments.
Treatment Fees - a table that contains all the treatment names and fees.
Patient Appointment - a view that centralises all the appointments and patient information.
Patient Bill - a view that shows all the outstanding bills and bill information for the patients.
Patient History - a view that show all the patient records.

Operation and Queries

The main focus when using the database will be on the three views. The Patient Appointment view can be used to schedule
appointments and send out appointment cards that contain appointment date and treatment information. The Patient Bill
view holds the visit card information, bill and outstanding amounts. It can be used to check and generate invoices. The
Patient history holds all the patient information and can used as referrence for future treatments.
The following queries show the usual operations that a user might input into the database. These are implemented in the
database query insertion script:

• A select command to see what treatment a certain patient has.
• An insert command that adds a new patient information.
• An insert command that sets up an appointment for a treatment for a patient named "Lindall".
• An insert command that creates a visit card for a patient named "Lindall".
• An insert command that creates a bill for a patient named "Lindall".
• An update command that adds a phone number to a previous null field.
• If a patient has a late cancellation, a new entry can be made in the appointmentdiary with "late cancellation" (number 9 in treatmentfees) as treatment. This can be made into a visitcard and subsequantially a bill.
• An delete command that removes an appointment entry based on a persons name.
• A create command that sets up a view called patient bill where the user can see all the bills issued to the patients.
• A create command that sets up a view called patient history where the user can see all the patient records.
• An update command that uses the patienbill view to update a patient's name.
• An insert command that registers a full payment made by the patient Lindall.
• An update command that changes the field paid in the bill table to true. The patientbill view will not show the bill anymore.
• An insert command that registers a partial payment made by a patient. The patientbill view is automatically updated with the new value.
