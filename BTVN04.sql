-- tạo database
CREATE DATABASE pharmacy_management_db;
USE pharmacy_management_db;



-- tạo bảng
CREATE TABLE Pharmacy_Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    drug_name VARCHAR(100) NOT NULL,
    batch_number VARCHAR(50) NOT NULL,
    expiry_date DATE NOT NULL,
    quantity INT NOT NULL DEFAULT 0
);



-- dữ liệu mẫu
INSERT INTO Pharmacy_Inventory
(drug_name, batch_number, expiry_date, quantity)
VALUES
('Paracetamol', 'PAR001', '2026-01-15', 500),
('Paracetamol', 'PAR002', '2025-11-20', 300),
('Amoxicillin', 'AMX001', '2025-09-10', 200),
('Vitamin C', 'VTM001', '2026-05-01', 700),
('Ibuprofen', 'IBU001', '2025-08-18', 150);



-- query trước khi tạo index
EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE drug_name = 'Paracetamol'
AND expiry_date = '2025-11-20';



-- tạo index đơn
CREATE INDEX idx_drug_name
ON Pharmacy_Inventory(drug_name);

CREATE INDEX idx_expiry_date
ON Pharmacy_Inventory(expiry_date);



-- test query với index đơn
EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE drug_name = 'Paracetamol'
AND expiry_date = '2025-11-20';



-- xóa index đơn
DROP INDEX idx_drug_name
ON Pharmacy_Inventory;

DROP INDEX idx_expiry_date
ON Pharmacy_Inventory;



-- tạo composite index
CREATE INDEX idx_drug_expiry
ON Pharmacy_Inventory(drug_name, expiry_date);



-- test composite index
EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE drug_name = 'Paracetamol'
AND expiry_date = '2025-11-20';



-- like không tối ưu
EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE drug_name LIKE '%mol%';



-- like tối ưu hơn
EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE drug_name LIKE 'Para%';



-- kiểm tra index
SHOW INDEX
FROM Pharmacy_Inventory;