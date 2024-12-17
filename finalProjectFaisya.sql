
--TUGAS 1--
--CREATE DB PerusahaanDBFaisya
--CREATE TABLE Employees (
--     EmployeeID INT PRIMARY KEY,
--     FirstName VARCHAR(50),
--     LastName VARCHAR(50),
--     DepartmentID INT FK reference Departments,
--     Salary MONEY,
--     HireDate DATE,
-- )

--NO 1 --
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary MONEY,
    HireDate DATE
)
-- create Departments (DepartmentID INT PK, DepartmentName VARCHAR(50), ManagerID INT)

CREATE TABLE Departments (
    DepartmentID INT  IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(50),
    ManagerID INT
)
-- Salary (SalaryID INT PK, Employee ID FK reference Employees, Amount MONEY, SalaryDate DATE)

CREATE TABLE Salaries (
    SalaryID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    Amount MONEY,
    SalaryDate DATE
)
-- Sales(SaleID INT PK, Employee ID FK reference Employees, SaleAmount MONEY, SaleDate DATE)

CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    SaleAmount MONEY,
    SaleDate DATE
)

--NO 2 WRITE QUERY INSERT TO EVERY TABLE

INSERT INTO EMPLOYEES(FirstName, LastName, DepartmentID, Salary, HireDate)
VALUES 
('Faisya', 'Syafadilla', 1, 5000000, '2024-01-01'),
('Adel', 'Putri', 2, 6000000, '2024-01-01'),
('Ica', 'Caca', 3, 7000000, '2024-01-01')

INSERT INTO Departements (DepartmentName, ManagerID)
VALUES
('IT', 1),
('Sales', 2),
('HR', 3)

INSERT INTO Salaries (EmployeeID, Amount, SalaryDate)
VALUES 
(1, 5000000, '2024-02-01'),
(2, 6000000, '2024-02-01'),
(3, 7000000, '2024-02-01')

INSERT INTO Sales (EmployeeID, SaleAmount, SaleDate)
VALUES 
(1, 500000, '2024-03-01'),
(2, 600000, '2024-03-02'),
(3, 700000, '2024-03-03')



--NO 3 SELECT CONCAT FIRSTNAME AND LASTNAME, LAMA KERJA
SELECT CONCAT (FirstName, ' ', LastName) AS FullName, DATEDIFF(DAY, HireDate, GETDATE()) AS LamaKerja FROM Employees



--TUGAS 2--

--no1 nama belakang dari huruf P--
SELECT * FROM Employees WHERE LastName LIKE 'P%'

--no2--
SELECT 
    FirstName,
    CASE
        WHEN Salary < 5000000 THEN 'Low'
        WHEN Salary BETWEEN 5000000 AND 10000000 THEN 'Medium'
        ELSE 'High'
    END AS SalaryCategory
FROM Employees

--no3--
SELECT 
	FirstName,
	Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees)



--TUGAS 3--

--no1--
--TEMPORARY TABLE--
SELECT * INTO #TemporaryEmployee
FROM Employees
WHERE DepartmentID = 1

--no2 total gaji per department--
WITH totalGajiCTE AS (
    SELECT SUM(e.Salary) AS TotalGaji, e.DepartmentID, d.DepartmentName
    FROM Employees e
    JOIN Departments d on e.DepartmentID = d.DepartmentID
    GROUP BY e.DepartmentID, d.DepartmentName
)
SELECT * FROM totalGajiCTE


--TUGAS 4--

--no1--
BEGIN TRANSACTION
	DECLARE @DepartmentID INT = 2;
	
	UPDATE Employees SET Salary = Salary + 0.05 * Salary WHERE DepartmentID = @DepartmentID
	
IF @@ERROR <> 0
	ROLLBACK
ELSE
	COMMIT

	

--no2--


--TUGAS 5--

--no1--
--update Employees
BEGIN TRANSACTION
	DECLARE @EmployeeID INT = 1;
	
	UPDATE Employees SET Salary = Salary + 1000000 WHERE EmployeeID = @EmployeeID
	
IF @@ERROR <> 0
	ROLLBACK
ELSE
	COMMIT

--update Sales
BEGIN TRANSACTION
	DECLARE @SaleID INT = 1;
	
	UPDATE Sales SET SaleAmount = SaleAmount + 1000000 WHERE SaleID = @SaleID
	
IF @@ERROR <> 0
	ROLLBACK
ELSE
	COMMIT

--TUGAS 6--
CREATE PROCEDURE totalPenjualanKaryawanFaisya
	@EmployeeID INT
AS
BEGIN 
	SELECT 
		EmployeeID,
		SUM(SaleAmount) as totalSales
	INTO EmployeeSales
	FROM Sales
	WHERE EmployeeID = @EmployeeID
	GROUP BY EmployeeID
END;

EXEC totalPenjualanKaryawanFaisya @EmployeeID = 2;

--no2--
CREATE TRIGGER trg_AfterSalaryUpdateNew
ON Salaries
AFTER UPDATE 
AS
BEGIN
	INSERT INTO SalaryAudit (SalaryID, NewAmount, OldAmount, ChangeDate )
	SELECT i.SalaryID, i.Amount, d.Amount, GETDATE()
	FROM inserted i
	JOIN deleted d ON i.SalaryID = d.SalaryID;
END;


--TUGAS 7--
--no1--
CREATE LOGIN SalesUser WITH PASSWORD = 'Password123';
CREATE USER SalesUser FOR LOGIN SalesUser;

GRANT SELECT ON Sales TO SalesUser;

CREATE LOGIN User_A WITH PASSWORD = 'Password123';
CREATE USER User_A FOR LOGIN User_A;

--no2--
CREATE ROLE Manager;
GRANT SELECT, UPDATE ON Employee, Salaries TO Manager;

EXEC sp_addrolemember 'Manager', 'User_A';

--no3--
GRANT SELECT ON Employees TO Manager;
