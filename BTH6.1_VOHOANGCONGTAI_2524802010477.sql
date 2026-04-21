USE QL_Sinh_Vien
--1 Tạo View hiển thị danh sách sinh viên của lớp CNTT01 (các cột. MaSV, HoTen, MaLop).
CREATE VIEW VW_SV_CKT2A 
AS
SELECT MaSV, HoDem, MaLop
FROM SINHVIEN
WHERE MaLop = 'CKT2A';
--2. Tạo View hiển thị sinh viên có điểm trung bình ≥ 7.0 (các cột. MaSV, HoTen, DiemTB).
CREATE VIEW VW_SV_DTBL1
AS
SELECT MaSV, DTB = AVG(DiemLan1)
FROM KETQUA
GROUP BY MaSV 
HAVING AVG(DiemLan1) >= 7
--3. Sửa View ở 2 để điều kiện thành điểm trung bình ≥ 8.0.
ALTER VIEW VW_SV_DTBL1 
AS
SELECT MaSV, DTB = AVG(DiemLan1)
FROM KETQUA
GROUP BY MaSV 
HAVING AVG(DiemLan1) >= 8
--4. Xóa View ở 2.
DROP VIEW VW_SV_DTBL1
SELECT MaSV, DTB = AVG(DiemLan1)
FROM KETQUA
GROUP BY MaSV 
HAVING AVG(DiemLan1) >= 8
--PHẦN INDEX
--5. Tạo View hiển thị danh sách môn học và số lượng sinh viên đăng ký (các cột. MaMH, TenMH, SoLuongSV).
SELECT MaMH, TenMH, SoLuongSV
FROM SINHVIEN
--6. Tạo Index trên cột HoTen của bảng SINHVIEN để tăng tốc độ tìm kiếm theo tên.
SET STATISTICS TIME ON
SELECT*
FROM SINHVIEN 
WHERE Ten LIKE 'H%'
CREATE INDEX idx_TENSV ON SINHVIEN(Ten)
--7. Tạo Unique Index trên cột Email của bảng SINHVIEN để đảm bảo không trùng email.
SELECT *
FROM SINHVIEN

--8. Tạo Composite Index trên cặp cột (MaLop, QueQuan) để tối ưu truy vấn tìm sinh viên theo lớp và quê quán.
SELECT MaLop, DiaChi
FROM SINHVIEN
WHERE DiaChi LIKE ''
AND MaLop = 'CKT2A';
--9. Thực hiện truy vấn SELECT * FROM SINHVIEN WHERE HoTen = 'Nguyen Van A' trước và sau khi tạo Index để so sánh tốc độ.

--10. Xóa Index đã tạo ở 6 và quan sát sự khác biệt khi truy vấn lại.
 
