--1. Write a query that displays the FirstName and the length of the FirstName for all employees whose name starts with the letters ‘A’, ‘J’ or ‘M’. Give each column an appropriate label. Sort the results by the employees’ FirstName

SELECT FirstName AS 'Name', LEN(FirstName) AS 'Length of Name'
FROM Employees
WHERE FirstName LIKE 'A%' OR FirstName LIKE 'J%' OR FirstName LIKE 'M%'
ORDER BY FirstName;

--2. Write a query to display the FirstName and Salary for all employees. Format the salary to be 10 characters long, left-padded with the $ symbol. Label the column SALARY.

SELECT FirstName AS 'First Name', CONCAT (REPLICATE ('$', 10 - LEN (CAST (Salary AS INT))), CAST (Salary AS INT)) AS Salary
FROM Employees;

--3. Write a query to display the employees with their code, first name, last name and hire date who hired either on seventh day of any month or seventh month in any year.

SELECT EmployeeID, FirstName, LastName, HireDate
FROM Employees
WHERE DATENAME (DAY, HireDate) = '7' OR DATENAME (MONTH, HireDate) = 'July';

--4. Write a query to display the length of first name for employees where last name contains character ‘c’ after 2nd position.

SELECT LEN (FirstName) AS 'Length of First Name'
FROM Employees
WHERE CHARINDEX ('C', LastName, 3) > 0;

--5. Write a query to extract the last 4 character of PhoneNumber.

SELECT RIGHT (PhoneNumber, 4) AS 'Phone Number'
FROM Employees;

--6. Write a query to update the portion of the PhoneNumber in the employees table, within the phone number the substring ‘124’ will be replaced by ‘999’.

UPDATE Employees SET PhoneNumber = REPLACE (PhoneNumber, '124', '999')
WHERE PhoneNumber LIKE ('%124%');

--7. Write a query to calculate the age in year.

SELECT DATEDIFF (YEAR, '2000-04-22', GETDATE()) AS 'Birth Date';

--8. Write a query to get the distinct Mondays from HireDate in employees tables.

SELECT * FROM Employees
WHERE DATENAME (WEEKDAY, HireDate) = 'Monday';

--9. Write a query to get the FirstName and HireDate from Employees table where HireDate between ‘1987-06-01’ and ‘1987-07-30’

SELECT FirstName, HireDate
FROM Employees
WHERE HireDate BETWEEN '1987-06-01' AND '1987-07-30';

--10. Write a query to display the current date in the following format. Sample output : 12:00 AM Sep 5, 2014

SELECT FORMAT (GETDATE(), 'hh:mm tt MMM dd, yyyy') AS 'Date and Time';

--11. Write a query to get the FirstName, LastName who joined in the month of June.

SELECT FirstName, LastName
FROM Employees
WHERE DATENAME (MONTH, HireDate) = 'June';

--12. Write a query to get first name, hire date and experience of the employees.

SELECT FirstName AS 'First Name', HireDate AS 'Hire Date', 
CASE 
	WHEN DATEDIFF (MONTH, HireDate, GETDATE()) % 12 = 0 THEN CONCAT (DATEDIFF (YEAR, HireDate, GETDATE()), ' ', 'Year')
	WHEN DATEDIFF (YEAR, HireDate, GETDATE()) = 0 THEN CONCAT (DATEDIFF (MONTH, HireDate, GETDATE()) % 12, ' ', 'Month')
	ELSE CONCAT (DATEDIFF (YEAR, HireDate, GETDATE()), ' ', 'Year', ' ', DATEDIFF (MONTH, HireDate, GETDATE()) % 12, ' ', 'Month')
END
AS 'Experience' FROM Employees;

--13. Write a query to get first name of employees who joined in 1987.

SELECT FirstName AS 'First Name'
FROM Employees
WHERE DATENAME (YEAR, HireDate) = '1987';