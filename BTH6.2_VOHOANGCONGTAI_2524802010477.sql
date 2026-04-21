--1. Tạo View hiển thị danh sách khách hàng có doanh số > 1 triệu, gồm MAKH, HOTEN, DOANHSO.
CREATE VIEW VW_DSKH
AS
SELECT MAKH, HOTEN, DOANHSO
FROM KHACHHANG
WHERE DOANHSO > 1000000
SELECT*FROM VW_DSKH
--2. Tạo View hiển thị hóa đơn có trị giá > 2 triệu, gồm SOHD, NGHD, MAKH, MANV, TRIGIA.
CREATE VIEW VW_HTHD
AS
SELECT SOHD, NGAYMUA AS NGHD, MAKH, MANV, TRIGIA
FROM HOADON
WHERE TRIGIA > 2000000
SELECT*FROM VW_HTHD
--3. Tạo View hiển thị chi tiết hóa đơn gồm. SOHD, MASP, TENSP, SL, GIA, THÀNH TIỀN.

--4. Tạo View hiển thị sản phẩm sản xuất tại “Việt Nam” có giá > 20.000.
CREATE VIEW VW_SX_VietNam 
AS
SELECT *
FROM SANPHAM
WHERE NUOCSX = 'VIETNAM'
AND GIA > 20000;
SELECT*FROM VW_SX_VietNam 
--5. Tạo View hiển thị nhân viên vào làm trước năm 2005.
CREATE VIEW VW_NVLAMVIECTRUOC2005 AS
SELECT *
FROM NHANVIEN
WHERE YEAR(NGVL) < 2005;
SELECT*FROM VW_NVLAMVIECTRUOC2005
--6. Tạo View thống kê số lượng sản phẩm bán ra theo từng mã sản phẩm.
CREATE VIEW VW_KH_2006 AS
SELECT *
FROM KHACHHANG
WHERE YEAR(NGDK) = 2006;
SELECT*FROM VW_KH_2006
--7. Tạo View hiển thị khách hàng đăng ký thành viên trong năm 2006.

--8. Tạo View hiển thị hóa đơn và tên khách hàng tương ứng.

--9. Tạo View hiển thị tổng trị giá các hóa đơn theo từng khách hàng.

--10. Tạo View hiển thị sản phẩm chưa từng xuất hiện trong bảng CTHD.
