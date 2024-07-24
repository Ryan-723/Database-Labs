-- ex1_NDG.sql
-- Fall 2023 Exercise 1
-- Revision History:
-- , Section 2, 2023.09.23: Created
-- , Section 2, 2023.09.23: Updated


Print 'F22 PROG8080 Section 2';
Print 'Exercise 1';
Print '';
Print 'Student Name: ';
Print '';
Print GETDATE();
Print '';


USE AP;

GO

--1 List the columns of the Terms table in the AP database.
Print '--Question 1--';
SELECT * FROM [dbo].[Terms];

--2 List the �state code� vendors are from, but show each �state code� only once (i.e., no duplicates). List the results in descending order.
Print '--Question 2--';
SELECT DISTINCT VendorState FROM [dbo].[Vendors]

--3 Display all the columns of vendors from Texas.
Print '--Question 3--';
SELECT  * FROM [dbo].[Vendors] WHERE VendorState ='TX'; 

--4. List all the columns of invoices with a Vendor ID of 83.
Print '--Question 4--';
SELECT  * FROM [dbo].[Invoices] WHERE VendorID = 83; 

-- 5. List the 5 columns (Invoice ID, Vendor ID, Invoice Total, Credit Total and Payment Total) for invoices with Invoice ID of 17
Print '--Question 5--';
SELECT  InvoiceID,VendorID,InvoiceTotal,CreditTotal, PaymentDate FROM [dbo].[Invoices] WHERE InvoiceID = 17; 

--6. List the 4 columns (Vendor ID, Vendor Name, Default Terms ID and a string expression that includes Vendor City, Vendor State and Vendor Zip Code separates by commas) for vendors with a Vendor ID of 123.
Print '--Question 6--';
SELECT VendorID, VendorName, DefaultTermsID,
       VendorCity + ', ' + VendorState + ' ' + VendorZipCode AS 'Address'
FROM Vendors
WHERE VendorID = 123;

--7 List the 7 columns (Vendor ID, Terms ID, Invoice ID, Invoice Total, Credit Total, Payment Total and an arithmetic expression for �Balance Due� calculated as �Invoice Amount minus Credit Amount minus Payment Amount�) for invoices with Vendor ID of 123 and �Balance Due� greater than zero
Print '--Question 7--';
SELECT VendorID,
       TermsID,
       InvoiceID,
       InvoiceTotal,
       CreditTotal,
       PaymentTotal,
       (InvoiceTotal - CreditTotal - PaymentTotal) AS "Balance Due"
FROM Invoices
WHERE VendorID = 123
  AND (InvoiceTotal - CreditTotal - PaymentTotal) > 0;

--8 List all the columns of the invoice line items with Invoice IDs listed in the previous question. Use the IN operator as part of your solution.
Print '--Question 8--';
SELECT *
FROM InvoiceLineItems
WHERE InvoiceID IN (94,99,100,101);


--9 List the Vendor State and Vendor Contact First Name columns, followed by 6 columns using the following string functions with the Vendor Contact First Name as the argument: LEN(), LOWER(), UPPER(),LEFT(), RIGHT(), and TRIM() for vendors from Florida (FL) or Texas (TX).
Print '--Question 9--';
SELECT
  VendorState AS VendorState,
  VendorContactFName AS FirstName,
  LEN(VendorContactFName) AS LengthOfName,
  LOWER(VendorContactFName) AS LowerCase,
  UPPER(VendorContactFName) AS UpperCase,
  LEFT(VendorContactFName, 3) AS FirstThreeLetters,
  RIGHT(VendorContactFName, 3) AS LastThreeLetters,
  TRIM(VendorContactFName) AS TrimmedName
FROM Vendors
WHERE VendorState IN ('FL', 'TX');


--10 Format the Invoice Total money column with a �$�, CONVERT() and CHAR(12). For the Invoice Date column, use FORMAT() with model �yyyy.MM.dd�.
Print '--Question 10--';
SELECT
  InvoiceNumber,
  FORMAT(InvoiceDate, 'yyyy.MM.dd') AS InvoiceDate,
  '$' + CONVERT(CHAR(12), InvoiceTotal) AS InvoiceTotal
FROM Invoices
WHERE
  MONTH(InvoiceDate) = 1
  AND DAY(InvoiceDate) = 8
  AND YEAR(InvoiceDate) = 2020;