CREATE DATABASE QLHH
USE QLHH

CREATE TABLE NHACUNGCAP
(
    maNCC varchar(5) CONSTRAINT PK_NCC PRIMARY KEY,
	tenNCC varchar(20),
	trangthai numeric(2),
	thanhpho varchar(30),
)

CREATE TABLE PHUTUNG
(
    maPT varchar(5) CONSTRAINT PK_PT PRIMARY KEY,
	tenPT varchar(10),
	mausac varchar(10),
	khoiluong float,
	thanhpho varchar(30)
)

CREATE TABLE VANCHUYEN
(
     maNCC varchar(5),
	 maPT varchar(5),
	 soluong numeric (5),
	 CONSTRAINT PK_VC PRIMARY KEY (maNCC,maPT),
)

ALTER TABLE VANCHUYEN ADD CONSTRAINT FK_VC1 FOREIGN KEY (maNCC) REFERENCES NHACUNGCAP(maNCC)
ALTER TABLE VANCHUYEN ADD CONSTRAINT FK_VC2 FOREIGN KEY(maPT) REFERENCES PHUTUNG(maPT)

insert into Nhacungcap values ('S1','Smith','20','London')
insert into Nhacungcap values ('S2','Jones','10','Paris')
insert into Nhacungcap values ('S3','Blake','30','Paris')
insert into Nhacungcap values ('S4','Clark','20','London')
insert into Nhacungcap values ('S5','Adams','30','Athens')

Insert  into Phutung values  ( 'P1' , 'Nut' , 'Red' , 12.0 , 'London')
Insert  into Phutung values  ( 'P2' , 'Bolt' , 'Green', 17.0 , 'Paris')
Insert  into Phutung values  ( 'P3' , 'Screw' , 'Blue', 17.0 , 'Oslo')
Insert  into Phutung values  ( 'P4' , 'Screw' , 'Red' , 14.0 , 'London')
Insert  into Phutung values  ( 'P5' , 'Cam' , 'Blue' , 12.0 , 'Paris')
Insert  into Phutung values  ( 'P6' , 'Cog' , 'Red' , 19.0 , 'London')

Insert into Vanchuyen values ('S1','P1',300)
Insert into Vanchuyen values ('S1','P2',200)
Insert into Vanchuyen values ('S1','P3',400)
Insert into Vanchuyen values ('S1','P4',200)
Insert into Vanchuyen values ('S1','P5',100)
Insert into Vanchuyen values ('S1','P6',100)
Insert into Vanchuyen values ('S2','P1',300)
Insert into Vanchuyen values ('S2','P2',400)
Insert into Vanchuyen values ('S3','P2',200)
Insert into Vanchuyen values ('S4','P2',200)
Insert into Vanchuyen values ('S4','P4',300)
Insert into Vanchuyen values ('S4','P5',400)

-- Hiển thị thông tin (maNCC, tenNCC, thanhpho) của tất cả nhà cung cấp.
SELECT maNCC,tenNCC,thanhpho
FROM NHACUNGCAP

-- Hiển thị thông tin của tất cả các phụ tùng.
SELECT* FROM PHUTUNG

-- Hiển thị thông tin các nhà cung cấp ở thành phố London.
SELECT*FROM NHACUNGCAP
WHERE thanhpho = 'London'

-- Hiển thị mã phụ tùng, tên và màu sắc của tất cả các phụ tùng ở thành phố Paris.
SELECT maPT, tenPT,mausac
FROM PHUTUNG
WHERE thanhpho = 'Paris'

-- Hiển thị mã phụ tùng, tên, khối lượng của những phụ tùng có khối lượng lớn hơn 15.
SELECT maPT,tenPT,khoiluong
FROM PHUTUNG
WHERE khoiluong>15

-- Tìm những phụ tùng (maPT, tenPt, mausac) có khối lượng lớn hơn 15, không phải màu đỏ (red)
SELECT maPT,tenPT,mausac
FROM PHUTUNG
WHERE khoiluong>15 AND mausac NOT IN('red')

select*from NHACUNGCAP