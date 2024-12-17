--Soal 1:
--Buat stored procedure bernama GetEmployeeDetails yang menerima parameter @DepartmentID dan @MinSalary. Stored procedure ini harus mengembalikan semua karyawan dari departemen tertentu yang gajinya lebih besar atau sama dengan @MinSalary.
--Jalankan stored procedure tersebut dengan parameter @DepartmentID = 5 dan @MinSalary = 5000

CREATE PROCEDURE GetEmployeeDetailsFaisya 
	@DepartmentID INT,
	@MinSalary INT
AS
BEGIN 
	SELECT * FROM Employees WHERE DepartmentID = @DepartmentID AND Salary >= @MinSalary
END;

EXEC GetEmployeeDetailsFaisya @DepartmentID = 5, @MinSalary = 5000;


-- Soal 2:

-- Berikan hak akses SELECT ke tabel Employees kepada pengguna User_A.
-- Berikan hak akses EXECUTE untuk stored procedure GetEmployeeDetails kepada pengguna User_B.
-- Cabut hak akses SELECT dari pengguna User_A.

GRANT SELECT ON Employees TO User_A;
GRANT EXECUTE ON GetEmployeeDetailsFaisya TO User_B;
REVOKE SELECT ON Employees FROM User_A;

-- Soal 3:

-- Buat clustered index pada kolom EmployeeID di tabel Employees.
-- Buat non-clustered index pada kolom Salary.
-- Tunjukkan bagaimana query berikut menggunakan indeks untuk mempercepat pencarian data berdasarkan gaji:
-- SELECT EmployeeID, Name, Salary FROM Employees WHERE Salary > 8000;

CREATE CLUSTERED INDEX ix_EmployeeID ON Employees(EmployeeID);
CREATE NONCLUSTERED INDEX ix_Salary ON Employees(Salary);
SELECT EmployeeID, Name, Salary FROM Employees WHERE Salary > 8000;


-- Soal 4:

-- Buat stored procedure UpdateEmployeeSalary yang menerima @EmployeeID dan @NewSalary, kemudian memperbarui gaji karyawan yang sesuai.
-- Jalankan stored procedure tersebut untuk memperbarui gaji karyawan dengan EmployeeID = 100 menjadi 7500.
-- Tambahkan non-clustered index pada kolom JobTitle dan optimalkan query berikut menggunakan indeks:
-- SELECT EmployeeID, Name FROM Employees WHERE JobTitle = 'Manager';

CREATE PROCEDURE UpdateEmployeeSalaryFaisya 
    @EmployeeID INT,
    @NewSalary DECIMAL
AS
BEGIN 
    UPDATE Employees SET Salary = @NewSalary WHERE EmployeeID = @EmployeeID
END;

EXEC UpdateEmployeeSalaryFaisya @EmployeeID = 100, @NewSalary = 7500;

CREATE NONCLUSTERED INDEX IX_JobTitle ON Employees(JobTitle)



