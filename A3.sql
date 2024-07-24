-- A3_NDG.sql
-- Assignment 3
-- Revision History
-- , Section 2, 2023.11.18: Created
-- , Section 2, 2023.11.18: Updated

Print 'F23 PROG8080 Section 2';
Print 'Assignment 3';
Print '';
Print '';
Print GETDATE();
Print '';

USE SIS;


PRINT '';
Print '--- Question 1---';
PRINT 'List person number and birth date for the youngest person. Use a subquery to produce your result.';

SELECT number, birthdate
FROM Person
WHERE birthdate = 
     (SELECT MIN(birthdate) FROM Person);

PRINT '';
Print '--- Question 2---';
PRINT 'List the students whose home (permanent) country is USA or Canada, but not from Ontario, Canada. 
Include the student number, last name, first name, province and country in the result. Display the first
20 characters of last name and first name. Order your answer by last name and first name ascending. Use
a subquery to produce your result.';

SELECT S.number AS student_number,
    SUBSTRING(P.lastName, 1, 20) AS last_name,
    SUBSTRING(P.firstName, 1, 20) AS first_name,
    P.provinceCode AS province,
    P.countryCode AS country
FROM (SELECT * FROM Person WHERE countryCode IN ('USA', 'CAN')) AS P
    INNER JOIN Student AS S ON P.number = S.number
WHERE (P.countryCode = 'USA' OR P.countryCode = 'CAN')
        AND (P.provinceCode != 'ON')
ORDER BY last_name, first_name;

PRINT '';
Print '--- Question 3---';
Print 'List the courses that are offered in the first semester in the ITSS program. Include the course number, 
credit hours, credits, and course name in the result. Order your answer by course number ascending. Use only 
subqueries to produce your answer. The only literal string constant you can use is “ITSS”. Use subqueries to 
produce your result.';

SELECT 
    c.number AS "Course Number",
    c.hours as Hours,
    c.credits as Credits,
    c.name as "Course Name"
FROM Course c
WHERE c.number IN 
     (SELECT pc.courseNumber
        FROM ProgramCourse pc
        WHERE pc.programCode = (
            SELECT p.code
            FROM Program p
            WHERE p.acronym = 'ITSS'
        )
        AND pc.semester = 1
    )
ORDER BY "Course Number";

PRINT '';
Print '--- Question 4---';
Print 'List the names of the international students who are actively enrolled in any college program that 
leads to a post-graduate certificate. Order the result by student number. Use the literal string constant
credential name “Ontario College Graduate Certificate” as part of your solution. Use subqueries to produce 
your result. Number of rows expected: 32';

SELECT P.number AS 'studentNumber'
	  ,P.firstName AS 'First Name'
	  ,P.lastName AS 'Last Name'
FROM PERSON AS P
WHERE P.number IN
(
	SELECT S.number FROM Student AS S
	WHERE isInternational = 1 AND S.number IN
	(
		SELECT SP.studentNumber FROM StudentProgram AS SP
		WHERE SP.programStatusCode = 'A' AND SP.programCode IN
		(
			SELECT P.code FROM Program AS P
			WHERE P.credentialCode IN
			(
				SELECT C.code FROM Credential AS C
				WHERE C.name = 'Ontario College Graduate Certificate'
			)
		)
	)
)
ORDER BY number;

PRINT '';
Print '--- Question 5---';
Print 'Delete the Person record for Mary Taneja. ';

DELETE FROM person 
WHERE number=7424478;

DELETE FROM Course
WHERE number IN ('BUS9070', 'LIBS9010');

PRINT '';
Print '--- Question 6---';
Print 'Insert a Person record for Mary Taneja. Show all columns for the person record you just added.';

INSERT INTO PERSON (
    number, firstName, lastName, street,
    city, countryCode, postalCode,
    mainPhone, alternatePhone, collegeEmail, personalEmail, birthdate
)
VALUES (
    7424478, 'Mary', 'Taneja', 'FLAT NO. 206 TRIVENI APARTMENTS PITAM PURA',
    'NEW DELHI','IND', '110034', '0141-6610242', '94324060195',
    'mtaneja@conestogac.on.ca', 'mtaneja@bsnl.co.in', CONVERT(DATETIME, '1989-10-07', 120)
);
SELECT number, firstName, lastName, street,
    city, countryCode, postalCode,
    mainPhone, alternatePhone, collegeEmail, personalEmail, birthdate
FROM PERSON WHERE number = 7424478;

PRINT '';
Print '--- Question 7---';
PRINT 'Insert a Student record for Mary Taneja. Show these columns of the student record you just added:
 number, isInternational, academicStatusCode, financialStatusCode  sequentialNumber, balance, localStreet,
localCity and localPostalCode';

INSERT INTO Student (
    number,
    isInternational,
    academicStatusCode,
    financialStatusCode,
    sequentialNumber,
    balance,
    localStreet,
    localCity,
    localPostalCode
)
VALUES (
    7424478,
    1,
    'N',
    'N', 
    0,
    1130.00,
    '445 GIBSON ST N',
    'Kitchener',
    'N2M 4T4'
);

SELECT
    number,
    isInternational,
    academicStatusCode,
    financialStatusCode,
    sequentialNumber,
    balance,
    localStreet,
    localCity,
    localPostalCode
FROM Student
WHERE number = 7424478;


PRINT '';
Print '--- Question 8---';
Print 'Inspect the Program table to find the program code for the CAD program. Insert a StudentProgram record 
that puts Mary Taneja in the CAD program. Use the Program code that you looked up. Show studentNumber, programCode,
semester and programStatusCode for Mary Taneja';

-- Inserting data in StudentProgram Table
INSERT INTO StudentProgram (
    studentNumber,
    programCode,
    semester,
    programStatusCode
)
VALUES (
    7424478,
    '0066C',
    1,  
    'A'
);

-- Selecting currently inserted data
SELECT
    studentNumber,
    programCode,
    semester,
    programStatusCode
FROM StudentProgram
WHERE studentNumber = 7424478;


PRINT '';
Print '--- Question 9---';
Print 'Inspect the CourseOffering table and find the id for INFO8000 in the Fall 2020 (F20) session.
Insert a CourseStudent record that puts MaryTaneja in INFO8000 in the Fall 2020 session. Use the 
CourseOffering id that you looked up. Show courseOfferingId, studentNumber and finalMark for Mary Taneja.';
-- Inserting data in CourseStudent table
INSERT INTO CourseStudent (
    courseOfferingId,
    studentNumber,
    finalMark
)
VALUES (
    123,
    7424478,
    0
);

-- Selecting currently inserted data
SELECT
    courseOfferingId,
    studentNumber,
    finalMark
FROM CourseStudent
WHERE studentNumber = 7424478;


PRINT '';
Print '--- Question 10---';
Print 'Insert a Course record for LIBS9010. Use a column list in your INSERT statement. Show all columns 
for LIBS9010.';

-- Inserting data into Course table
INSERT INTO Course (
    number,
    hours,
    credits,
    name,
    frenchName
)
VALUES (
    'LIBS9010',
    45,
    3,
    'Critical Thinking Skills',
    'Pensée Critique'
);

-- Selecting the course data by course number
SELECT * 
FROM Course 
WHERE number = 'LIBS9010';


Print '--- Question 11---';
Print 'Insert a Course record for BUS9070. Do not use a column list in your INSERT statement. Show all columns 
for BUS9070.';

-- Inserting course detail in Course table
INSERT INTO Course
VALUES (
    'BUS9070',
    45,
    3,
    'Introduction To Human Relations',
    'Introduction aux relations humaines'
);

-- Displaying the data for BUS9070
SELECT * 
FROM Course 
WHERE number = 'BUS9070';


PRINT '';
Print '--- Question 12---';
Print 'Inspect the IncidentalFee table to find the id for the "Technology EnhancementFee". Update the "Technology 
Enhancement Fee" to $100.00. Begin a transaction. Update the "Technology Enhancement Fee" to set amountPerSemester
to $120.00. Rollback the transaction. Show the Technology Enhancement Fee. The amountPerSemester should
revert to the original amount.';

SELECT * 
FROM IncidentalFee 
WHERE id = 5;

UPDATE IncidentalFee
SET amountPerSemester = 100.00
WHERE id = 5;

BEGIN TRANSACTION;

UPDATE IncidentalFee
SET amountPerSemester = 120.00
WHERE id = 5;

ROLLBACK;

SELECT * 
FROM IncidentalFee 
WHERE id = 5;

PRINT '';
Print '--- Question 13---';
Print 'Begin a transaction. Update the Technology Enhancement Fee to set amountPerSemester to $190.00. 
Commit the transaction. Show the Technology Enhancement Fee. The amountPerSemester should be $190.00.';

BEGIN TRANSACTION;

UPDATE IncidentalFee
SET amountPerSemester = 190.00
WHERE id = 5;

COMMIT;

SELECT * 
FROM IncidentalFee 
WHERE id = 5;