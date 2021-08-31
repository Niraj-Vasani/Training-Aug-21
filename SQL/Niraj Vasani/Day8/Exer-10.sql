--1. Write a query to display the first day of the month (in datetime format) three months before the current month. 
--Sample current date : 2014-09-03 
--Expected result : 2014-06-01
SELECT DATEADD (DAY, 1, EOMONTH ( GETDATE(), -4 ) ) AS 'First day of the month (three months before the current month)'

--2. Write a query to display the last day of the month (in datetime format) three months before the current month. 
SELECT EOMONTH ( GETDATE(), -3) AS 'Last day of the month (three months before the current month)'

--3. Write a query to get the distinct Mondays from hire_date in employees tables. 
SELECT HireDate 
FROM Employees 
WHERE DATENAME ( WEEKDAY, HireDate ) = 'Monday'

--4. Write a query to get the first day of the current year. 
SELECT DATEADD (DAY, 1, EOMONTH ( GETDATE(), -MONTH ( GETDATE() ) ) ) AS 'First day of the current year'

--5. Write a query to get the last day of the current year. 
SELECT EOMONTH ( GETDATE(), 12 - MONTH ( GETDATE() ) ) AS 'Last day of the current year'

--6. Write a query to calculate the age in year. 
DECLARE @Birth_Date DATE = '2000-04-22'
SELECT DATEDIFF ( YEAR, @Birth_Date, GETDATE() ) AS 'Age (In Year)'

--7. Write a query to get the current date in the following format. 
--Sample date : 2014-09-04
--Output : September 4, 2014
SELECT CONCAT ( DATENAME (MONTH, GETDATE() ), SPACE(1), DAY ( GETDATE() ), ', ', YEAR ( GETDATE() ) )

--8. Write a query to get the current date in the following format. 
--Thursday September 2014
SELECT CONCAT (  DATENAME (WEEKDAY, GETDATE() ), SPACE(1),  DATENAME (MONTH, GETDATE() ), SPACE(1), YEAR ( GETDATE() ) )

--9. Write a query to extract the year from the current date. 
SELECT YEAR ( GETDATE() ) AS 'Current Year'

--10. Write a query to get the DATE value from a given day (number in N). 
--Sample days : 730677
--Output : 2000-07-11
DECLARE @Given_Day INT = 730677 
SELECT DATEADD (DAY, @Given_Day, CONVERT(DATE, '0001-01-01'))

--11. Write a query to get the first name and hire date from employees table where hire date between '1987-06-01' and '1987-07-30' 
SELECT FirstName, HireDate 
FROM Employees 
WHERE HireDate BETWEEN '1987-06-01' AND '1987-07-30'

--12. Write a query to display the current date in the following format. 
--Sample output : Thursday 4th September 2014
SELECT CONCAT ( DATENAME ( WEEKDAY, GETDATE() ), SPACE(1), DAY ( GETDATE() ), SPACE(1), DATENAME ( MONTH, GETDATE() ), SPACE(1), YEAR ( GETDATE() ) )

--13.Write a query to display the current date in the following format. 
--Sample output : 05/09/2014
SELECT CONVERT (VARCHAR, GETDATE(), 103 )

--14. Write a query to display the current date in the following format. 
--Sample output : 12:00 AM Sep 5, 2014
SELECT CONCAT ( CONVERT ( VARCHAR, CAST ( GETDATE() AS TIME ), 100 ), SPACE(1), FORMAT( GETDATE(), 'MMM', 'en-US' ), SPACE(1), DAY ( GETDATE() ), ', ', YEAR ( GETDATE() ) )

--15. Write a query to get the firstname, lastname who joined in the month of June. 
SELECT FirstName, LastName 
FROM Employees 
WHERE DATENAME(MM, HireDate) = 'June'

--16. Write a query to get the years in which more than 10 employees joined. 
SELECT * FROM  
(
SELECT YEAR(HireDate) AS 'Year', COUNT(EmployeeID) AS 'Employees_Joined' 
FROM Employees 
GROUP BY YEAR(HireDate)
) temp
WHERE Employees_Joined > 10


--17. Write a query to get the department ID, year, and number of employees joined. 
SELECT DepartmentID, YEAR(HireDate) AS 'Year', COUNT(YEAR(HireDate)) AS 'Employees_Joined' 
FROM Employees 
GROUP BY DepartmentID, YEAR(HireDate)

--18. Write a query to get department name, manager name, and salary of the manager for all managers whose experience is more than 5 years. 
SELECT D.DepartmentName, CONCAT(E.FirstName, SPACE(1), E.LastName) AS 'Name', Salary, DATEDIFF(YEAR, HireDate, GETDATE()) AS 'Experience' 
FROM Departments D 
JOIN Employees E ON D.ManagerID = E.EmployeeID 
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 5

--19. Write a query to get employee ID, last name, and date of first salary of the employees. 
SELECT EmployeeID, LastName, HireDate, DATEADD(MONTH, 1, HireDate) AS 'Date of first salary' 
FROM Employees

--20. Write a query to get first name, hire date and experience of the employees. 
SELECT FirstName, HireDate, DATEDIFF(YEAR, HireDate, GETDATE()) AS 'Experience' 
FROM Employees

--21. Write a query to get first name of employees who joined in 1987. 
SELECT FirstName, YEAR(HireDate) AS 'Joining Year' 
FROM Employees 
WHERE YEAR(HireDate) = 1987