-- A1_NG.sql
-- Assignment 2
-- Revision History
-- , Section 2, 2023.10.14: Created
-- , Section 2, 2023.10.14: Updated

Print 'F23 PROG8080 Section 2';
Print 'Assignment 2';
Print '';
Print '';
Print GETDATE();
Print '';

USE SIS;


Print'***Question 1***';
Print'';
SELECT p.schoolCode, p.code, pc.courseNumber, pc.semester 
FROM Program p 
INNER JOIN ProgramCourse pc
ON (p.code = pc.programCode)
WHERE code = '0066C'
ORDER BY pc.semester, pc.courseNumber;






Print'***Question 2***';
Print'';
SELECT cp.courseNumber AS [COURSE CODE], 
	cp.prerequisiteNumber, 
	c.name AS [PREREQ COURSE NAME]
FROM Course c, CoursePrerequisiteAnd cp
WHERE cp.courseNumber = 'COMP2280' 
	AND cp.prerequisiteNumber = c.number
ORDER BY cp.prerequisiteNumber DESC;




Print'***Question 3***';
Print'';
SELECT P.number, P.firstName, P.lastName, P.city
FROM Person AS P
LEFT JOIN Student AS S ON P.number = S.number
WHERE S.number IS NULL
ORDER BY P.lastName;




Print'***Question 4***';
Print'';
SELECT LS.softwareUniqueId, S.product
FROM LabSoftware LS
INNER JOIN Software S ON LS.softwareUniqueId = S.uniqueId
INNER JOIN Room R ON LS.roomId = R.id
WhERE R.number = '2A205'
ORDER BY S.product;



Print'***Question 5***';
Print'';
SELECT e1.number AS "Employee", e1.reportsTo AS "Supervisor", e2.reportsTo AS "Supervisor Reports To"
FROM Employee AS e1
LEFT JOIN Employee AS e2 ON e1.reportsTo = e2.number
ORDER BY e1.reportsTo;



Print'***Question 6***';
Print'';
SELECT co.courseNumber AS COURSE, 
	MIN(cs.finalMark) AS [LOWEST MARK], 
	ROUND(AVG(cs.finalMark), 0) AS [AVERAGE MARK], 
	MAX(cs.finalMark) AS [HIGHEST MARK]
FROM CourseOffering co 
INNER JOIN CourseStudent cs
ON co.id = cs.CourseOfferingId
WHERE co.sessionCode = 'W10'
GROUP BY co.courseNumber;




Print'***Question 7***';
Print'';
SELECT E.number AS 'Employee',
	UPPER(SUBSTRING(P.lastName, 1, 3) + RIGHT(E.number, 3)) AS 'User ID',
	COUNT(CO.courseNumber) AS '# Courses Taught'
FROM Employee E
INNER JOIN Person P ON E.number = P.number
INNER JOIN CourseOffering CO ON E.number = CO.employeeNumber
WHERE E.schoolCode =  'EIT'
	AND (CO.sessionCode LIKE 'F08' OR CO.sessionCode LIKE 'F09' OR CO.sessionCode LIKE 'W09')
GROUP BY E.number, UPPER(SUBSTRING(P.lastName, 1, 3) + RIGHT(E.number, 3))
ORDER BY 'User ID';



Print'***Question 8***';
Print'';
SELECT
	P.acronym AS 'PROGRAM',
	P.name AS 'PROGRAM NAME',
	FORMAT(SUM(PF.tuition * PF.coopFeeMultiplier), 'C', 'en-US') AS "TOTAL FEES"
FROM Program P
INNER JOIN ProgramFee PF ON P.code = PF.code
WHERE P.name LIKE '%Coop%'
GROUP BY P.acronym, P.name;




Print'***Question 9***';
Print'';
SELECT py.studentNumber AS [STUDENT NUMBER],
	p.lastName AS [LAST NAME], 
	p.firstName AS [FIRST NAME], 
	SUM(py.amount) AS [TOTAL PAYMENT AMOUNT]
FROM Person p
INNER JOIN Payment py
ON p.number = py.studentNumber
INNER JOIN PaymentMethod pm
ON py.paymentMethodId = pm.id
WHERE pm.id IN (2,3)
GROUP BY py.studentNumber, p.lastName, p.firstName
HAVING SUM(py.amount) >= 10000
ORDER BY [TOTAL PAYMENT AMOUNT] DESC;
