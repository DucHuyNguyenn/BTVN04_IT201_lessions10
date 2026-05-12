-- tạo database
CREATE DATABASE pharmacy_management_db;
USE pharmacy_management_db;



-- =====================================================
-- tạo bảng kho dược phẩm
-- =====================================================

CREATE TABLE Pharmacy_Inventory (
    Inventory_ID INT PRIMARY KEY AUTO_INCREMENT,
    Drug_Name VARCHAR(100),
    Batch_Number VARCHAR(50),
    Expiry_Date DATE,
    Quantity INT
);



-- =====================================================
-- dữ liệu mẫu
-- =====================================================

INSERT INTO Pharmacy_Inventory
(Drug_Name, Batch_Number, Expiry_Date, Quantity)
VALUES
('Paracetamol', 'PAR001', '2026-01-15', 500),
('Paracetamol', 'PAR002', '2025-11-20', 300),
('Amoxicillin', 'AMX001', '2025-09-10', 200),
('Vitamin C', 'VTM001', '2026-05-01', 700),
('Ibuprofen', 'IBU001', '2025-08-18', 150);



-- =====================================================
-- query trước khi tạo index
-- =====================================================

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol'
AND Expiry_Date = '2025-11-20';



-- =====================================================
-- tạo 2 index đơn lẻ
-- =====================================================

CREATE INDEX idx_drug_name
ON Pharmacy_Inventory(Drug_Name);

CREATE INDEX idx_expiry_date
ON Pharmacy_Inventory(Expiry_Date);



-- =====================================================
-- test query với index đơn
-- =====================================================

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol'
AND Expiry_Date = '2025-11-20';



-- =====================================================
-- xóa index đơn
-- =====================================================

DROP INDEX idx_drug_name
ON Pharmacy_Inventory;

DROP INDEX idx_expiry_date
ON Pharmacy_Inventory;



-- =====================================================
-- tạo composite index
-- =====================================================

CREATE INDEX idx_drug_expiry
ON Pharmacy_Inventory(Drug_Name, Expiry_Date);



-- =====================================================
-- test query với composite index
-- =====================================================

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol'
AND Expiry_Date = '2025-11-20';



-- =====================================================
-- kiểm tra LIKE
-- =====================================================

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name LIKE '%mol%';



-- =====================================================
-- LIKE tối ưu hơn
-- =====================================================

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name LIKE 'Para%';



