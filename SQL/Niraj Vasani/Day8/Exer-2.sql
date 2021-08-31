--1. Write a SQL statement to insert a record with your own value into the table countries against each columns.and region_id.
INSERT INTO Countries (CountryId,CountryName,RegionId) VALUES ('AR','Argentina',2)

--2. Write a SQL statement to insert one row into the table countries against the column country_id and country_name.
INSERT INTO Countries (CountryId,CountryName) VALUES ('IND','India')

--3.Write a SQL statement to insert 3 rows by a single insert statement.
INSERT INTO Countries VALUES ('AL', 'Albania',42),
							 ('AU', 'Australia',63),
							 ('BE', 'Belgium',11)

--4. Write a SQL statement insert rows from country_new table to countries table.
--Here is the rows to insert for country_new table. Assume that, the countries table is empty.
/*
+------------+--------------+-----------+
| COUNTRY_ID | COUNTRY_NAME | REGION_ID |
+------------+--------------+-----------+
| C0001      | India        |      1001 |
| C0002      | USA          |      1007 |
| C0003      | UK           |      1003 |
+------------+--------------+-----------+
*/
CREATE TABLE CountryNew 
(
  CountryID varchar(5) NOT NULL,
  CountryName varchar(40) DEFAULT NULL,
  RegionID decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (CountryID),
) 

INSERT INTO CountryNew (CountryId,CountryName,RegionId) VALUES ('C0001', 'India',1001),
															   ('C0002', 'USA',1007),
															   ('C0003', 'UK',1003)

INSERT INTO Countries SELECT * FROM CountryNew

--6.Write a SQL statement to insert one row in jobs table to ensure that no duplicate value will be entered in the job_id column.
ALTER TABLE Jobs ADD CONSTRAINT UK_Job UNIQUE(JobId)

--9. Write a SQL statement to insert a record into the table countries to ensure that, a country_id and region_id combination will be entered once in the table.
ALTER TABLE Countries ADD CONSTRAINT UK_CountryID_RegionID UNIQUE(CountryID, RegionID)

--10. Write a SQL statement to insert rows into the table countries in which the value of country_id column will be unique and auto incremented.
INSERT INTO Countries(CountryName,RegionId) VALUES('India',1001)

--11. Write a SQL statement to insert records into the table countries to ensure that the country_id column will not contain any duplicate data and this will be automatically incremented and the column country_name will be filled up by 'N/A' if no value assigned for that column.
INSERT INTO Countries(CountryId,CountryName,RegionId) VALUES(1,'India',582)

INSERT INTO Countries(RegionId) VALUES(507)

--12. Write a SQL statement to insert rows in the job_history table in which one column job_id is containing those values which are exists in job_id column of jobs table.
ALTER TABLE JobHistory
ADD CONSTRAINT FK_JobID FOREIGN KEY (JobID) REFERENCES Jobs(JobID)

INSERT INTO JobHistory(EmployeeID, StartDate, EndDate, JobID, DepartmentID) VALUES(101,	'1989-09-21', '1993-10-27',	'AC_ACCOUNT', 110)

--13. Write a SQL statement to insert rows into the table employees in which a set of columns department_id and manager_id contains a unique value and that combined values must have exists into the table departments.
ALTER TABLE Departments ADD CONSTRAINT UK_Depid_Mgrid UNIQUE (DepartmentID, ManagerID)
ALTER TABLE Employees ADD CONSTRAINT FK_Depid_Mgrid FOREIGN KEY (DepartmentID, ManagerID) REFERENCES Departments(DepartmentID, ManagerID)

INSERT INTO Employees(EmployeeID, FirstName, LastName, Email, PhoneNumber, HireDate, JobId, Salary, CommissionPct, ManagerID, DepartmentID)
VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR@example.com', '5151234568', '1987-06-18', 'AD_VP', 17000.00, 0.00, 100, 90)

--14. Write a SQL statement to insert rows into the table employees in which a set of columns department_id and job_id contains the values which must have exists into the table departments and jobs.
ALTER TABLE Employees ADD CONSTRAINT FK_DepId FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
ALTER TABLE Employees ADD CONSTRAINT FK_JobId FOREIGN KEY (JobId) REFERENCES Jobs(JobId)

INSERT INTO Employees(EmployeeID, FirstName, LastName, Email, PhoneNumber, HireDate, JobId, Salary, CommissionPct, ManagerID, DepartmentID)
VALUES (206, 'William', 'Gietz', 'WGIETZ@example.com', '5151238181', '1987-10-01', 'AC_ACCOUNT', 8300.00, 0.00, 205, 110)


CREATE TABLE  Employees (
    EmployeeID decimal(6,0) NOT NULL DEFAULT '0',
	FirstName varchar(20) DEFAULT NULL,
	LastName varchar(25) NOT NULL,
	Email varchar(25) NOT NULL,
	PhoneNumber varchar(20) DEFAULT NULL,
	HireDate date NOT NULL,
	JobId varchar(10) NOT NULL,
	Salary decimal(8,2) DEFAULT NULL,
	CommissionPct decimal(2,2) DEFAULT NULL,
	ManagerID decimal(6,0) DEFAULT NULL,
	DepartmentID decimal(4,0) DEFAULT NULL,
	CONSTRAINT pkEmployeeID PRIMARY KEY (EmployeeID),
	--CONSTRAINT ukEmail UNIQUE  (Email),
 )

 CREATE TABLE Departments (
   DepartmentID decimal(4,0) NOT NULL DEFAULT '0',
   DepartmentName varchar(30) NOT NULL,
   ManagerID decimal(6,0) DEFAULT NULL,
   LocationID decimal(4,0) DEFAULT NULL,
	PRIMARY KEY (DepartmentID),
 )

 CREATE TABLE Locations
(
   LocationID decimal(4,0) NOT NULL DEFAULT '0',
   StreetAddress varchar(40) DEFAULT NULL,
   PostalCode varchar(12) DEFAULT NULL,
   City varchar(30) NOT NULL,
   StateProvince varchar(25) DEFAULT NULL,
   CountryID varchar(2) DEFAULT NULL,
  PRIMARY KEY (LocationID),
 
)

CREATE TABLE Countries (
  CountryID INT IDENTITY(1,1),
  CountryName varchar(40) DEFAULT NULL,
  RegionID decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (CountryID),
)

CREATE TABLE  JobHistory (
   EmployeeID decimal(6,0) NOT NULL,
   StartDate date NOT NULL,
   EndDate date NOT NULL,
   JobID varchar(10) NOT NULL,
   DepartmentID decimal(4,0) DEFAULT NULL,
   PRIMARY KEY (EmployeeID,StartDate),

)

CREATE TABLE Jobs
(
	JobId VARCHAR(10) PRIMARY KEY,
	JobTitle VARCHAR(15) NOT NULL,
	MinSalary DECIMAL(6,0),
	MaxSalary DECIMAL(6,0)
)

