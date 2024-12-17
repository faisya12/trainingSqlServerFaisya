--Soal 
--1.Pencarian Kamar yang Tersedia Tampilkan semua kamar yang saat ini tersedia untuk dipesan.
--rooms
SELECT * FROM Rooms WHERE Status = 'Available'

--2.Laporan Pemesanan Per Pelanggan Tampilkan laporan daftar pemesanan untuk setiap pelanggan, termasuk nama pelanggan, jenis kamar, tanggal check-in, dan tanggal check-out.
--booking,  join cust, join rooms
SELECT c.FullName, r.RoomType, b.CheckInDate, b.CheckOutDate
FROM Bookings b 
JOIN Customers c on c.CustomerID = b.CustomerID 
JOIN Rooms r on r.RoomID =b.RoomID 

--3.Validasi Ketersediaan Kamar Sebelum Pemesanan Tulis query untuk memeriksa apakah kamar tertentu tersedia pada rentang tanggal tertentu.
--select case when 
--declare room id, check in date, check out date 
--select case when, exist kalo ada "booking" kalo engga "available"
--table booking


BEGIN TRANSACTION
	DECLARE @roomId INT = 1;
	DECLARE @checkInDate DATE = '2024-12-20';
	DECLARE @checkOutDate DATE = '2024-12-25';
	
	SELECT 
		RoomID = @roomId,
		CheckInDate = @checkInDate ,
		CheckOutDate = @checkOutDate ,
		CASE 
			WHEN EXISTS (SELECT 1 FROM Bookings WHERE RoomID = @roomId AND BookingStatus = 'Active' AND ((CheckInDate BETWEEN @checkInDate AND @checkOutDate) OR (@checkOutDate BETWEEN CheckInDate AND CheckOutDate) OR (@checkInDate BETWEEN CheckInDate AND CheckOutDate)) ) THEN 'Not Available'
            ELSE 'Available'
		END AS Ketersediaan
    FROM Bookings

COMMIT;


		
	


