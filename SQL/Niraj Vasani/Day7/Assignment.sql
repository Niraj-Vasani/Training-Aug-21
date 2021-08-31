--Day4 CTE Task
--1. Write a query to rank employees based on their salary for a month
WITH TEMP
AS
(
SELECT DENSE_RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank, * 
FROM Employees
)
SELECT * FROM TEMP

--2. Select 4th Highest salary from employee table using ranking function
WITH TEMP 
AS
(
SELECT DENSE_RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank, * FROM Employees
)
SELECT * FROM TEMP WHERE Salary_Rank = 4

--3. Get department, total salary with respect to a department from employee table.
WITH TEMP
AS
(
SELECT DepartmentID, SUM(Salary) AS Total_Salary 
FROM Employees 
GROUP BY DepartmentID
)
SELECT * FROM TEMP

--4. Get department, total salary with respect to a department from employee table order by total salary descending
WITH TEMP
AS
(
SELECT DepartmentID, SUM(Salary) AS Total_Salary 
FROM Employees 
GROUP BY DepartmentID
)
SELECT * FROM TEMP ORDER BY Total_Salary DESC

--5. Get department wise maximum salary from employee table order by salary ascending
WITH TEMP
AS
(
SELECT DepartmentID, MAX(Salary) AS Max_Salary 
FROM Employees 
GROUP BY DepartmentID 
)
SELECT * FROM TEMP ORDER BY Max_Salary ASC

--6. Get department wise minimum salary from employee table order by salary ascending
WITH TEMP
AS
(
SELECT DepartmentID, MIN(Salary) AS Min_Salary 
FROM Employees 
GROUP BY DepartmentID 
)
SELECT * FROM TEMP ORDER BY Min_Salary ASC

--7. Select department, total salary with respect to a department from employee table where total salary greater than 50000 order by TotalSalary descending
WITH TEMP
AS
(
SELECT DepartmentID, SUM(Salary) AS Total_Salary FROM Employees GROUP BY DepartmentID
)
SELECT * FROM TEMP 
WHERE Total_Salary > 50000 
ORDER BY Total_Salary DESC


--Day5 CTE Tasks
--1. Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table
WITH TEMP
AS
(
SELECT E.Employee_ID, CONCAT(E.First_Name, ' ', E.Last_Name) AS 'Name', E.Joining_Date, I.Incentive_Date, DATEDIFF(DAY, SUBSTRING(E.Joining_Date, 1, 9), I.Incentive_Date) AS 'Difference (In Days)' 
FROM Employee E INNER JOIN Incentives I ON E.Employee_ID = I.Employee_Ref_ID
)
SELECT * FROM TEMP

--2. Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000
WITH TEMP
AS
(
SELECT E.First_Name, I.Incentive_Amount 
FROM Employee E INNER JOIN Incentives I ON E.Employee_ID = I.Employee_Ref_ID 
)
SELECT * FROM TEMP WHERE Incentive_Amount > 3000

--3. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives.
WITH TEMP
AS
(
SELECT E.First_Name, I.Incentive_Amount 
FROM Employee E LEFT JOIN Incentives I ON E.Employee_ID = I.Employee_Ref_ID
)
SELECT * FROM TEMP

--4. Select EmployeeName, ManagerName from the employee table.
WITH TEMP
AS
(
SELECT CONCAT(E1.First_Name, ' ', E1.Last_Name) AS 'Employee Name', CONCAT(E2.First_Name, ' ', E2.Last_Name) AS 'Manager Name' 
FROM Employee E1 LEFT JOIN Employee E2 ON E1.Manager_ID = E2.Employee_ID
)
SELECT * FROM TEMP

--5. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives and set incentive amount as 0 for those employees who didn’t get incentives.
WITH TEMP
AS
(
SELECT E.First_Name, ISNULL (I.Incentive_Amount, 0) AS Incentive_Amount 
FROM Employee E LEFT JOIN Incentives I ON E.Employee_ID = I.Employee_Ref_ID
)
SELECT * FROM TEMP