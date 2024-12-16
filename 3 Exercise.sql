-- 1. Subquery: Tampilkan nama produk dan kategori untuk produk yang memiliki harga lebih tinggi daripada rata-rata harga semua produk.
SELECT * FROM Produk WHERE Harga > (SELECT AVG(Harga) FROM Produk)

-- 2. Conditional Expression: Tambahkan kolom Ketersediaan (Virtual Column) untuk menampilkan status produk:
-- Tersedia jika stok lebih dari 10.
-- Habis jika stok 0.
-- Terbatas untuk stok antara 1 hingga 10.
SELECT 
	NamaProduk,
	Kategori,
	Harga,
	Stok,
	TanggalDitambahkan,
	CASE 
		WHEN Stok > 10 THEN 'Tersedia'
		WHEN Stok = 0 THEN 'Habis'
		WHEN Stok >= 1 AND Stok <= 10 THEN 'Terbatas'
	END as Ketersediaan
FROM Produk
	

-- 3. Subquery dan Join: Tampilkan nama produk, kategori, jumlah terjual untuk semua transaksi.
SELECT pr.NamaProduk, pr.Kategori, pen.Jumlahterjual
FROM Produk pr
JOIN Penjualan pen on pr.ProdukID = pen.ProdukID

-- 4. Analisis Conditional Expression: Hitung total pendapatan per kategori. 
SELECT Kategori, sum(Totalpendapatan) as totalPendapatanKategori FROM (
	SELECT pr.Kategori, (pr.Harga*pen.Jumlahterjual) as Totalpendapatan
	FROM Produk pr
	JOIN Penjualan pen on pr.ProdukID = pen.ProdukID
) temp
group by temp.Kategori











