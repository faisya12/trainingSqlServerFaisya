-- 1. Membuat Pengguna dan Memberikan Izin Dasar
-- Tugas:

-- Buat tiga pengguna: User_A, User_B, dan Manager.
CREATE LOGIN User_A WITH PASSWORD = 'Password123';
CREATE LOGIN User_B WITH PASSWORD = 'Password123';
CREATE LOGIN Manager WITH PASSWORD = 'Password123';

-- Berikan User_A izin SELECT pada tabel Penjualan.
GRANT SELECT ON Penjualan TO User_A;

-- Tambahkan User_B ke peran khusus TimPenjualan dengan izin SELECT pada tabel Penjualan.
CREATE ROLE TimPenjualan;
GRANT SELECT ON Penjualan TO TimPenjualan;

EXEC sp_addrolemember 'TimPenjualan', 'User_B';

-- Berikan Manager izin SELECT dan UPDATE pada tabel Penjualan.
GRANT SELECT, UPDATE ON Penjualan TO Manager;

-- 2. Menerapkan DENY (Tolak) Izin
-- Tugas:

-- Tolak izin DELETE pada tabel Penjualan untuk User_A.
DENY DELETE ON Penjualan TO User_A;


-- 3. Mencabut Izin dengan REVOKE
-- Tugas:

-- Cabut izin SELECT dari User_A pada tabel Penjualan.



-- 4. Menggunakan Peran Tetap di Database
-- Tugas:

-- Berikan User_B peran db_datareader untuk database ini.




-- 5. Membuat dan Mengelola Peran Khusus
-- Tugas:

-- Buat peran khusus AksesBacaSaja dan berikan izin SELECT pada semua tabel dalam database.




-- 6. Audit Izin Pengguna
-- Tugas:

-- Tampilkan laporan semua pengguna dan perannya di database ini.



-- 7. Konfigurasi Akses Minimum (Least Privilege)
-- Skenario:
-- Administrator database ingin memastikan bahwa User_B hanya dapat membaca dan memperbarui data pada tabel Penjualan jika Total penjualannya kurang dari 500.

-- Solusi:

-- Buat peran baru dan beri izin SELECT dan UPDATE dengan filter tingkat baris.
