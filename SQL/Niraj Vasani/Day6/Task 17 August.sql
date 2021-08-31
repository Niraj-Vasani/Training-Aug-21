CREATE TABLE Branch
(
	Bname VARCHAR(18) PRIMARY KEY,
	City VARCHAR(18) NOT NULL
)

INSERT INTO Branch VALUES ('VRCE', 'NAGPUR'),
						  ('AJNI', 'NAGPUR'),
						  ('KAROLBAGH', 'DELHI'),
						  ('CHANDNI', 'DELHI'),
						  ('DHARAMPETH', 'NAGPUR'),
						  ('M.G.ROAD', 'BANGLORE'),
						  ('ANDHERI', 'MUMBAI'),
						  ('VIRAR', 'MUMBAI'),
						  ('NEHRU PLACE', 'DELHI'),
						  ('POWAI', 'MUMBAI')

SELECT * FROM Branch

CREATE TABLE Customer
(
	Cname VARCHAR(18) PRIMARY KEY,
	City VARCHAR(18) NOT NULL
)

INSERT INTO Customer VALUES ('ANIL', 'KOLKATA'),
							('SUNIL', 'DELHI'),
							('MEHUL', 'BARODA'),
							('MANDAR', 'PATNA'),
							('MADHURI', 'NAGPUR'),
							('PRAMOD', 'NAGPUR'),
							('SANDIP', 'SURAT'),
							('SHIVANI', 'MUMBAI'),
							('KRANTI', 'MUMBAI'),
							('NAREN', 'MUMBAI')

SELECT * FROM Customer

CREATE TABLE Deposit
(
	ActNo VARCHAR(5) PRIMARY KEY,
	Cname VARCHAR(18) NOT NULL CONSTRAINT FK_Cname FOREIGN KEY (Cname) REFERENCES Customer(Cname),
	Bname VARCHAR(18) NOT NULL CONSTRAINT FK_Bname FOREIGN KEY (Bname) REFERENCES Branch(Bname),
	Amount INT NOT NULL,
	Adate DATE NOT NULL
)

INSERT INTO Deposit VALUES (100, 'ANIL', 'VRCE', 1000, '1-Mar-1995'),
						   (101, 'SUNIL', 'AJNI', 5000, '4-Jan-1996'),
						   (102, 'MEHUL', 'KAROLBAGH', 3500, '17-Nov-1995'),
						   (104, 'MADHURI', 'CHANDNI', 1200, '17-Dec-1995'),
						   (105, 'PRAMOD', 'M.G.ROAD', 3000, '27-Mar-1996'),
						   (106, 'SANDIP', 'ANDHERI', 2000, '31-Mar-1996'),
						   (107, 'SHIVANI', 'VIRAR', 1000, '5-Sep-1995'),
						   (108, 'KRANTI', 'NEHRU PLACE', 5000, '2-Jul-1995'),
						   (109, 'NAREN', 'POWAI',	7000, '10-Aug-1995')

SELECT * FROM Deposit

CREATE TABLE Borrow
(
	LoanNo VARCHAR(5) PRIMARY KEY,
	Cname VARCHAR(18) NOT NULL CONSTRAINT FK_BoCname FOREIGN KEY (Cname) REFERENCES Customer(Cname),
	Bname VARCHAR(18) NOT NULL CONSTRAINT FK_BoBname FOREIGN KEY (Bname) REFERENCES Branch(Bname),
	Amount INT NOT NULL
)

INSERT INTO Borrow VALUES (201, 'ANIL', 'VRCE', 1000),
						  (206, 'MEHUL', 'AJNI', 5000),
						  (311, 'SUNIL', 'DHARAMPETH', 3000),
						  (321, 'MADHURI', 'ANDHERI', 2000),
						  (375, 'PRAMOD', 'VIRAR', 8000),
						  (481, 'KRANTI', 'NEHRU PLACE', 3000)

SELECT * FROM Borrow

--1. List Names of Customers who are Depositors and have Same Branch City as that of SUNIL

SELECT D.Cname AS 'Customers' 
FROM Deposit D JOIN Branch B 
	ON D.Bname = B.Bname 
WHERE B.City = (SELECT B1.City FROM Branch B1 JOIN Deposit D1 ON B1.Bname = D1.Bname WHERE D1.Cname = 'SUNIL') AND D.Cname != 'SUNIL'

--2. List All the Depositors Having Deposit in All the Branches where SUNIL is Having Account

SELECT D.Cname AS 'Depositors', D.Bname AS 'Branch Name'
FROM Deposit D 
WHERE D.Bname IN (SELECT D1.Bname FROM Deposit D1 WHERE D1.Cname = 'SUNIL') 
OR D.Bname IN (SELECT B.Bname FROM Borrow B WHERE B.Cname = 'SUNIL') 

--3. List the Names of Customers Living in the City where the Maximum Number of Depositors are Located

SELECT Cname AS 'Customer', City 
FROM Customer 
WHERE City IN (SELECT City 
			   FROM (SELECT DENSE_RANK() OVER(ORDER BY COUNT(C1.City) DESC) AS 'Rank', C1.City, COUNT(C1.City) AS 'Occurrence' 
					 FROM Deposit D JOIN Customer C1 ON D.Cname = C1.Cname 
					 GROUP BY C1.City) temp
			   WHERE Rank = 1)

--4. List Names of Borrowers Having Deposit Amount Greater than 1000 and Loan Amount Greater than 2000

SELECT B.Cname 
FROM Borrow B JOIN Deposit D ON B.Cname = D.Cname 
WHERE D.Amount > 1000 AND B.Amount > 2000

--5. List All the Customers Living in NAGPUR and Having the Branch City as MUMBAI or DELHI

SELECT C.Cname AS 'Customers'
FROM ((((Customer C 
	 LEFT JOIN Deposit D ON C.Cname = D.Cname)
	 LEFT JOIN Borrow B ON C.Cname = B.Cname)
	 LEFT JOIN Branch Br1 ON D.Bname = Br1.Bname)
	 LEFT JOIN Branch Br2 ON B.Bname = Br2.Bname)
WHERE C.City = 'NAGPUR' AND (Br1.City IN ('MUMBAI', 'DELHI') OR Br2.City IN ('MUMBAI', 'DELHI'))

--6. Count the Number of Customers Living in the City where Branch is Located

SELECT COUNT(DISTINCT C.Cname) AS 'Customers', C.City 
FROM Customer C JOIN Branch B ON C.City = B.City 
WHERE C.City = B.City 
GROUP BY C.City
ORDER BY Customers DESC