-- _A1.sql
-- Assignment 1
-- Revision History
-- , Section 1, 2023.09.30: Created
-- , Section 1, 2023.09.29: Updated

Print 'F23 PROG8080 Section 2';
Print 'Assignment 1';
Print '';
Print '';
Print GETDATE();
Print '';

USE SIS;


Print'***Question 1***';
Print'';
select * from AcademicStatus;


Print'***Question 2***';
Print'';
select number, academicStatusCode 
from Student
where academicStatusCode='D'
order by number desc;


Print'***Question 3***';
Print'';
--by default its ordered in ascending
select number, academicStatusCode 
from Student
where academicStatusCode<>'N';



Print'***Question 4***';
Print'';
select distinct provinceCode
from Person
order by provinceCode desc;


Print'***Question 5***';
Print'';
select distinct provinceCode
from Person
where provinceCode is not NULL;


Print'***Question 6***';
Print'';
select number, lastName, firstName, city, countryCode
from Person
where provinceCode is NULL;


Print'***Question 7***';
Print'';
select number, lastName, firstName, city, countryCode
from Person
where firstName like 'AND_';


Print'***Question 8***';
Print'';
select *
from Program
where name like 'Computer%';


Print'***Question 9***';
Print'';
select code, acronym, name
from Program
where name like '%Coop%';




Print'***Question 10***';
Print'';
select *
from CourseStudent
where finalMark<55 AND finalMark <> 0;



Print'***Question 11***';
Print'';
select number,capacity,memory
from Room
where capacity>=40 AND isLab='true' AND memory = '4GB' AND campusCode='D';



Print'***Question 12***';
Print'';
select *
from Employee
where schoolCode='TAP' AND campusCode IN ('D','G','W');




Print'***Question 13***';
Print'';
select lastName, Lower(SUBSTRING( firstName,1,1)) + LOWER(Left(lastName,7)) as "User ID" 
from Person
where lastName like 'J%'
order by "User ID" desc;




Print'***Question 14***';
Print'';
select *
from (select number, 
Format(birthdate,'MMMM dd, yyyy') as dob, 
(DATEDIFF(YEAR,birthdate,GETDATE())) as age 
from person) as seniorCitizen
where age>60;




Print'***Question 15***';
Print'';
select number as 'Course Code', name as 'Course Name'
from Course
where CHARINDEX('Game',name)>0;




Print'***Question 16***';
Print'';
select *
from (select item as 'Incidental Fee', 
amountPerSemester as 'Current Fee',
Convert(varchar(10),cast(0.1*amountPerSemester as money)) as 'Increased Fee'
from IncidentalFee) as incidentalFeeAlt
order by 'Current Fee';
