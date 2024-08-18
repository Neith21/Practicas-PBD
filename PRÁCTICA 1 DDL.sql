CREATE DATABASE CompanyDB;
GO
USE CompanyDB;
GO

--CREATE Y ALTER
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL
);
GO

ALTER TABLE Employees ADD Salary DECIMAL(18,2) CHECK (salary >= 0);
GO
INSERT INTO Employees (FirstName, LastName, Salary) VALUES ('Juan', 'Rodríguez', 300);
GO
SELECT * FROM Employees
GO

--USAR RENAME y DROP, cambiar de lado una columna.
CREATE TABLE Employees_New(
	EmployeeID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Salary DECIMAL(18,2) CHECK (salary >= 0),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL
);
GO

SET IDENTITY_INSERT Employees_New ON;
GO

INSERT INTO Employees_New(EmployeeID, Salary, FirstName, LastName)
SELECT EmployeeID, Salary, FirstName, LastName
FROM Employees;
GO

SET IDENTITY_INSERT Employees_New OFF;
GO
DROP TABLE Employees;
GO
EXEC sp_rename 'Employees_New', 'Employees';
GO
SELECT * FROM Employees;
GO

--Insertar llave Foranea
CREATE TABLE Country(
	CountryID INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	Country NVARCHAR(50) NOT NULL,
	LastModified DATE DEFAULT GETDATE()
);
GO

INSERT INTO Country(Country) VALUES ('El Salvador');
GO
SELECT * FROM Country;
GO

ALTER TABLE Employees ADD CountryID INT

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Country
FOREIGN KEY (CountryID) REFERENCES Country(CountryID);
GO

--Eliminar llave foranea
ALTER TABLE Employees
DROP CONSTRAINT FK_Employees_Country;
GO

ALTER TABLE Employees
DROP COLUMN CountryID;

--TRUNCATE
SELECT * FROM Employees;

DELETE FROM Employees;

TRUNCATE TABLE Employees; --No activa triggers y reinicia el identity
