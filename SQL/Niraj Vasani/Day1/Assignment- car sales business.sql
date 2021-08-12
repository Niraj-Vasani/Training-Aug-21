CREATE TABLE Employees
(
	EmployeeId INT IDENTITY(1,1) ,
	Emp_FirstName VARCHAR(20),
	Emp_LastName VARCHAR(20),
	Emp_MiddleName VARCHAR(20),
	Email VARCHAR(30) DEFAULT NULL,
	PhoneNumber VARCHAR(20) NOT NULL UNIQUE,
	HireDate DATE NOT NULL,
	Salary DECIMAL(10,2) NOT NULL,
	CommissionPerc DECIMAL(4,2) NOT NULL,
	Commission DECIMAL(7,2) DEFAULT NULL,

	PRIMARY KEY(EmployeeId, Emp_FirstName, Emp_LastName, Emp_MiddleName)
);

INSERT INTO Employees VALUES ('Sagar', 'Dudhat', 'Rameshbhai', NULL, 957123456, '12/02/2020', 15000, 1, 2000);

SELECT * FROM Employees;

CREATE TABLE Inventory
(
	CarCompany VARCHAR(20) NOT NULL,
	ModelName VARCHAR(25) NOT NULL,
	AvailableQuantity SMALLINT DEFAULT NULL,
	CarPrice DECIMAL(12,2) NOT NULL,

	PRIMARY KEY (CarCompany, ModelName)
);

INSERT INTO Inventory VALUES ('Toyota', 'Fortuner', 5, 3600000), ('Tesla', 'Model S Plaid', 8, 4000000);

SELECT * FROM Inventory;

CREATE TABLE Sales
(
	SalesId INT IDENTITY(1,1),
	CarCompany VARCHAR(20) NOT NULL,
	ModelName VARCHAR(25) NOT NULL,
	VIN VARCHAR(20),
	SoldPrice DECIMAL(12,2) NOT NULL,
	SoldDate DATE NOT NULL,
	Buyer_FirstName VARCHAR(20) NOT NULL,
	Buyer_LastName VARCHAR(20) NOT NULL,
	Buyer_MiddleName VARCHAR(20) NOT NULL,
	EmployeeId INT NOT NULL,
	Emp_FirstName VARCHAR(20) NOT NULL,
	Emp_LastName VARCHAR(20) NOT NULL,
	Emp_MiddleName VARCHAR(20),

	PRIMARY KEY (SalesId, VIN),

	CONSTRAINT FK_Inventory FOREIGN KEY (CarCompany, ModelName)
	REFERENCES Inventory(CarCompany, ModelName),

	CONSTRAINT FK_Employees FOREIGN KEY (EmployeeId, Emp_FirstName, Emp_LastName, Emp_MiddleName)
	REFERENCES Employees(EmployeeId, Emp_FirstName, Emp_LastName, Emp_MiddleName)
);

INSERT INTO Sales 
VALUES ('TESLA', 'Model S Plaid', 'JN8AS5MV8DW649196', 3800000, '10/08/2021', 'Niraj', 'Vasani', 'Chandubhai', 1, 'Sagar', 'Dudhat', 'Rameshbhai');

SELECT * FROM Sales;