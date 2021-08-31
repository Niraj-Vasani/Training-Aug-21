--1. Write a SQL statement to create a simple table countries including columns country_id,country_name and region_id. make sure that the column country_id will be unique and store an auto incremented value.
CREATE TABLE Countries
(
	Country_id INT PRIMARY KEY IDENTITY(1,1),
	Country_name VARCHAR(56),
	Region_id INT
)

--2. Write a SQL statement to create a simple table countries including columns country_id, country_name and region_id which is already exists.
CREATE TABLE Countries
(
	Country_id INT PRIMARY KEY IDENTITY(1,1),
	Country_name VARCHAR(56),
	Region_id INT
)

--3. Write a SQL statement to create the structure of a table dup_countries similar to countries.
SELECT * INTO Dup_Countries FROM Countries WHERE 0 = 1

--4. Write a SQL statement to create a duplicate copy of countries table including structure and data by name dup_data_countries.
SELECT * INTO Dup_Data_Countries FROM Countries

--5. Write a SQL statement to create a table countries set a constraint NULL.
CREATE TABLE Countries
(
	Country_id INT PRIMARY KEY IDENTITY(1,1),
	Country_name VARCHAR(56) DEFAULT NULL,
	Region_id INT DEFAULT NULL
)

--6. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, max_salary and check whether the max_salary amount exceeding the upper limit 25000.
CREATE TABLE Jobs
(
	Job_Id INT PRIMARY KEY IDENTITY(1,1),
	Job_Title VARCHAR(20),
	Min_Salary DECIMAL(10,2),
	Max_Salary DECIMAL(14,2)
)
ALTER TABLE Jobs 
ADD CONSTRAINT CK_Max_Salary CHECK (Max_Salary <= 25000)

--7. Write a SQL statement to create a table named countries including columns country_id, country_name and region_id and make sure that no countries except Italy, India and China will be entered in the table. and combination of columns country_id and region_id will be unique.
CREATE TABLE Countries
(
	Country_id INT PRIMARY KEY IDENTITY(1,1),
	Country_name VARCHAR(56) NOT NULL,
	Region_id INT NOT NULL
)
ALTER TABLE Countries
ADD CONSTRAINT CK_Country_name CHECK (Country_name IN ('Italy', 'India', 'China'))

ALTER TABLE Countries
ADD CONSTRAINT UK_Countryid_Regionid UNIQUE (Country_id, Region_id)

--8. Write a SQL statement to create a table named job_history including columns employee_id, start_date, end_date, job_id and department_id and make sure that the value against column end_date will be entered at the time of insertion to the format like '--/--/----'.
CREATE TABLE Job_History
(
	Employee_Id INT PRIMARY KEY IDENTITY(1,1),
	Start_Date DATE NOT NULL,
	End_Date DATE NOT NULL,
	Job_Id INT NOT NULL,
	Department_Id INT NOT NULL
)
ALTER TABLE Job_History
ADD CONSTRAINT CK_End_Date CHECK (End_Date LIKE '__/__/____')

--9. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary and max_salary, and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.
CREATE TABLE Jobs
(
	Job_Id VARCHAR(10) PRIMARY KEY,
	Job_Title VARCHAR(15) NOT NULL DEFAULT ' ',
	Min_Salary DECIMAL(6,0) DEFAULT 8000,
	Max_Salary DECIMAL(6,0) DEFAULT NULL
)

--10. Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key column job_id contain only those values which are exists in the jobs table.
/*Here is the structure of the table jobs;
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| JOB_ID     | varchar(10)  | NO   | PRI |         |       |
| JOB_TITLE  | varchar(35)  | NO   |     | NULL    |       |
| MIN_SALARY | decimal(6,0) | YES  |     | NULL    |       |
| MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
*/
CREATE TABLE Job_History
(
	Employee_Id INT PRIMARY KEY IDENTITY(1,1),
	Start_Date DATE NOT NULL,
	End_Date DATE NOT NULL,
	Job_Id VARCHAR(10) NOT NULL,
	Department_Id INT NOT NULL
)
ALTER TABLE Job_History
ADD CONSTRAINT FK_Job_Id FOREIGN KEY (Job_Id) REFERENCES Jobs(Job_Id)

--11. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key columns combined by department_id and manager_id columns contain only those unique combination values, which combinations are exists in the departments table.
/*Assume the structure of departments table below.
+-----------------+--------------+------+-----+---------+-------+
| Field           | Type         | Null | Key | Default | Extra |
+-----------------+--------------+------+-----+---------+-------+
| DEPARTMENT_ID   | decimal(4,0) | NO   | PRI | 0       |       |
| DEPARTMENT_NAME | varchar(30)  | NO   |     | NULL    |       |
| MANAGER_ID      | decimal(6,0) | NO   | PRI | 0       |       |
| LOCATION_ID     | decimal(4,0) | YES  |     | NULL    |       |
+-----------------+--------------+------+-----+---------+-------+
*/
CREATE TABLE Departments 
(
	Department_Id DECIMAL(4,0) NOT NULL DEFAULT 0,
	Department_NAME VARCHAR(30) NOT NULL DEFAULT NULL,
	Manager_Id DECIMAL(6,0) NOT NULL DEFAULT 0,
	Location_Id DECIMAL(4,0) DEFAULT NULL
)
ALTER TABLE Departments
ADD CONSTRAINT PK_DepartmentId_ManagerId PRIMARY KEY (Department_Id, Manager_Id)

CREATE TABLE Employees 
(
	Employee_Id INT PRIMARY KEY,
	First_Name VARCHAR(15),
	Last_Name VARCHAR(15),
	Email VARCHAR(30),
	Phone_Number INT,
	Hire_Date DATE,
	Job_Id VARCHAR(10),
	Salary DECIMAL(6,0),
	Commission DECIMAL(6,0),
	Manager_Id DECIMAL(6,0),
	Department_Id DECIMAL(4,0)
)
ALTER TABLE Employees
ADD CONSTRAINT FK_ManagerId_DepartmentId FOREIGN KEY (Department_Id, Manager_Id) REFERENCES Departments(Department_Id, Manager_Id)

--12. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column department_id, reference by the column department_id of departments table, can contain only those values which are exists in the departments table and another foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. 
/*Assume that the structure of two tables departments and jobs.
+-----------------+--------------+------+-----+---------+-------+
| Field           | Type         | Null | Key | Default | Extra |
+-----------------+--------------+------+-----+---------+-------+
| DEPARTMENT_ID   | decimal(4,0) | NO   | PRI | 0       |       |
| DEPARTMENT_NAME | varchar(30)  | NO   |     | NULL    |       |
| MANAGER_ID      | decimal(6,0) | YES  |     | NULL    |       |
| LOCATION_ID     | decimal(4,0) | YES  |     | NULL    |       |
+-----------------+--------------+------+-----+---------+-------+

+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| JOB_ID     | varchar(10)  | NO   | PRI |         |       |
| JOB_TITLE  | varchar(35)  | NO   |     | NULL    |       |
| MIN_SALARY | decimal(6,0) | YES  |     | NULL    |       |
| MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
*/
CREATE TABLE Departments 
(
	Department_Id DECIMAL(4,0) DEFAULT 0 PRIMARY KEY,
	Department_NAME VARCHAR(30) NOT NULL DEFAULT NULL,
	Manager_Id DECIMAL(6,0) DEFAULT NULL,
	Location_Id DECIMAL(4,0) DEFAULT NULL
)

CREATE TABLE Jobs
(
	Job_Id VARCHAR(10) PRIMARY KEY,
	Job_Title VARCHAR(15) NOT NULL DEFAULT NULL,
	Min_Salary DECIMAL(6,0) DEFAULT NULL,
	Max_Salary DECIMAL(6,0) DEFAULT NULL
)

CREATE TABLE Employees 
(
	Employee_Id INT PRIMARY KEY,
	First_Name VARCHAR(15),
	Last_Name VARCHAR(15),
	Email VARCHAR(30),
	Phone_Number INT,
	Hire_Date DATE,
	Job_Id VARCHAR(10),
	Salary DECIMAL(6,0),
	Commission DECIMAL(6,0),
	Manager_Id DECIMAL(6,0),
	Department_Id DECIMAL(4,0)
)
ALTER TABLE Employees 
ADD CONSTRAINT FK_Department_Id FOREIGN KEY (Department_Id) REFERENCES Departments(Department_Id)

ALTER TABLE Employees
ADD CONSTRAINT FK_Job_Id FOREIGN KEY (Job_Id) REFERENCES Jobs(Job_Id)