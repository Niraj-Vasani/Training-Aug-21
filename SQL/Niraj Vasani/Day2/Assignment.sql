--Update Queries:

--1

UPDATE Employees SET Email = 'not available';

--2

UPDATE Employees SET Email = 'not available', CommissionPct = 0.10;

--3

UPDATE Employees SET Email = 'not available', CommissionPct = 0.10 WHERE EmployeeID = 110;

--4

UPDATE Employees SET Email = 'not available' WHERE DepartmentID = 80 AND CommissionPct < 0.20;

--5

UPDATE Employees SET Email = 'not available' FROM Employees AS E JOIN Departments AS D ON E.DepartmentID = D.DepartmentID WHERE DepartmentName = 'Accounting';

--6

UPDATE Employees SET Salary = CASE
								  WHEN Salary < 5000 THEN 8000
								  ELSE Salary
							  END
							  WHERE EmployeeID = 105;

--7

UPDATE Employees SET JobId = CASE
								 WHEN DepartmentID = 30 AND JobId != 'SH%' THEN 'SH_CLERK'
								 ELSE JobId
							 END
							 WHERE EmployeeID = 118;

--8

UPDATE Employees SET Salary = CASE
								  WHEN DepartmentID = 40 THEN (Salary + (Salary * 0.25))
								  WHEN DepartmentID = 90 THEN (Salary + (Salary * 0.15))
								  WHEN DepartmentID = 110 THEN (Salary + (Salary * 0.10))
								  ELSE Salary
							  END;

--9



--Basic Select Queries:

--1

SELECT * FROM Employees;

--2

SELECT FirstName, LastName FROM Employees;

--3

SELECT FirstName AS 'Employee Name' FROM Employees;

--4

SELECT * FROM Employees WHERE FirstName = 'Steven';

--5

SELECT * FROM Employees WHERE FirstName = 'Neena' OR FirstName = 'Lex';

--6

SELECT * FROM Employees WHERE FirstName != 'Neena' AND FirstName != 'Nandita';

--7

SELECT * FROM Employees WHERE Salary BETWEEN 5000 AND 8000;

--8

SELECT CONCAT(FirstName,' ', LastName) AS names, Salary, (Salary*0.12) AS 'PF' FROM Employees;

--9

SELECT * FROM Employees WHERE FirstName LIKE 'N%';

--10

SELECT DISTINCT DepartmentID FROM employees;

--11

SELECT * FROM Employees ORDER BY FirstName DESC;

--12

SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS Names, Salary FROM Employees ORDER BY Salary ASC;

--13

SELECT TOP 2 Salary FROM Employees;