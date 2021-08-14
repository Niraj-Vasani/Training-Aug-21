--1. Write a SQL statement to create a table named countries including columns CountryId, CountryName and RegionId and make sure that no countries except Italy, India and China will be entered in the table. and combination of columns CountryId and RegionId will be unique.

CREATE TABLE Countries
(
	CountryId VARCHAR(10),
	CountryName VARCHAR(5) NOT NULL CONSTRAINT Ck_CountryName CHECK(CountryName IN ('India','Italy','China')),
	RegionId VARCHAR(10),
	CONSTRAINT Pk_CnRgId PRIMARY KEY (CountryId, RegionId)
);

INSERT INTO Countries VALUES ('IND-356','India', 001), ('IND-356', 'INDIA', 025), ('IND-356', 'india', 008), ('IND-356', 'InDiA', 005), ('CHN-156', 'China', 001), ('ITA-380', 'Italy', 003);

SELECT * FROM Countries;


--2. Write a SQL statement to create a table named JobHistory including columns EmployeeId, StartDate, End_Eate, Job_Id and Department_Id and make sure that the value against column EndDate will be entered at the time of insertion to the format like ‘–/–/—-‘.

CREATE TABLE JobHistory
(
	EmployeeId INT PRIMARY KEY IDENTITY(1,1),
	StartDate VARCHAR(12) NOT NULL,
	EndDate VARCHAR(12) NOT NULL CONSTRAINT Ck_EndDate CHECK (EndDate LIKE '__/__/____'),
	JobId INT NOT NULL,
	DepartmentId INT NOT NULL
);

INSERT INTO JobHistory VALUES ('2021/22/02','22/02/2022', 1, 1);

SELECT * FROM JobHistory;


--3. Write a SQL statement to create a table named jobs including columns JobId, JobTitle, MinSalary and MaxSalary, and make sure that, the default value for JobTitle is blank and MinSalary is 8000 and MaxSalary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.

CREATE TABLE Jobs
(
	JobId INT PRIMARY KEY IDENTITY(1,1),
	JobTitle VARCHAR(30) DEFAULT ' ',
	MinSalary DECIMAL(5,0) DEFAULT 8000.00,
	MaxSalary DECIMAL(8,0) DEFAULT NULL
);

INSERT INTO Jobs VALUES ('Junior Mobile Developer', 20000, 30000), ('Junior .Net Developer', NULL, NULL), ('Senior .Net Developer', NULL, 30000);

SELECT * FROM Jobs;


--4. Write a SQL statement to create a table employees including columns Employee_Id, FirstName, LastName, Email, PhoneNumber, Hire_Date, Job_Id, Salary, Commission, Manager_Id and Department_Id and make sure that, the Employee_Id column does not contain any duplicate value at the time of insertion, and the foreign key column DepartmentId, reference by the column DepartmentId of Departments table, can contain only those values which are exists in the Department table and another foreign key column JobId, referenced by the column JobId of jobs table, can contain only those values which are exists in the jobs table.

CREATE TABLE Departments
(
	DepartmentId INT PRIMARY KEY IDENTITY(1,1),
	DepartmentName VARCHAR(30) NOT NULL UNIQUE
);

INSERT INTO Departments VALUES ('Mobile Development'),('.Net Development');

SELECT * FROM Departments;

CREATE TABLE Employees
(
	EmployeeId INT PRIMARY KEY IDENTITY(1,1) ,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	JobId INT UNIQUE NOT NULL,
	Salary DECIMAL(10,2) NOT NULL,
	Commission DECIMAL(7,2) NOT NULL,
	Email VARCHAR(30)NOT NULL UNIQUE CONSTRAINT Ck_Email CHECK (Email LIKE '%@%.___'),
	PhoneNumber DECIMAL(10) NOT NULL UNIQUE CONSTRAINT Ck_Phone CHECK (PhoneNumber BETWEEN 1000000000 AND 9999999999),
	HireDate DATE NOT NULL,
	ManagerId INT NOT NULL,
	DepartmentName VARCHAR(30),
	DepartmentId INT

	CONSTRAINT FK_DepartmentId FOREIGN KEY (DepartmentId) REFERENCES Departments(DepartmentId),
	CONSTRAINT FK_JobId FOREIGN KEY (JobId) REFERENCES Jobs(JobId)
);

INSERT INTO Employees(FirstName, LastName, JobId, Email, PhoneNumber, HireDate, Salary, Commission, ManagerId, DepartmentName, DepartmentId) 
VALUES ('Niraj', 'Vasani', 1, 'nirajvasani2204@gmail.com', 7990589904, '02/08/2021', 20000, 2000, 2541, 'Mobile Development', 1),
	   ('Ankit', 'Bodar', 3, 'ankitbodar5875@gmail.com', 9454574624, '02/08/2021', 22000, 1500, 1532, '.Net Development', 2);

SELECT * FROM Employees;


--1. Write a SQL statement to add a foreign key constraint named fk_job_id on JobId column of JobHistory table referencing to the primary key JobId of jobs table.

ALTER TABLE JobHistory ADD CONSTRAINT fk_of_JobId FOREIGN KEY (JobId) REFERENCES Jobs(JobId);

--2. Write a SQL statement to drop the existing foreign key fk_job_id from JobHistory table on JobId column which is referencing to the JobId of jobs table.

ALTER TABLE JobHistory DROP CONSTRAINT fk_of_JobId;

--3. Write a SQL statement to add a new column named location to the JobHistory table.

ALTER TABLE JobHistory ADD Location VARCHAR(20);