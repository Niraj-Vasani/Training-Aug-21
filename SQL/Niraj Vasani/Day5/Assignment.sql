CREATE TABLE Employee
(
	Employee_ID INT PRIMARY KEY IDENTITY(1,1),
	First_Name VARCHAR(20) NOT NULL,
	Last_Name VARCHAR(20) NOT NULL,
	Salary DECIMAL(8,0) NOT NULL,
	Joining_Date VARCHAR(30) NOT NULL CONSTRAINT CK_Joining_Date CHECK (Joining_Date LIKE '__-___-__ __.__.__ __'),
	Department VARCHAR(30),
	Manager_ID INT
)

INSERT INTO Employee VALUES ('John', 'Abraham', 1000000, '01-JAN-13 12.00.00 AM', 'Banking', NULL), 
						   ('Michael', 'Clarke', 800000, '01-JAN-13 12.00.00 AM', 'Insurance', 1), 
						   ('Roy', 'Thomas', 700000, '01-FEB-13 12.00.00 AM', 'Banking', 1), 
						   ('Tom', 'Jose', 600000, '01-FEB-13 12.00.00 AM', 'Insurance', 2), 
						   ('Jerry', 'Pinto', 650000, '01-FEB-13 12.00.00 AM', 'Insurance', 3), 
						   ('Philip', 'Mathew', 750000, '01-JAN-13 12.00.00 AM', 'Services', 3), 
						   ('TestNmae1', '123', 650000, '01-JAN-13 12.00.00 AM', 'Services', 2), 
						   ('TestNmae2', 'Lname%', 600000, '01-FEB-13 12.00.00 AM', 'Insurance', 2)

SELECT * FROM Employee

CREATE TABLE Incentives
(
	Employee_Ref_ID INT PRIMARY KEY,
	Incentive_Date VARCHAR(15) NOT NULL CONSTRAINT CK_Incentive_Date CHECK (Incentive_Date LIKE '__-___-__'),
	Incentive_Amount DECIMAL(5,0) NOT NULL DEFAULT 0,

	CONSTRAINT FK_Employee_Ref_ID FOREIGN KEY (Employee_Ref_ID) REFERENCES Employee(Employee_ID)
)

INSERT INTO Incentives VALUES (1, '01-FEB-13', 5000), 
							  (2, '01-FEB-13', 3000), 
							  (3, '01-FEB-13', 4000)

SELECT * FROM Incentives

--Assignment:

--1. Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table

SELECT E.Employee_ID, CONCAT(E.First_Name, ' ', E.Last_Name) AS 'Name', E.Joining_Date, I.Incentive_Date, DATEDIFF(DAY, SUBSTRING(E.Joining_Date, 1, 9), I.Incentive_Date) AS 'Difference (In Days)' 
FROM Employee E INNER JOIN Incentives I ON E.Employee_ID = I.Employee_Ref_ID

--2. Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000

SELECT E.First_Name, I.Incentive_Amount 
FROM Employee E INNER JOIN Incentives I ON E.Employee_ID = I.Employee_Ref_ID 
WHERE I.Incentive_Amount > 3000

--3. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives.

SELECT E.First_Name, I.Incentive_Amount 
FROM Employee E LEFT JOIN Incentives I ON E.Employee_ID = I.Employee_Ref_ID

--4. Select EmployeeName, ManagerName from the employee table.

SELECT CONCAT(E1.First_Name, ' ', E1.Last_Name) AS 'Employee Name', CONCAT(E2.First_Name, ' ', E2.Last_Name) AS 'Manager Name' 
FROM Employee E1 LEFT JOIN Employee E2 
ON E1.Manager_ID = E2.Employee_ID

--5. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives and set incentive amount as 0 for those employees who didn’t get incentives.

SELECT E.First_Name, ISNULL (I.Incentive_Amount, 0) 
FROM Employee E LEFT JOIN Incentives I ON E.Employee_ID = I.Employee_Ref_ID