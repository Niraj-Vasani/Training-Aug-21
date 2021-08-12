CREATE TABLE Countries
(
	CountryId TINYINT IDENTITY(1,1),
	CountryName VARCHAR(5) NOT NULL CHECK(CountryName IN ('India','Italy','China')),
	RegionId SMALLINT,
	PRIMARY KEY (CountryId, RegionId)
);

INSERT INTO Countries VALUES ('India', 1), ('INDIA', 25), ('india', 8), ('InDiA', 5), ('China', 2), ('Italy', 3);

SELECT * FROM Countries;