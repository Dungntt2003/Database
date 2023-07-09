/* Buoi 2*/
/* Truy van co ban */
/* 
1. Cho biết thông tin (mã cầu thủ, họ tên, số áo, vị trí, ngày sinh, địa chỉ) của tất cả các
cầu thủ. */
SELECT MACT, HOTEN, SO, VITRI, NGAYSINH, DIACHI FROM CAUTHU;

/*
2. Hiển thị thông tin tất cả các cầu thủ có số áo là 7 chơi ở vị trí Tiền vệ.
*/
SELECT * FROM CAUTHU
WHERE SO = 7 AND VITRI =N'Tiền vệ';

/* 
3. Cho biết tên, ngày sinh, địa chỉ, điện thoại của tất cả các huấn luyện viên.
*/
SELECT TENHLV, NGAYSINH, DIACHI,DIENTHOAI FROM HUANLUYENVIEN;

/*
4. Hiển thi thông tin tất cả các cầu thủ có quốc tịch Việt Nam thuộc câu lạc bộ
Becamex Bình Dương
*/
SELECT CAUTHU.* FROM CAUTHU,QUOCGIA,CAULACBO
WHERE CAUTHU.MAQG = QUOCGIA.MAQG
AND CAUTHU.MACLB = CAULACBO.MACLB
AND QUOCGIA.TENQG =N'Việt Nam' AND CAULACBO.TENCLB = N'BECAMEX BÌNH DƯƠNG';

/*
5. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng
‘SHB Đà Nẵng’ có quốc tịch “Bra-xin”
*/
SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI  
FROM (CAUTHU INNER JOIN CAULACBO ON CAULACBO.MACLB = CAULACBO.MACLB ) INNER JOIN QUOCGIA ON CAUTHU.MAQG = QUOCGIA.MAQG
WHERE CAULACBO.TENCLB = N'SHB ĐÀ NẴNG' AND QUOCGIA.TENQG = 'Bra-xin';

/*
6. Hiển thị thông tin tất cả các cầu thủ đang thi đấu trong câu lạc bộ có sân nhà là
“Long An”
*/
SELECT CAUTHU.* 
FROM CAUTHU, CAULACBO, SANVD
WHERE CAUTHU.MACLB = CAULACBO.MACLB
AND CAULACBO.MASAN = SANVD.MASAN
AND SANVD.TENSAN = N'Long An';

/*
7. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các
trận đấu vòng 2 của mùa bóng năm 2009
*/
SELECT TRANDAU.MATRAN, TRANDAU.NGAYTD, SANVD.TENSAN, CLB1.TENCLB, CLB2.TENCLB, TRANDAU.KETQUA
FROM TRANDAU, SANVD, CAULACBO CLB1, CAULACBO CLB2
WHERE TRANDAU.MASAN = SANVD.MASAN
AND TRANDAU.MACLB1 = CLB1.MACLB
AND TRANDAU.MACLB2 = CLB2.MACLB
AND NAM = 2009 AND VONG = 2;

/*
8. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang
làm việc của các huấn luyện viên có quốc tịch “ViệtNam”
*/ 
SELECT HLV.MAHLV, HLV.TENHLV,HLV.NGAYSINH, HLV.DIACHI, HLV_CLB.VAITRO, CLB.TENCLB
FROM HUANLUYENVIEN HLV, HLV_CLB, QUOCGIA QG, CAULACBO CLB
WHERE HLV.MAHLV = HLV_CLB.MAHLV
AND HLV_CLB.MACLB = CLB.MACLB
AND HLV.MAQG = QG.MAQG
AND QG.TENQG = N'Việt Nam';

/*
9. Lấy tên 3 câu lạc bộ có điểm cao nhất sau vòng 3 năm 2009
*/
SELECT TOP 3 CAULACBO.TENCLB
FROM BANGXH, CAULACBO
WHERE
BANGXH.MACLB = CAULACBO.MACLB
AND
BANGXH.VONG = 3 AND NAM = 2009
ORDER BY DIEM DESC;

/*
10. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc
mà câu lạc bộ đó đóng ở tỉnh Binh Dương
*/
SELECT HUANLUYENVIEN.MAHLV, HUANLUYENVIEN.TENHLV, HUANLUYENVIEN.NGAYSINH, HUANLUYENVIEN.DIACHI, HLV_CLB.VAITRO, CAULACBO.TENCLB
FROM HUANLUYENVIEN, HLV_CLB, CAULACBO, TINH
WHERE HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
AND HLV_CLB.MACLB = CAULACBO.MACLB
AND CAULACBO.MATINH = TINH.MATINH
AND TINH.TENTINH = N'Bình Dương';

/*
b. Các phép toán trên nhóm
*/
/* 
1. Thống kê số lượng cầu thủ của mỗi câu lạc bộ
*/
SELECT TENCLB, COUNT(CAUTHU.MACT) as [So luong cau thu]
FROM CAULACBO, CAUTHU
WHERE CAULACBO.MACLB = CAUTHU.MACLB
GROUP BY TENCLB;

/*
2. Thống kê số lượng cầu thủ nước ngoài (không có quốc tịch Việt Nam) của mỗi câu lạc bộ
*/
SELECT CAULACBO.TENCLB, COUNT(CAUTHU.MAQG) as [Số lượng cầu thủ nước ngoài]
FROM CAULACBO, CAUTHU, QUOCGIA
WHERE CAULACBO.MACLB = CAUTHU.MACLB
AND CAUTHU.MAQG = QUOCGIA.MAQG
AND QUOCGIA.TENQG <> N'Việt Nam'
GROUP BY CAULACBO.TENCLB;

/*
3. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ
nước ngoài (có quốc tịch khác Việt Nam) tương ứng của các câu lạc bộ có nhiều hơn
2 cầu thủ nước ngoài.
*/

SELECT CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN, SANVD.DIACHI, COUNT(CAUTHU.MACT)
FROM CAULACBO, SANVD, CAUTHU, QUOCGIA
WHERE CAULACBO.MACLB = CAUTHU.MACLB
AND CAULACBO.MASAN = SANVD.MASAN
AND CAUTHU.MAQG = QUOCGIA.MAQG
AND QUOCGIA.TENQG <> N'Việt Nam'
GROUP BY CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN, SANVD.DIACHI
HAVING COUNT(CAUTHU.MACT) > 2;

/* 
4. Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc
bộ thuộc địa bàn tỉnh đó quản lí
*/

SELECT TINH.TENTINH, COUNT(CAUTHU.MACT) as [Số lượng cầu thủ đang thi đấu ở vị trí tiền đạo]
FROM TINH, CAUTHU,CAULACBO
WHERE CAUTHU.MACLB = CAULACBO.MACLB
AND CAULACBO.MATINH = TINH.MATINH
AND CAUTHU.VITRI = N'Tiền đạo'
GROUP BY TINH.TENTINH;

/*
5. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng
xếp hạng vòng 3, năm 2009
*/
SELECT TOP 1 CAULACBO.TENCLB, TINH.TENTINH, BANGXH.DIEM
FROM CAULACBO, TINH, BANGXH
WHERE CAULACBO.MATINH = TINH.MATINH
AND CAULACBO.MACLB = BANGXH.MACLB
AND VONG = 3 AND NAM = 2009 
ORDER BY BANGXH.DIEM DESC;

/* c. Các toán tử nâng cao */
/* 
1. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong một câu lạc bộ mà
chưa có số điện thoại
*/
SELECT TENHLV
FROM HUANLUYENVIEN,HLV_CLB 
WHERE HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
AND HUANLUYENVIEN.DIENTHOAI  IS NULL 
AND HLV_CLB.VAITRO IS NOT NULL;

/*
2. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện
tại bất kỳ một câu lạc bộ nào
*/

SELECT HUANLUYENVIEN.TENHLV
FROM HUANLUYENVIEN, HLV_CLB, QUOCGIA
WHERE HUANLUYENVIEN.MAHLV = HLV_CLB.MACLB
AND HUANLUYENVIEN.MAQG = QUOCGIA.MAQG
AND QUOCGIA.TENQG = N'Việt Nam'
AND HLV_CLB.MACLB IS NULL
AND HLV_CLB.VAITRO IS NULL;

/*
3. Liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng ở vòng 3 năm 2009
lớn hơn 6 hoặc nhỏ hơn 3
*/

SELECT CAUTHU.HOTEN
FROM CAUTHU, CAULACBO, BANGXH
WHERE CAUTHU.MACLB = CAULACBO.MACLB
AND BANGXH.MACLB = CAULACBO.MACLB
AND VONG = 3 AND NAM = 2009
AND HANG BETWEEN 3 AND 6;


/*
4. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA)
của câu lạc bộ (CLB) đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009 .
*/
SELECT TRANDAU.NGAYTD, SANVD.TENSAN, CLB1.TENCLB, CLB2.TENCLB, TRANDAU.KETQUA
FROM TRANDAU, CAULACBO CLB1, CAULACBO CLB2, SANVD
WHERE TRANDAU.MASAN = SANVD.MASAN
AND TRANDAU.MACLB1 = CLB1.MACLB
AND TRANDAU.MACLB2 = CLB2.MACLB
AND
(TRANDAU.MACLB1 in (Select MACLB FROM BANGXH WHERE HANG = 1 AND VONG = 3 AND NAM = 2009)
OR 
TRANDAU.MACLB2 in (Select MACLB FROM BANGXH WHERE HANG = 1  AND VONG = 3 AND NAM = 2009));

/* Buoi 3*/
/* Thao tác cơ sở dữ liệu sử dụng T-SQL nâng cao */
/* Xử lý chuỗi,ngày giờ */
/* a. Cho biết NGAYTD, TENCLB1, TENCLB2, KETQUA các trận đấu diễn ra vào tháng 3 trên sân
nhà mà không bị thủng lưới.*/

SELECT TD.NGAYTD, CLB1.TENCLB, CLB2.TENCLB, TD.KETQUA
FROM TRANDAU TD INNER JOIN CAULACBO CLB1 ON TD.MACLB1 = CLB1.MACLB INNER JOIN CAULACBO CLB2 ON TD.MACLB2 = CLB2.MACLB
WHERE MONTH(TD.NGAYTD) = 3
AND (TD.MASAN = CLB1.MASAN AND SUBSTRING(TD.KETQUA, 1, 1) = 0 )
OR (TD.MASAN = CLB2.MASAN AND SUBSTRING(TD.KETQUA,3,1) = 0);

/* b.Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ lót là “Công” */
SELECT CT.MACT, CT.HOTEN, CT.NGAYSINH 
FROM CAUTHU CT
WHERE CT.HOTEN LIKE N'%_Công_%';

/* c.Cho biết mã số,họ tên, ngày sinh của những cầu thủ có họ không phải là "Nguyễn" */
SELECT CT.MACT, CT.HOTEN, CT.NGAYSINH 
FROM CAUTHU CT
WHERE CT.HOTEN NOT LIKE N'Nguyễn%';
/* d. Cho biết mã huấn luyện vên, họ tên, ngày sinh, địa chỉ của những huấn luyện viên Việt Nam có tuổi nằm trong khoảng 35-40;
*/
SELECT HLV.MAHLV, HLV.TENHLV, HLV.NGAYSINH, HLV.DIACHI
FROM HUANLUYENVIEN HLV
WHERE DATEPART(YEAR,GETDATE()) - DATEPART(YEAR,HLV.NGAYSINH) BETWEEN 35 AND 40; 

/* e. Cho biết tên câu lạc bộ có huấn luyện viên trưởng sinh vào ngày 20 tháng 5
*/
SELECT CLB.TENCLB
FROM CAULACBO CLB, HLV_CLB HC, HUANLUYENVIEN HLV
WHERE CLB. MACLB = HC.MACLB AND HC.MAHLV = HLV.MAHLV
AND HC.VAITRO = N'HLV Chính'
AND MONTH(HLV.NGAYSINH) = 5
AND DAY(HLV.NGAYSINH) = 20;

/* f. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có số bàn thằng nhiều nhất tính đến hết vòng 3 năm 2009 */
SELECT CLB.TENCLB, T.TENTINH 
FROM CAULACBO CLB INNER JOIN TINH T ON CLB.MATINH = T.MATINH INNER JOIN BANGXH ON CLB.MACLB = BANGXH.MACLB
WHERE BANGXH.HIEUSO = (SELECT TOP 1 HIEUSO FROM BANGXH WHERE BANGXH.NAM = 2009
AND BANGXH.VONG = 3 ORDER BY (CONVERT(int, SUBSTRING(HIEUSO,1,1))) DESC) ;


/* b. Truy vấn con */
/* 1. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài(Có quốc tịch khác Việt Nam) 
của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài */
SELECT CLB.MACLB, CLB.TENCLB, SVD.TENSAN, SVD.DIACHI, COUNT(CT.MACT) AS [SL]
FROM CAULACBO CLB,SANVD SVD,CAUTHU CT,QUOCGIA QG
WHERE
CLB.MACLB = CT.MACLB AND SVD.MASAN = CLB.MASAN AND CT.MAQG = QG.MAQG
AND QG.TENQG <> N'Việt Nam'
GROUP BY CLB.MACLB, CLB.TENCLB, SVD.TENSAN, SVD.DIACHI
HAVING COUNT(CT.MACT) >=2;

/* 2. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao nhất năm 2009 */
SELECT DISTINCT CLB.TENCLB , T.TENTINH
FROM CAULACBO CLB INNER JOIN TINH T ON CLB.MATINH = T.MATINH INNER JOIN BANGXH ON CLB.MACLB = BANGXH.MACLB
WHERE CLB.MACLB = 
(SELECT TOP 1 MACLB FROM BANGXH WHERE NAM = 2009 
			ORDER BY ((CONVERT(int, SUBSTRING(HIEUSO,1,1))) - (CONVERT(int, SUBSTRING(HIEUSO,3,1)))) DESC)
AND NAM = 2009;

/* 3. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) 
của câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xấp hạng vòng 3 năm 2009 */

SELECT TRANDAU.NGAYTD,  SANVD.TENSAN, CLB1.TENCLB, CLB2.TENCLB, TRANDAU.KETQUA
FROM TRANDAU, CAULACBO CLB1, CAULACBO CLB2, SANVD
WHERE TRANDAU.MACLB1 = CLB1.MACLB
AND TRANDAU.MACLB2 = CLB2.MACLB
AND TRANDAU.MASAN = SANVD.MASAN
AND 
(CLB1.MACLB = ( SELECT TOP 1 BANGXH.MACLB FROM BANGXH WHERE BANGXH.VONG = 3 AND BANGXH.NAM = 2009 ORDER BY BANGXH.HANG DESC)
OR
CLB2.MACLB = ( SELECT TOP 1 BANGXH.MACLB FROM BANGXH WHERE BANGXH.VONG = 3 AND BANGXH.NAM = 2009 ORDER BY BANGXH.HANG DESC));

/* 4. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại
(kể cả sân nhà và sân khách) trong mùa giải năm 2009.*/ 
SELECT Distinct MACLB
FROM CAULACBO c 
WHERE not exists (
	select MACLB from CAULACBO c1
	where c1.MACLB != c.MACLB
		except (( select MACLB1 as MACLB from TRANDAU t1
		where t1.MACLB2 = c.MACLB)
			union (select MACLB2 as MACLB from TRANDAU t2
			where t2.MACLB1 = c.MACLB)))


/* 5. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại
( chỉ tính sân nhà) tro ng mùa giải năm 2009.*/select distinct MACLB1 
from TRANDAU t1
where not exists (select MACLB from CAULACBO c1 
	except ((select MACLB2 from TRANDAU t2 where t1.MACLB1 = t2.MACLB1) union (SELECT MACLB from CAULACBO c2 where MACLB = t1.MACLB1)))


/*Buổi 4*/
/*  c. Bài tập về Rule */
/*1. Khi thêm cầu thủ mới, kiểm tra vị trí trên sân của cầu thủ chỉ thuộc một trong các vị trí
sau: Thủ môn, tiền đạo, tiền vệ, trung vệ, hậu vệ.*/

ALTER TABLE CAUTHU
ADD CONSTRAINT CHK_VITRI CHECK ( VITRI IN (N'Thủ môn',N'Tiền đạo',N'Tiền vệ', N'Trung vệ',N'Hậu vệ'));
GO


/*2. Khi phân công huấn luyện viên, kiểm tra vai trò của huấn luyện vi ên chỉ thuộc một trong
các vai trò sau: HLV chính, HLV phụ, HLV thể lực, HLV thủ môn.*/
ALTER TABLE HLV_CLB
ADD CONSTRAINT CHK_VAITRO CHECK (VAITRO IN(N'HLV Chính',N'HLV phụ',N'HLV thủ môn'));
GO

/*3. Khi thêm cầu thủ mới, kiểm tra cầu thủ đó có tuổi phải đủ 18 trở lên (chỉ tính năm sinh)*/
ALTER TABLE CAUTHU
ADD CONSTRAINT CHK_TUOI CHECK( year(getdate()) - year(NGAYSINH) >= 18);
GO
/*4. Kiểm tra kết quả trận đấu có dạng số_bàn_thắng- số_bàn_thua*/

ALTER TABLE TRANDAU
ADD CONSTRAINT CHK_KETQUA CHECK(KETQUA LIKE '%-%' );
GO

/* 5. View */
/* d) Bài tập về View
1. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bón g “SHB
Đà Nẵng” có quốc tịch “Bra-xin”
*/
CREATE VIEW View1
AS 
SELECT  C.MACT , C.HOTEN, C.NGAYSINH, C.DIACHI, C.VITRI
FROM CAUTHU C, CAULACBO CLB, QUOCGIA QG
WHERE C.MACLB = CLB.MACLB
AND C.MAQG = QG.MAQG
AND CLB.TENCLB =  N'SHB Đà Nẵng'
AND QG.TENQG = 'Bra-xin'

SELECT * FROM View1
/*
2. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận
đấu vòng 3 của mùa bóng năm 2009.
*/
CREATE VIEW viewTD
AS
SELECT TD.MATRAN, TD.NGAYTD, S.TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2,TD.KETQUA
FROM TRANDAU TD, SANVD S, CAULACBO CLB1, CAULACBO CLB2
WHERE TD.MASAN = S.MASAN
AND TD.MACLB1 = CLB1.MACLB
AND TD.MACLB2 = CLB2.MACLB
AND TD.VONG = 3
AND NAM = 2009;
SELECT * FROM viewTD;
/*
3. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc
của các huấn luyện viên có quốc tịch “Việt Nam”
*/
CREATE VIEW viewHLB
AS
SELECT HLV.MAHLV, HLV.TENHLV, HLV.NGAYSINH, HLV.DIACHI, HLV_CLB.VAITRO, CLB.TENCLB
FROM HUANLUYENVIEN HLV, HLV_CLB, CAULACBO CLB, QUOCGIA QG
WHERE HLV.MAHLV = HLV_CLB.MAHLV
AND HLV_CLB.MACLB = CLB.MACLB
AND HLV.MAQG = QG.MAQG
AND QG.TENQG = N'Việt Nam';
GO
SELECT * FROM viewHLB;
/*
4. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ
nước ngoài (có quốc tịch khác “Việt Nam”) tương ứng của các câu lạc bộ nhiều hơn 2
cầu thủ nước ngoài
*/
CREATE VIEW ViewCAULACBO
AS
SELECT CLB.MACLB, CLB.TENCLB, SVD.TENSAN, SVD.DIACHI, COUNT(CT.MACT) AS SOLUONCAUTHUNUOCNGOAI
FROM CAULACBO CLB, SANVD SVD, QUOCGIA QG, CAUTHU CT
WHERE 
CLB.MACLB = CT.MACLB
AND CLB.MASAN = SVD.MASAN
AND CLB.MACLB = CT.MACLB
AND CT.MAQG = QG.MAQG
AND QG.TENQG <> N'Việt Nam'
GROUP BY 
CLB.MACLB, CLB.TENCLB, SVD.TENSAN, SVD.DIACHI
HAVING COUNT(CT.MACT) > 2;
GO
SELECT * FROM ViewCAULACBO;

/*
5. Cho biết tên tỉnh, số lượng câu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc bộ
thuộc địa bàn tỉnh đó quản lý.
*/
CREATE VIEW viewTinh
AS
SELECT T.TENTINH, COUNT(CT.MACT) AS SLTĐ
FROM  TINH T, CAUTHU CT, CAULACBO CLB
WHERE CT.MACLB = CLB.MACLB
AND CLB.MATINH = T.MATINH
AND CT.VITRI = N'Tiền Đạo'
GROUP BY T.TENTINH;
GO
SELECT * FROM viewTinh;

/*
6. Cho biết tên câu lạc bộ,tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng xếp
hạng của vòng 3 năm 2009
*/
CREATE VIEW view6
AS
SELECT TOP 1  CLB.TENCLB, T.TENTINH
FROM CAULACBO CLB, TINH T,BANGXH BXH
WHERE CLB.MATINH = T.MATINH
AND CLB.MACLB = BXH.MACLB
AND BXH.VONG = 3
AND BXH.NAM = 2009
ORDER BY BXH.HANG ASC;
GO
SELECT * FROM view6;
/*
7. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong 1 c âu lạc bộ mà chưa có số
điện thoại*/
CREATE VIEW view7
AS
SELECT HLV.TENHLV
FROM HUANLUYENVIEN HLV
WHERE
HLV.DIENTHOAI IS NULL;
GO
SELECT * FROM view7;
/*
8. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện tại bất
kỳ một câu lạc b ộ nào
*/
SELECT HLV.*
FROM HUANLUYENVIEN HLV, QUOCGIA QG
WHERE HLV.MAQG = QG.TENQG
AND QG.TENQG = N'Việt Nam'
AND 

/*
9. Cho biết kết quả các trận đấu đã diễn ra (MACLB1, MACLB2, NAM, VONG,
SOBANTHANG,SOBANTHUA)
10. Cho biết kết quả các trận đấu trên sân nhà (MACLB, NAM, VONG,
SOBANTHANG, SOBANTHUA)
11. Cho biết kết quả các trận đấu trên sân khách (MACLB, NAM, VONG,
SOBANTHANG,SOBANTHUA)
12. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA)
của câu lạc bộ CLB đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009
13. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA)
của câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009*/










 
