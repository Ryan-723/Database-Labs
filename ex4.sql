-- ex4_NDG.sql
-- Fall 2023 Exercise 4
-- Revision History:
-- , Section 2, 2023.11.26: Created
-- , Section 2, 2023.11.26: Updated

Print 'F22 PROG8080 Section 2';
Print 'Exercise 4';
Print '';
Print 'Student Name: ';
Print '';
Print GETDATE();
Print '';


USE AP;

Print '';
Print '--- Question 1 ---';

IF OBJECT_ID('VendorCopyNDG', 'U') IS NOT NULL DROP TABLE VendorCopyNDG;

SELECT * INTO VendorCopyNDG
FROM Vendors;

SELECT COUNT(*) AS NumberOfRows
FROM VendorCopyNDG;

Print '';
Print '--- Question 2 ---';

IF OBJECT_ID('InvoiceBalancesNDG') IS NOT NULL DROP TABLE InvoiceBalancesNDG;

SELECT *
INTO InvoiceBalancesNDG
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal <> 0

Select COUNT(*) AS "Total Number of rows in InvoiceBalancesNDG" FROM InvoiceBalancesNDG;

Print '';
Print '--- Question 3 ---';

SET IDENTITY_INSERT InvoiceBalancesNDG ON;
INSERT INTO InvoiceBalancesNDG(InvoiceID, VendorID, InvoiceNumber, InvoiceDate, InvoiceTotal, 
PaymentTotal, CreditTotal, TermsID, InvoiceDueDate, PaymentDate)
VALUES (114, 86, 4591178, '9-01-2022', 9345.60, 0, 0, 1, '10-01-2022', NULL)

SELECT * FROM InvoiceBalancesNDG
WHERE VendorID = 86;

Print '';
Print '--- Question 4 ---';

INSERT INTO InvoiceBalancesNDG(VendorID, InvoiceNumber, InvoiceTotal, PaymentTotal, CreditTotal, TermsID, InvoiceDate, InvoiceDueDate)
VALUES (30, 'COSTCO345', 2800.00, 0, 0, 1, GETDATE(), GETDATE()+30);

SELECT * FROM InvoiceBalancesNDG
WHERE VendorID = 30;

Print '';
Print '--- Question 5 ---';

UPDATE InvoiceBalancesNDG
SET CreditTotal = 300.00
WHERE InvoiceNumber = 'COSTCO345';

SELECT * FROM InvoiceBalancesNDG
WHERE InvoiceNumber = 'COSTCO345';

Print '';
Print '--- Question 6 ---';

UPDATE InvoiceBalancesNDG
SET CreditTotal = CreditTotal + 90
FROM
   (SELECT TOP 5 InvoiceID
    FROM InvoiceBalancesNDG
    WHERE InvoiceTotal - PaymentTotal - CreditTotal >= 900
    ORDER BY InvoiceTotal - PaymentTotal - CreditTotal DESC) AS TopFiveInvoices
WHERE InvoiceBalancesNDG.InvoiceID = TopFiveInvoices.InvoiceID;

SELECT TOP 5 InvoiceID, InvoiceNumber, VendorID, InvoiceTotal, CreditTotal
    FROM InvoiceBalancesNDG
    WHERE InvoiceTotal - PaymentTotal - CreditTotal >= 900
    ORDER BY InvoiceTotal - PaymentTotal - CreditTotal DESC

Print '';
Print '--- Question 7 ---';

DELETE FROM InvoiceBalancesNDG WHERE InvoiceNumber = '4591178';
SELECT * FROM InvoiceBalancesNDG;

Print '';
Print '--- Question 8 ---';

SELECT COUNT(*) AS "Total Count before Deleting" FROM VendorCopyNDG ;

DELETE FROM VendorCopyNDG
WHERE VendorID  NOT IN (SELECT DISTINCT VendorID FROM InvoiceBalancesNDG)

SELECT COUNT(*) AS "Total Count after Deleting" FROM VendorCopyNDG;

Print '';
Print '--- Question 9 ---';

DECLARE @VendorID INT = '123'; 
BEGIN TRAN;

DELETE FROM InvoiceBalancesNDG
WHERE VendorID = @VendorID;

IF @@ROWCOUNT > 1
    BEGIN
        ROLLBACK TRAN;
        PRINT 'More invoices than expected. Deletions rolled back.';
    END;
ELSE
    BEGIN
        COMMIT TRAN;
        PRINT 'Deletions committed to the database.';
    END;

SELECT COUNT(*) AS "Number of FedEx invoices" FROM InvoiceBalancesNDG WHERE VENDORID = 123;

Print '';
Print '--- Question 10 ---';

SELECT COUNT(*) as "Number of Invoices" FROM Invoices;

SELECT COUNT(*) as "Number of InvoiceLineItems" FROM InvoiceLineItems;

DECLARE @InvoiceID int;
BEGIN TRY
    BEGIN TRAN;
    INSERT Invoices
      VALUES (34,'ZXA-080','2020-03-01',14092.59,0,0,3,'2020-03-31',NULL);
    SET @InvoiceID = @@IDENTITY;
    INSERT InvoiceLineItems VALUES (@InvoiceID,1,160,4447.23,'HW upgrade');
    INSERT InvoiceLineItems
      VALUES (@InvoiceID,2,167,9645.36,'OS upgrade');
    COMMIT TRAN;
END TRY
BEGIN CATCH
    ROLLBACK TRAN;
END CATCH;

SELECT COUNT(*) as "Number of Invoices" FROM Invoices;

SELECT COUNT(*) as "Number of InvoiceLineItems" FROM InvoiceLineItems;
