/*QUẢN LÍ HÀNG HÓA*/

--7. Tìm những phụ tùng (maPT, tenPt, mausac) có khối lượng lớn hơn 15, màu sắc khác màu đỏ (red) và xanh (green).
SELECT maPT,tenPT,mausac
FROM PHUTUNG
WHERE khoiluong>15
INTERSECT
SELECT maPT,tenPT,mausac
FROM PHUTUNG
WHERE mausac NOT IN ('red','green')

SELECT maPT,tenPT,mausac
FROM PHUTUNG
WHERE khoiluong>15 AND mausac NOT IN('red','green')

--8. Hiển thị những phụ tùng (maPT, tenPT, khối lượng) có khối lượng lớn hơn 15 và nhỏ hơn 20, sắp xếp theo tên phụ tùng.
SELECT maPT,tenPT,khoiluong
FROM PHUTUNG
WHERE khoiluong between 16 and 19
ORDER BY tenPT 

--9. Hiển thị những phụ tùng được vận chuyển bởi nhà cung cấp có mã số S1. Không hiển thị kết quả trùng. (sử dụng phép kết).
SELECT DISTINCT PT.*
FROM PHUTUNG PT JOIN VANCHUYEN VC ON PT.maPT=VC.maPT
WHERE maNCC='S1'

--10. Hiển thị những nhà cung cấp vận chuyển phụ tùng có mã là P1 (sử dụng phép kết).
SELECT DISTINCT NCC.*
FROM NHACUNGCAP NCC JOIN VANCHUYEN VC
ON NCC.maNCC = VC.maNCC
WHERE VC.maPT = 'P1'

--11. Hiển thị thông tin nhà cung cấp ở thành phố London và có vận chuyển phụ tùng của thành phố London. Không hiển thị kết quả trùng. (Sử dụng phép kết)
SELECT DISTINCT NCC*
FROM (NHACUNGCAP NCC JOIN VANCHUYEN VC ON NCC.maNCC=VC.maNCC) JOIN PHUTUNG PT ON PT.maPT=VC.maPT
WHERE NCC.thanhpho='London' AND PT.thanhpho='London'

--12. Lặp lại câu 9 nhưng sử dụng toán tử IN.
SELECT*
FROM PHUTUNG PT
WHERE maPT IN (SELECT VC.maPT
               FROM VANCHUYEN VC
			   WHERE VC.maNCC='S1')

--13. Lặp lại câu 10 nhưng sử dụng toán tử IN
SELECT *
FROM Nhacungcap NCC
WHERE maNCC IN (SELECT maNCC
                FROM Vanchuyen VC
                WHERE VC.maPT='P1')

--14. Lặp lại câu 9 nhưng sử dụng toán tử EXISTS
SELECT DISTINCT*
FROM PHUTUNG PT
WHERE EXISTS (SELECT *
              FROM VANCHUYEN VC
			  WHERE VC.maNCC=PT.maPT AND VC.maNCC='S1')

--15. Lặp lại câu 10 nhưng sử dụng toán tử EXISTS
SELECT *
FROM NHACUNGCAP NCC
WHERE EXISTS (SELECT *
              FROM VANCHUYEN VC
              WHERE VC.maNCC=NCC.maNCC AND VC.maPT='P1')

--16. Lặp lại câu 11 nhưng sử dụng truy vấn con. Sử dụng toán tử IN.
SELECT DISTINCT*
FROM NHACUNGCAP NCC
WHERE NCC.thanhpho='London' AND NCC.maNCC IN (SELECT maNCC
                                              FROM VANCHUYEN VC JOIN PHUTUNG PT 
											  ON VC.maPT=PT.maPT
				                              WHERE PT.thanhpho='London')
									
--17. Lặp lại câu 11 nhưng dùng truy vấn con. Sử dụng toán tử EXISTS.
SELECT DISTINCT*
FROM NHACUNGCAP NCC
WHERE NCC.thanhpho='London' AND EXISTS (SELECT *
                                        FROM VANCHUYEN VC JOIN PHUTUNG PT 
									    ON VC.maPT=PT.maPT
				                        WHERE PT.thanhpho='London'
										AND VC.maPT=PT.maPT
										AND NCC.maNCC=VC.maNCC)

--18. Tìm nhà cung cấp chưa vận chuyển bất kỳ phụ tùng nào. Sử dụng NOT IN.
SELECT*
FROM NHACUNGCAP NCC
WHERE maNCC NOT IN (SELECT VC.maNCC
                    FROM VANCHUYEN VC)

--19. Tìm nhà cung cấp chưa vận chuyển bất kỳ phụ tùng nào. Sử dụng NOT EXISTS.
SELECT*
FROM NHACUNGCAP NCC
WHERE NOT EXISTS (SELECT VC.maNCC
                  FROM VANCHUYEN VC
			      WHERE VC.maNCC=NCC.maNCC)

--20. Tìm nhà cung cấp chưa vận chuyển bất kỳ phụ tùng nào. Sử dụng outer JOIN (Phép kết ngoài)
SELECT*
FROM NHACUNGCAP NCC LEFT JOIN VANCHUYEN VC
ON NCC.maNCC=VC.maNCC
WHERE VC.maPT IS NULL




/*QUẢN LÍ BÁN HÀNG*/

--14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT DISTINCT SP.MASP, SP.TENSP
FROM (SANPHAM SP LEFT JOIN CTHD ON SP.MASP=CTHD.MASP) LEFT JOIN HOADON HD ON CTHD.SOHD=HD.SOHD
WHERE SP.NUOCSX='Trung Quoc' OR HD.NGHD='01/01/2007'

SELECT DISTINCT SP.MASP, SP.TENSP
FROM SANPHAM SP, HOADON HD, CTHD
WHERE SP.MASP=CTHD.MASP AND HD.SOHD=CTHD.SOHD AND NGHD='1/1/2007'
UNION
SELECT DISTINCT SP.MASP, TENSP
FROM SANPHAM SP
WHERE NUOCSX='Trung Quoc'

--15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT MASP,TENSP
FROM SANPHAM
EXCEPT
SELECT SP.MASP,TENSP
FROM SANPHAM SP, CTHD
WHERE CTHD.MASP=SP.MASP

SELECT MASP,TENSP
FROM SANPHAM
EXCEPT
SELECT SP.MASP,TENSP
FROM SANPHAM SP JOIN CTHD ON CTHD.MASP=SP.MASP

--16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT MASP,TENSP
FROM SANPHAM
EXCEPT
SELECT SP.MASP,TENSP
FROM SANPHAM SP, CTHD, HOADON HD
WHERE CTHD.MASP=SP.MASP AND HD.SOHD=CTHD.SOHD AND YEAR(NGHD)=2006

--17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT MASP,TENSP
FROM SANPHAM
WHERE NUOCSX='Trung Quoc'
EXCEPT
SELECT SP.MASP,TENSP
FROM SANPHAM SP, CTHD, HOADON HD
WHERE CTHD.MASP=SP.MASP AND HD.SOHD=CTHD.SOHD AND YEAR(NGHD)=2006 AND NUOCSX='Trung Quoc'

--18. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT SOHD
FROM HOADON
WHERE NOT EXISTS
      (SELECT *
       FROM SANPHAM
       WHERE NUOCSX='Singapore' AND MASP NOT IN (SELECT MASP
                                                 FROM CTHD
                                                 WHERE CTHD.SOHD=HOADON.SOHD))