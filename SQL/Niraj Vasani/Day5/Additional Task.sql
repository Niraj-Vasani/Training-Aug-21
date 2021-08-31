CREATE TABLE Car 
(
	CarId INT NOT NULL IDENTITY(1,1),
	VIN VARCHAR(20) NOT NULL UNIQUE,
	Make VARCHAR(20) NOT NULL,
	Model VARCHAR(20) NOT NULL,
	Year INT NOT NULL,
	Mileage DECIMAL(6,2) NOT NULL,
	AskPrice MONEY NOT NULL,
	InvoicePrice MONEY NOT NULL,

	CONSTRAINT PK_CarId_Car PRIMARY KEY (CarId),
)

INSERT INTO Car VALUES ('2D4FV47V66H156569', 'Tesla', 'S', 2009, 50, 500000, 9990685),
					   ('2HGFG12859H560346', 'Honda', 'Brio', 2011, 40.5, 49687568, 8976230),
					   ('1XP6DB9X2GD269631', 'Suzuki', 'Baleno', 2012, 90, 7864202, 1006907),
					   ('4T4BF1FK7ER411113', 'Maruti', 'Alto800', 2006, 80, 605207, 60000),
					   ('1FTRF18W5YKB58094', 'Hyundai', 'Concept', 1999, 10, 2021, 500),
					   ('WBAKC6C56CC302399', 'Mercedes', 'C200', 2021, 100, 111256470, 9999999)

SELECT * FROM Car

CREATE TABLE Dealership 
(
	DealershipId INT NOT NULL IDENTITY(1,1),
	DealershipName VARCHAR(20) NOT NULL,
	DealershipAddress VARCHAR(100) NOT NULL,
	DealershipCity VARCHAR(20) NOT NULL,
	DealershipState VARCHAR(20) NOT NULL,

	CONSTRAINT PK_DealershipId_Dealership PRIMARY KEY (DealershipId),

	CONSTRAINT CUK_DName_DAddress_Dealership UNIQUE (DealershipName, DealershipAddress),
)

INSERT INTO Dealership VALUES ( 'LAMotors', 'Lokhandwala', 'Mumbai', 'Maharashtra'),
							  ( 'JK Tyres', 'Old City', 'Kumbhalgarh', 'Rajasthan'),
							  ( 'NTC', 'Virod', 'Vadodara', 'Gujarat'),
							  ( 'CBI Raid Cars','CBI Park', 'Southern California', 'California'),
							  ( 'JaneMotors', 'Racecourse', 'Khandala', 'Srilanka'),
							  ( 'Jay Bhole Motors', 'Safdarganj', 'Prayagraj', 'UP'),
							  ( 'Force India', 'Pune Hills', 'Pune', 'Maharashtra')

SELECT * FROM Dealership

CREATE TABLE Inventory
(
	InventoryId INT NOT NULL IDENTITY(1,1),
	VIN VARCHAR(20) NOT NULL UNIQUE,
	DealershipId INT NOT NULL,

	CONSTRAINT PK_InventoryId_Inventory PRIMARY KEY (InventoryId),

	CONSTRAINT FK_VIN_Inventory FOREIGN KEY (VIN) REFERENCES Car(VIN) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_DealershipId_Inventory FOREIGN KEY (DealershipId) REFERENCES Dealership(DealershipId) ON DELETE CASCADE ON UPDATE CASCADE,
)

INSERT INTO Inventory VALUES ('2D4FV47V66H156569',1),
							 ('2HGFG12859H560346',2),
							 ('1XP6DB9X2GD269631',3),
							 ('4T4BF1FK7ER411113',5),
							 ('1FTRF18W5YKB58094',4),
							 ('WBAKC6C56CC302399',3)

SELECT * FROM Inventory

CREATE TABLE Salesperson
(
	SalespersonId INT NOT NULL IDENTITY(1,1),
	SalespersonFirstName VARCHAR(20) NOT NULL,
	SalespersonLastName VARCHAR(20) NOT NULL,
	SalespersonMiddelName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_SalespersonId_Salesperson PRIMARY KEY (SalespersonId),

	CONSTRAINT CUK_SalespersonName_Salesperson UNIQUE (SalespersonFirstName, SalespersonLastName, SalespersonMiddelName),
)

INSERT INTO Salesperson VALUES ('Avinash', 'Sant', 'Nikhil'),
							   ('Avinash', 'Sant', 'Atharv'),
							   ('Amit', 'Sharaf', 'Asim'),
							   ('Jayesh', 'Khatri', 'Adnan'),
							   ('Sanjit', 'Mehra', 'Prasanna'),
							   ('Tejas', 'Pathak', 'Rakesh'),
							   ('Amitabh', 'Dalal', 'Rajani'),
							   ('Lalita', 'Sharaf', 'Pran'),
							   ('Aadesh', 'Borra', 'Pravin'),
							   ('Haiya', 'Roy', 'Arnav')

SELECT * FROM Salesperson

CREATE TABLE ReportsTo
(
	ReportsToId INT  NOT NULL IDENTITY(1,1),
	SalespersonId INT NOT NULL,
	ManagingSalespersonId INT NOT NULL,

	CONSTRAINT PK_ReportsToId_ReportsTo PRIMARY KEY (ReportsToId),

	CONSTRAINT FK_SalespersonId_ReportsTo FOREIGN KEY (SalespersonId) REFERENCES Salesperson(SalespersonId) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_ManagingSalespersonId_ReportsTo FOREIGN KEY (ManagingSalespersonId) REFERENCES Salesperson(SalespersonId),
)

INSERT INTO ReportsTo VALUES (1, 10),
							 (2, 1),
							 (3, 1),
							 (4, 1),
							 (5, 2),
							 (6, 3),
							 (7, 4),
							 (8, 2),
							 (9, 3),
							 (10, 1)

SELECT * FROM ReportsTo

CREATE TABLE WorksAt
(
	WorksAtId INT NOT NULL IDENTITY(1,1),
	SalespersonId INT NOT NULL,
	DealershipId INT NOT NULL,
	MonthWorked INT DEFAULT NULL,
	BaseSalaryForMonth MONEY NOT NULL,

	CONSTRAINT PK_WorksAtId_WorksAt PRIMARY KEY (WorksAtId),

	CONSTRAINT FK_SalespersonId_WorksAt FOREIGN KEY (SalespersonId) REFERENCES Salesperson(SalespersonId) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_DealershipId_WorksAt FOREIGN KEY (DealershipId) REFERENCES Dealership(DealershipId) ON DELETE CASCADE ON UPDATE CASCADE,
)

INSERT INTO WorksAt VALUES (1, 1, 38, 486549),
						  (2, 6, 2, 1648025),
						  (3, 4, 4, 125600),
						  (4, 5, 2, 10000),
						  (5, 6, 10, 200000),
						  (6, 6, 1, 100000),
						  (7, 7, 36, 150000),
						  (8, 1, 12, 200000),
						  (9, 2, 25, 250000),
						  (10, 1, 38, 486549)

SELECT * FROM WorksAt

CREATE TABLE Customer
(
	CustomerId INT NOT NULL IDENTITY(1,1),
	CustomerFirstName VARCHAR(20) NOT NULL,
	CustomerLastName VARCHAR(20) NOT NULL,
	CustomerMiddleName VARCHAR(20) NOT NULL,
	CustomerAddress VARCHAR(100) NOT NULL,
	CustomerCity VARCHAR(20) NOT NULL,
	CustomerState VARCHAR(20) NOT NULL,
	
	CONSTRAINT PK_CustomerId_Customert PRIMARY KEY (CustomerId),

	CONSTRAINT CUK_CustomerName_Customer UNIQUE (CustomerFirstName, CustomerLastName, CustomerMiddleName),
)

INSERT INTO Customer VALUES ( 'Vipin', 'Sarkar', 'Shrivatsa ', 'Beg Street', 'Arsenal', 'London'),
							( 'Murali', 'Salvi', 'Nirmal ', 'Manchester Farm', 'Aston Villa', 'London'),
							('Pran', 'Nayar', 'Madhukar ', 'Fortress', 'Bengaluru', 'Karnataka'),
							('Karthik', 'Mathur', 'Suraj ', 'Debt Street', 'Barcelona', 'Barcelona'),
							('Agni', 'Tella', 'Manu ', 'Reach Street', 'Paris', 'Paris')

SELECT * FROM Customer

CREATE TABLE Sale
(
	SaleId INT NOT NULL IDENTITY(1,1),
	VIN VARCHAR(20) NOT NULL UNIQUE,
	CustomerId INT NOT NULL,
	SalespersonId INT NOT NULL,
	DealershipId INT NOT NULL,
	SalePrice MONEY NOT NULL,
	SaleDate DATE NOT NULL,

	CONSTRAINT PK_SaleId_Sale PRIMARY KEY (SaleId),

	CONSTRAINT FK_VIN_Sale FOREIGN KEY (VIN) REFERENCES Car(VIN) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_CustomerId_Sale FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_SalespersonId_Sale FOREIGN KEY (SalespersonId) REFERENCES Salesperson(SalespersonId) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_DealershipId_Sale FOREIGN KEY (DealershipId) REFERENCES Dealership(DealershipId) ON DELETE CASCADE ON UPDATE CASCADE,
)

INSERT INTO Sale VALUES ('2D4FV47V66H156569', 3, 7, 2, 4000000, '2010-09-25'),
						('2HGFG12859H560346', 1, 6, 6, 568000, '2010-10-31'),
						('1XP6DB9X2GD269631', 2, 4, 4, 4000, '2010-03-04'),
						('4T4BF1FK7ER411113', 5, 6, 6, 648000, '2010-03-15'),
						('1FTRF18W5YKB58094', 4, 9, 5, 657894123, '2010-05-24')

SELECT * FROM Sale



--1. Find the names of all salespeople who have ever worked for the company at any dealership.
SELECT CONCAT(S.SalespersonFirstName, SPACE(1), S.SalespersonMiddelName, SPACE(1), S.SalespersonLastName) AS 'Sales Person'
FROM Salesperson S JOIN WorksAt W ON S.SalespersonId = W.SalespersonId
WHERE W.DealershipId IN (SELECT DealershipId FROM Dealership)

--2. List the Name, Street Address, and City of each customer who lives in Ahmedabad.
SELECT CONCAT(CustomerFirstName, SPACE(1), CustomerMiddleName, SPACE(1), CustomerLastName) AS 'Custemer Name', CustomerAddress, CustomerCity 
FROM Customer
WHERE CustomerCity = 'Ahmedabad'

--3. List the VIN, make, model, year, and mileage of all cars in the inventory of the dealership named "Hero Honda Car World".
SELECT VIN, Make, Model, Year, Mileage 
FROM Car 
WHERE VIN IN (SELECT VIN 
				FROM Inventory 
				WHERE DealershipId = (SELECT DealershipId 
									  FROM Dealership 
									  WHERE DealershipName = 'Hero Honda Car World'))
--OR
SELECT C.VIN, C.Make, C.Model, C.Year, C.Mileage 
FROM Car C 
JOIN Inventory I ON C.VIN = I.VIN
JOIN Dealership D ON I.DealershipId = D.DealershipId
WHERE D.DealershipName = 'Hero Honda Car World'

--4. List names of all customers who have ever bought cars from the dealership named "Concept Hyundai".
SELECT CONCAT(CustomerFirstName, SPACE(1), CustomerMiddleName, SPACE(1), CustomerLastName) AS 'Customer Name' 
FROM Customer
WHERE CustomerId IN (SELECT CustomerId 
					 FROM Sale 
					 WHERE DealershipId = (SELECT DealershipId 
										   FROM Dealership 
										   WHERE DealershipName = 'Concept Hyundai'))
--OR
SELECT CONCAT(C.CustomerFirstName, SPACE(1), C.CustomerMiddleName, SPACE(1), C.CustomerLastName) AS 'Customer Name' 
FROM Customer C 
JOIN Sale S ON C.CustomerId = S.CustomerId 
JOIN Dealership D ON S.DealershipId = D.DealershipId
WHERE D.DealershipName = 'Concept Hyundai'

--5. For each car in the inventory of any dealership, list the VIN, make, model, and year of the car, along with the name, city, and state of the dealership whose inventory contains the car.
SELECT I.VIN, C.Make, C.Model, C.Year, D.DealershipName, D.DealershipCity, D.DealershipState
FROM Car C 
RIGHT JOIN Inventory I ON C.VIN = I.VIN
JOIN Dealership D ON I.DealershipId = D.DealershipId

--6. Find the names of all salespeople who are managed by a salesperson named "Adam Smith".
SELECT CONCAT(S.SalespersonFirstName, SPACE(1),  S.SalespersonMiddelName, SPACE(1), S.SalespersonLastName) AS 'Salesperson Name'
FROM Salesperson S 
JOIN ReportsTo R ON S.SalespersonId = R.SalespersonId
WHERE R.ManagingSalespersonId = (SELECT SalespersonId FROM Salesperson WHERE SalespersonFirstName = 'Adam' AND SalespersonLastName = 'Smith')

--7. Find the names of all salespeople who do not have a manager.
SELECT CONCAT(S.SalespersonFirstName, SPACE(1),  S.SalespersonMiddelName, SPACE(1), S.SalespersonLastName) AS 'Salesperson Name'
FROM Salesperson S
LEFT JOIN ReportsTo R ON S.SalespersonId = R.SalespersonId 
WHERE R.ManagingSalespersonId = NULL

--8. Find the total number of dealerships.
SELECT COUNT(*) AS 'Total Dealership' FROM Dealership

--9. List the VIN, year, and mileage of all "Toyota Camrys" in the inventory of the dealership named "Toyota Performance". (Note that a "Toyota Camry" is indicated by the make being "Toyota" and the model being "Camry".)
SELECT I.VIN, C.Year, C.Mileage 
FROM Car C 
JOIN Inventory I ON C.VIN = I.VIN
JOIN Dealership D ON I.DealershipId = D.DealershipId
WHERE C.Make = 'Toyota' AND C.Model = 'Camrys' AND D.DealershipName = 'Toyota Performance'

--10. Find the name of all customers who bought a car at a dealership located in a state other than the state in which they live.
SELECT CONCAT(C.CustomerFirstName, SPACE(1), C.CustomerMiddleName, SPACE(1), C.CustomerLastName) AS 'Customer Name' 
FROM Customer C
JOIN Sale S ON C.CustomerId = S.CustomerId 
JOIN Dealership D ON S.DealershipId = D.DealershipId 
WHERE D.DealershipState != C.CustomerState

--11. Find the name of the salesperson that made the largest base salary working at the dealership named "Ferrari Sales" during January 2010.
SELECT CONCAT(S.SalespersonFirstName, SPACE(1),  S.SalespersonMiddelName, SPACE(1), S.SalespersonLastName) AS 'Salesperson Name'  
FROM Salesperson S 
JOIN WorksAt W ON S.SalespersonId = W.SalespersonId
JOIN Dealership D ON W.DealershipId = D.DealershipId 
WHERE W.BaseSalaryForMonth = (SELECT MAX(BaseSalaryForMonth) FROM WorksAt) AND D.DealershipName = 'Ferrari Sales'

--12. List the name, street address, city, and state of any customer who has bought more than two cars from all dealerships combined since January 1, 2010.
SELECT CONCAT(C.CustomerFirstName, SPACE(1), C.CustomerMiddleName, SPACE(1), C.CustomerLastName) AS 'Customer Name', C.CustomerAddress, C.CustomerCity, C.CustomerState  
FROM Customer C 
JOIN (SELECT S.CustomerId, COUNT(S.VIN) AS 'Car_Bought' FROM Sale S WHERE SaleDate > '2010-01-01' GROUP BY S.CustomerId) AS temp ON C.CustomerId = temp.CustomerId 
WHERE Car_Bought > 2

--13. List the name, salesperson ID, and total sales amount for each salesperson who has ever sold at least one car. The total sales amount for a salesperson is the sum of the sale prices of all cars ever sold by that salesperson.
SELECT SalespersonId, Salesperson_Name, SUM(SalePrice) FROM 
(
SELECT S.SalespersonId, CONCAT(SP.SalespersonFirstName, SPACE(1), SP.SalespersonMiddelName, SPACE(1), SP.SalespersonLastName) AS 'Salesperson_Name', S.SalePrice 
FROM Sale S JOIN Salesperson SP ON S.SalespersonId = SP.SalespersonId
) temp
GROUP BY SalespersonId, Salesperson_Name
ORDER BY SalespersonId

--14. Find the names of all customers who bought cars during 2010 who were also salespeople during 2010. For the purpose of this query, assume that no two people have the same name.
SELECT CONCAT(C.CustomerFirstName, SPACE(1), C.CustomerMiddleName, SPACE(1), C.CustomerLastName) AS 'Customer_Name'
FROM Sale S
JOIN Customer C ON S.CustomerId = C.CustomerId
JOIN Salesperson SP ON S.SalespersonId = SP.SalespersonId
WHERE DATEPART(YEAR, S.SaleDate) = 2010 
AND CONCAT(SP.SalespersonFirstName, SPACE(1), SP.SalespersonMiddelName, SPACE(1), SP.SalespersonLastName) = CONCAT(C.CustomerFirstName, SPACE(1), C.CustomerMiddleName, SPACE(1), C.CustomerLastName)

--15. Find the name and salesperson ID of the salesperson who sold the most cars for the company at dealerships located in Gujarat between March 1, 2010 and March 31, 2010.
SELECT TOP (1) SalespersonId, Salesperson_Name, COUNT(VIN) AS 'Sold_Cars'
FROM
(
SELECT S.SalespersonId, CONCAT(SP.SalespersonFirstName, SPACE(1), SP.SalespersonMiddelName, SPACE(1), SP.SalespersonLastName) AS 'Salesperson_Name', S.VIN
FROM Sale S 
JOIN Salesperson SP ON S.SalespersonId = SP.SalespersonId 
JOIN Dealership D ON S.DealershipId = D.DealershipId
WHERE D.DealershipState = 'UP' AND S.SaleDate BETWEEN '2010-03-01' AND '2010-03-31' 
) temp
GROUP BY SalespersonId, Salesperson_Name
ORDER BY Sold_Cars

/*16. Calculate the payroll for the month of March 2010.
	* The payroll consists of the name, salesperson ID, and gross pay for each salesperson who worked that month.
	* The gross pay is calculated as the base salary at each dealership employing the salesperson that month, along with the total commission for the salesperson that month.
	* The total commission for a salesperson in a month is calculated as 5% of the profit made on all cars sold by the salesperson that month.
	* The profit made on a car is the difference between the sale price and the invoice price of the car. (Assume, that cars are never sold for less than the invoice price.)*/
