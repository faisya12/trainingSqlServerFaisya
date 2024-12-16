1. Agregasi dengan Fungsi String
Soal:
Gabungkan semua nama karyawan dalam satu departemen.

SELECT 
    UPPER(SUBSTRING(NamaKaryawan, 3, 3)) + '-ACTIVE' AS Hasil
FROM Karyawan
WHERE LEN(NamaKaryawan) > 5;


2. Konversi Format Tanggal
Soal:
Tampilkan TanggalTransaksi dalam format DD-MMM-YYYY HH:MM:SS AM/PM dan hitung jumlah hari hingga tanggal saat ini.

SELECT 
    FORMAT(TanggalTransaksi, 'dd-MMM-yyyy hh:mm:ss') as format ,
    DATEDIFF(DAY, TanggalTransaksi, '2024-12-16') AS hitung
FROM Transaksi


3. Kalkulasi dengan Fungsi Waktu
Soal:
Hitung total jam kerja setiap karyawan dalam format XX jam YY menit.

select NamaKaryawan, CONCAT(DATEDIFF(HOur, JamMasuk, JamKeluar),'jam',DATEDIFF(MINUTE, JamMasuk, JamKeluar)%60,'menit') from Presensi



