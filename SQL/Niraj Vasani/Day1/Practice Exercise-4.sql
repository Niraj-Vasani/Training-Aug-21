CREATE TABLE Departments
(
	DepartmentId INT PRIMARY KEY IDENTITY(1,1),
	DepartmentName VARCHAR(30) NOT NULL UNIQUE
);

INSERT INTO Departments VALUES ('Mobile Development'),('.Net Development');

CREATE TABLE Employees
(
	EmployeeId INT PRIMARY KEY IDENTITY(1,1) ,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	JobId INT UNIQUE NOT NULL,
	Salary DECIMAL(10,2) NOT NULL,
	Commission DECIMAL(7,2) NOT NULL,
	Email VARCHAR(30)NOT NULL UNIQUE,
	PhoneNumber VARCHAR(20) NOT NULL UNIQUE,
	HireDate DATE NOT NULL,
	ManagerId INT NOT NULL,
	DepartmentName VARCHAR(30),
	DepartmentId INT

	CONSTRAINT FK_DepartmentId FOREIGN KEY (DepartmentId) REFERENCES Departments(DepartmentId),
	CONSTRAINT FK_JobId FOREIGN KEY (JobId) REFERENCES Jobs(JobId)
);

INSERT INTO Employees(FirstName, LastName, JobId, Email, PhoneNumber, HireDate, Salary, Commission, ManagerId, DepartmentName, DepartmentId) 
VALUES ('Niraj', 'Vasani', 1, 'nirajvasani2204@gmail.com', '7990589904', '02/08/2021', 20000, 2000, 2541, 'Mobile Development', 1),
	   ('Ankit', 'Bodar', 3, 'ankitbodar5875@gmail.com', '9454574624', '02/08/2021', 22000, 1500, 1532, '.Net Development', 3);

SELECT * FROM Employees;