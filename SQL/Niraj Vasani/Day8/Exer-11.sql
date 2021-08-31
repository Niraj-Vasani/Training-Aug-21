--1. Write a query to get the job_id and related employee's id. 
/*Partial output of the query :
job_id	Employees ID
AC_ACCOUNT	206
AC_MGR	205
AD_ASST	200
AD_PRES	100
AD_VP	101 ,102
FI_ACCOUNT	110 ,113 ,111 ,109 ,112
Sample table: employees*/
SELECT JobId, STRING_AGG(EmployeeID, ', ') AS "Employee's Id" 
FROM Employees 
GROUP BY JobId

--2. Write a query to update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'.
UPDATE Employees 
SET PhoneNumber = REPLACE(PhoneNumber,'124', '999') 
WHERE PhoneNumber LIKE '%124%'

--3. Write a query to get the details of the employees where the length of the first name greater than or equal to 8. 
SELECT * 
FROM Employees 
WHERE LEN(FirstName) >= 8

--4. Write a query to display leading zeros before maximum and minimum salary. 
SELECT STUFF(MAX(Salary), 1, 0, '00') AS 'Maximum_Salary', STUFF(MIN(Salary), 1, 0, '000') AS 'Minimum_Salary' FROM Employees

--5. Write a query to append '@example.com' to email field.
/*Sample Output :
  EMAIL
  --------------------
  SKING@example.com
  NKOCHHAR@example.com*/
UPDATE Employees 
SET Email = CONCAT(Email, '@example.com')

--6. Write a query to get the employee id, first name and hire month. 
SELECT EmployeeID, FirstName, DATENAME(MONTH, HireDate) AS 'Hire Month' 
FROM Employees

--7. Write a query to get the employee id, email id (discard the last three characters). 
SELECT EmployeeID, SUBSTRING(Email, 1, LEN(Email) - 3) AS 'Email' 
FROM Employees

--8. Write a query to find all employees where first names are in upper case. 
SELECT * 
FROM Employees 
WHERE CAST(FirstName AS VARBINARY) = CAST(UPPER(FirstName) AS VARBINARY)

--9. Write a query to extract the last 4 character of phone numbers. 
SELECT PhoneNumber, SUBSTRING(PhoneNumber, LEN(PhoneNumber) - 3, 4) AS 'Last 4 characters of phone number' 
FROM Employees

--10. Write a query to get the last word of the street address. 
SELECT StreetAddress, REVERSE(SUBSTRING(REVERSE(StreetAddress), 1, CHARINDEX(' ', REVERSE(StreetAddress)) - 1)) AS 'Last word of the street address' 
FROM Locations

--11. Write a query to get the locations that have minimum street length. 
SELECT * 
FROM Locations 
WHERE LEN(StreetAddress) = (SELECT MIN(LEN(StreetAddress)) FROM Locations)

--12. Write a query to display the first word in job title. 
SELECT JobId, SUBSTRING(JobId, 1, CHARINDEX('_', JobId) - 1)AS 'First word in job title' 
FROM Employees

--13. Write a query to display the length of first name for employees where last name contain character 'c' after 2nd position. 
SELECT FirstName, LEN(FirstName) 
FROM Employees 
WHERE CHARINDEX('c', LastName, 3) > 0 

--14. Write a query that displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names. 
SELECT FirstName AS 'Name', LEN(FirstName)  AS 'Length of Name' 
FROM Employees 
WHERE FirstName LIKE 'A%' OR FirstName LIKE  'J%' OR FirstName LIKE  'M%' 
ORDER BY FirstName

--15. Write a query to display the first name and salary for all employees. Format the salary to be 10 characters long, left-padded with the $ symbol. Label the column SALARY. 
SELECT FirstName, CONCAT(REPLICATE('$', 10 - LEN(Salary)), Salary) AS 'SALARY' 
FROM Employees

--16. Write a query to display the first eight characters of the employees' first names and indicates the amounts of their salaries with '$' sign. Each '$' sign signifies a thousand dollars. Sort the data in descending order of salary. 
SELECT SUBSTRING(FirstName, 1, 8), REPLICATE('$', ROUND(Salary / 1000, 0)) 
FROM Employees 
ORDER BY Salary DESC

--17. Write a query to display the employees with their code, first name, last name and hire date who hired either on seventh day of any month or seventh month in any year. 
SELECT EmployeeID, FirstName, LastName, HireDate 
FROM Employees 
WHERE DAY(HireDate) = 7 OR MONTH(HireDate) = 7