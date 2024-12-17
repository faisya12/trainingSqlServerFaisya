-- 1.Dirty Read Buat transaksi yang menunjukkan data dibaca sebelum di-commit oleh transaksi lain.
-- begin transaction dengan teknik dirty read, ngga di commit tapi di rollback, update dari table order set statusnya processing, where order id terserah

--TRANSAKSI 1: UPDATE TANPA COMMIT
BEGIN TRANSACTION
    UPDATE Orders SET Status = 'Processing' WHERE OrderID = 1

--TRANSAKSI 2: MEMBACA DATA TANPA COMMIT
SET TRANSACTION ISOLATION LEVEL 
READ UNCOMMITTED
BEGIN TRANSACTION
    SELECT * FROM Orders

--ROLLBACK PERUBAHAN
ROLLBACK

-- 2. Non-repeatable Read Tunjukkan perbedaan hasil baca karena transaksi lain melakukan perubahan.

--TRANSAKSI 1: MEMBACA DATA PERTAMA KALI
SET TRANSACTION ISOLATION LEVEL
READ COMMITTED
BEGIN TRANSACTION
    SELECT * FROM Orders WHERE OrderID = 1

--TRANSAKSI 2: UPDATE DATA
BEGIN TRANSACTION
    UPDATE Orders SET Status = 'Shipped' WHERE OrderID = 1
COMMIT;

--TRANSAKSI 3: Membaca data kedua kali
SELECT * FROM Orders WHERE OrderID = 1
ROLLBACK

-- 3. Phantom Read Demonstrasikan transaksi yang membaca hasil berbeda karena ada penyisipan data oleh transaksi lain.


-- 4. Serializable Tunjukkan isolasi penuh sehingga transaksi lain tidak dapat menyisipkan data pada rentang yang sedang diakses.

-- 5. Snapshot Tunjukkan bagaimana snapshot isolation memberikan konsistensi tanpa mengunci data.

