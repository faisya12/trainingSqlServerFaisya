--1.Buatlah sebuah CTE untuk menghitung total penjualan bulanan dari tabel Sales dan mencari bulan dengan total penjualan tertinggi. Tampilkan kolom:
--Bulan
--Total Penjualan Bulanan
--Indikasi apakah bulan tersebut memiliki penjualan tertinggi ("Ya" atau "Tidak").
WITH SalesCTE AS (
	SELECT FORMAT(SaleDate, 'yyyy-MMM') as Bulan, sum(Amount) as totalPenjualan
	FROM Sales
	GROUP BY FORMAT(SaleDate, 'yyyy-MMM')
)



SELECT 
	Bulan,
	totalPenjualan,
	CASE 
		WHEN totalPenjualan = (SELECT TOP 1 totalPenjualan FROM SalesCTE ORDER BY totalPenjualan DESC) THEN 'Ya'
		ELSE 'Tidak'
	END as IndikasiPenjualanTertinggi
FROM SalesCTE
GROUP BY Bulan, totalPenjualan
	
	

--2.Buatlah sebuah query untuk menghitung total penjualan per karyawan, termasuk hanya karyawan yang memiliki penjualan lebih besar dari rata-rata semua penjualan.

