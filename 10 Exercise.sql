-- Soal 1: Membuat Stored Procedure
-- Buat stored procedure bernama GetTotalSalaryByDepartment yang menghitung total gaji semua karyawan di sebuah departemen.

-- Jalankan stored procedure ini untuk Departemen IT (@DepartmentID = 3)

CREATE PROCEDURE GetTotalSalaryByDepartmentFaisya 
    @DepartmentID INT
AS
BEGIN
    SELECT SUM(Salary) as TotalSalary
    FROM Employees 
    WHERE DepartmentID = @DepartmentID
    GROUP BY DepartmentID
END

EXEC GetTotalSalaryByDepartmentFaisya @DepartmentID = 3


-- Soal 2: Membuat Stored Procedure untuk Update Data
-- Buat stored procedure UpdateEmployeeSalary untuk memperbarui gaji karyawan berdasarkan EmployeeID.

-- Ubah gaji karyawan dengan EmployeeID = 100 menjadi 20.000.000.

CREATE PROCEDURE UpdateEmployeeSalaryFaisya
    @EmployeeID INT,
    @NewSalary DECIMAL
AS
BEGIN
    UPDATE Employees SET Salary = @NewSalary WHERE EmployeeID = @EmployeeID
END

EXEC UpdateEmployeeSalaryFaisya @EmployeeID = 100, @NewSalary = 20000000



-- Soal 3: Membuat Trigger untuk Audit
-- Buat trigger trg_AfterEmployeeUpdate untuk mencatat perubahan gaji ke tabel EmployeeAudit.

-- Ubah gaji karyawan dengan EmployeeID = 200 menjadi 25.000.000 dan periksa tabel EmployeeAudit.

CREATE TRIGGER trg_AfterEmployeeUpdateFaisya
ON Employees
AFTER UPDATE
AS
BEGIN
	INSERT INTO EmployeeAudit (EmployeeID, ChangeDate, OldSalary, NewSalary)
	SELECT i.EmployeeID, GETDATE(), d.Salary, i.Salary
	FROM deleted d
	JOIN inserted i  ON i.EmployeeID = d.EmployeeID
END;

-- Soal 4: Membuat INSTEAD OF Trigger
-- Buat trigger trg_CheckSalary untuk memastikan gaji tidak boleh lebih dari 100 juta.

-- Coba masukkan data karyawan baru dengan gaji 120 juta dan amati error-nya.


CREATE TRIGGER trg_CheckSalaryFaisya
ON Employees 
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	IF EXIST(
		SELECT * FROM inserted WHERE Salary > 100000000
	)
	BEGIN 
		RAISERROR ('Gaji tidak boleh lebih dari 100 juta', 16, 1);
		ROLLBACK TRANSACTION;
	END
	ELSE
	BEGIN
		INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary)
		SELECT EmployeeID, Name, DepartmentID, Salary
		FROM inserted;
	END
END;

-- 3. Gabungan Stored Procedure dan Trigger
-- Buat stored procedure GetHighEarnerEmployees untuk mendapatkan daftar karyawan dengan gaji di atas rata-rata per departemen.

-- Jalankan:

-- Tambahkan trigger trg_AfterEmployeeInsert untuk mencatat data karyawan baru yang ditambahkan ke tabel log khusus.







