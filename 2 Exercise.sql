--1. Cari nama belakang "Doe":
SELECT * FROM Employees WHERE FullName LIKE '%Doe'

--2. Cari JobTitle yang mengandung "Developer":
SELECT * FROM Employees WHERE JobTitle LIKE '%Developer%'

--3. Cari email yang diakhiri "example.com":
SELECT * FROM Employees WHERE Email LIKE '%example.com'

--4. Temukan semua produk yang memiliki kata pertama "Laptop" di ProductName.
SELECT * FROM Products WHERE ProductName LIKE 'Laptop%'

--5. Cari produk dengan nama yang dimulai dengan huruf "S".
SELECT * FROM Products WHERE ProductName LIKE 'S%'

--6. Temukan produk dengan harga di atas 1000 dan nama mengandung "Pro".
SELECT * FROM Products WHERE ProductName LIKE '%Pro%' AND Price > 1000

--7. Cari pelanggan yang nama depannya dimulai dengan huruf "A" menggunakan LEFT.
SELECT LEFT(FullName,5) FROM Customers WHERE FullName LIKE 'A%'

--8. Cari pelanggan yang memiliki titik (.) dalam alamat email menggunakan CHARINDEX.
SELECT * FROM Customers WHERE CHARINDEX('.', Email) > 0

--9. Cari pelanggan yang nomor teleponnya berisi "1234" menggunakan PATINDEX.
SELECT * FROM Customers WHERE PATINDEX('%1234%', PhoneNumber) > 0

