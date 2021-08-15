--1. Write a query to rank employees based on their salary for a month

SELECT DENSE_RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank, * 
FROM Employees

--2. Select 4th Highest salary from employee table using ranking function

SELECT * FROM 
(SELECT DENSE_RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank, * FROM Employees) temp 
WHERE Salary_Rank = 4


--3. Get department, total salary with respect to a department from employee table.

SELECT DepartmentID, SUM(Salary) AS Total_Salary 
FROM Employees 
GROUP BY DepartmentID

--4. Get department, total salary with respect to a department from employee table order by total salary descending

SELECT DepartmentID, SUM(Salary) AS Total_Salary 
FROM Employees 
GROUP BY DepartmentID
ORDER BY Total_Salary DESC

--5. Get department wise maximum salary from employee table order by salary ascending

SELECT DepartmentID, MAX(Salary) AS Max_Salary 
FROM Employees 
GROUP BY DepartmentID 
ORDER BY Max_Salary ASC

--6. Get department wise minimum salary from employee table order by salary ascending

SELECT DepartmentID, MIN(Salary) AS Min_Salary 
FROM Employees 
GROUP BY DepartmentID 
ORDER BY Min_Salary ASC

--7. Select department, total salary with respect to a department from employee table where total salary greater than 50000 order by TotalSalary descending

SELECT * FROM
(SELECT DepartmentID, SUM(Salary) AS Total_Salary FROM Employees GROUP BY DepartmentID) temp
WHERE Total_Salary > 50000 
ORDER BY Total_Salary DESC