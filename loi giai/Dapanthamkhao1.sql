/*Buoi 2*/
-- a. Truy vấn cơ bản
	-- 1. Đưa ra danh sách thông tin các cầu thủ
use QLBongDa;

select MACT, HOTEN, SO, VITRI, NGAYSINH, DIACHI
from CAUTHU

	-- 2. Hiển thị thông tin cầu thủ có áo số 7, chơi ở vị trí tiền vệ

select MACT, HOTEN, SO, VITRI, NGAYSINH, DIACHI 
from CAUTHU
where SO = 7 and VITRI = 'Tiền vệ'

	-- 3. Cho biết tên, ngày sinh, địa chỉ, số điện thoại, của tất cả các HLV
select TENHLV, NGAYSINH, DIACHI, DIENTHOAI
from HUANLUYENVIEN

	-- 4. Hiển thị thông tin các cầu thủ có quốc tịch Việt Nam thuộc Becamex Bình Dương
select MACT, HOTEN, SO, VITRI, NGAYSINH, DIACHI
from CAUTHU
where MAQG = 'VN' and MACLB = 'BBD'

	-- 5. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng 
	-- SHB Đà Nẵng có quốc tích Bra-xin
select MACT, HOTEN, NGAYSINH, DIACHI, VITRI
from CAUTHU
where MAQG = 'BRA' and MACLB = 'SDN'

	-- 6. Hiển thị thông tin tất cả các cầu thủ đang thi đấu trong CLB có sân nhà là Long An
select MACT, HOTEN, SO, VITRI, NGAYSINH, DIACHI
from CAULACBO clb, CAUTHU ct
where clb.MACLB = ct.MACLB and MASAN = 'LA'

	-- 7. Cho biết kết quả các trận đấu vòng 2 mùa bóng năm 2009
select MATRAN, NGAYTD, svd.TENSAN, clb1.TENCLB, clb2.TENCLB, KETQUA
from TRANDAU td, SANVD svd, CAULACBO clb1, CAULACBO clb2
where clb1.MACLB = td.MACLB1 and clb2.MACLB = td.MACLB2 and svd.MASAN = td.MASAN and VONG = 2 and NAM = 2009

	-- 8. Cho biết mã huấn luyện viên, họ và tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc của các HLV Việt Nam
select hlv.MAHLV as [Mã huấn luyện viên], TENHLV as [Họ và tên], NGAYSINH as [Ngày sinh], 
DIACHI as [Địa chỉ], hlv_clb.VAITRO as [Vai trò], clb.TENCLB as [Tên câu lạc bộ]
from HUANLUYENVIEN hlv, HLV_CLB hlv_clb, CAULACBO clb
where hlv.MAHLV = hlv_clb.MAHLV and hlv.MAQG = 'VN' and hlv_clb.MACLB = clb.MACLB

	-- 9. Lấy tên 3 CLB có điểm cao nhất sau vòng 3 năm 2009
select top 3 clb.TENCLB
from CAULACBO clb, BANGXH bxh
where clb.MACLB = bxh.MACLB and VONG = 3
order by DIEM desc

	-- 10. Cho biết mã huấn luyện viên, họ và tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc mà CLB đó đóng ở
	-- tỉnh Bình Dương 
select hlv.MAHLV as [Mã huấn luyện viên], TENHLV as [Họ và tên], NGAYSINH as [Ngày sinh], 
DIACHI as [Địa chỉ], hlv_clb.VAITRO as [Vai trò], clb.TENCLB
from HUANLUYENVIEN hlv, HLV_CLB hlv_clb, CAULACBO clb
where hlv.MAHLV = hlv_clb.MAHLV and hlv_clb.MACLB = 'BBD' and clb.MACLB = hlv_clb.MACLB

-- b. Các phép toán trên nhóm
	-- 1. Thống kê số lượng cầu thủ của mỗi CLB
select CAULACBO.TENCLB, COUNT(MACT)
from CAULACBO, CAUTHU
where CAUTHU.MACLB = CAULACBO.MACLB
group by TENCLB

	-- 2. Thống kê số lượng cầu thủ nước ngoài ( không quốc tịch Việt Nam) của mỗi CLB
select COUNT(MACT)
from CAUTHU
where MAQG <> 'VN'

	-- 3. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài 
	-- (có quốc tịch khác Việt Nam) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài
select clb.MACLB, clb.TENCLB, svd.TENSAN, svd.DIACHI, COUNT(ct.MACT)
from CAULACBO clb, SANVD svd, CAUTHU ct
where clb.MASAN = svd.MASAN and clb.MACLB = ct.MACLB and ct.MAQG <> 'VN'
group by clb.MACLB, clb.TENCLB, svd.TENSAN, svd.DIACHI having count(ct.MACT) > 0

	-- 4. Cho biết tên tỉnh, số lượng cầu thủ đang t hi đấu ở vị trí tiền đạo trong các câu lạc bộ thuộc địa bàn tỉnh đó quản lý
select tinh.TENTINH, count(ct.MACT)
from TINH tinh, CAULACBO clb, CAUTHU ct
where tinh.MATINH = clb.MATINH and ct.MACLB = clb.MACLB
group by tinh.TENTINH

	-- 5. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng xếp hạng vòng 3, năm 2009
select top 1 clb.TENCLB, tinh.TENTINH
from (CAULACBO clb inner join TINH tinh on (clb.MATINH = tinh.MATINH))
inner join BANGXH bxh on clb.MACLB = bxh.MACLB
where bxh.VONG = 3 and bxh.NAM = 2009
order by bxh.DIEM DESC

-- c. Các toán tử nâng cao
	-- 1. Cho biết tên huấn luyện viên đang nắm giữ một ví trí trong 1 câu lạc bộ mà chưa có số điện thoại
select TENHLV
from HUANLUYENVIEN 
WHERE DIENTHOAI = NULL

	-- 2. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm huấn luyện tại bất kì một câu lạc bộ nào
SELECT hlv.TENHLV
from HUANLUYENVIEN hlv
where hlv.MAHLV NOT IN (select MAHLV from HLV_CLB)

	-- 3. Liệt kê các cầu thủ đang thi đấu cho câu lạc bộ có thứ hạng ở vòng 3 năm 2009 lớn hơn 6 hoặc nhỏ hơn 3
select ct.HOTEN, ct.NGAYSINH, ct.DIACHI
from (CAUTHU ct inner join CAULACBO clb on ct.MACLB = clb.MACLB)
where clb.MACLB IN (
	select bxh.MACLB
	from BANGXH bxh
	WHERE bxh.HANG BETWEEN 3 and 6
)

	-- 4. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ có xếp hạng cao nhất 
	-- tính đến hết vòng 3 năm 2009
select td.NGAYTD, svd.TENSAN, clb1.TENCLB, clb2.TENCLB, td.KETQUA
from TRANDAU td, SANVD svd, CAULACBO clb1, CAULACBO clb2
where td.MACLB1 = clb1.MACLB and td.MACLB2 = clb2.MACLB and td.MASAN = svd.MASAN
and ((clb1.MACLB in (
	select bxh.MACLB
	from BANGXH bxh
	where bxh.VONG = 3 and bxh.HANG = 1
)) OR (clb2.MACLB in (
	select bxh.MACLB
	from BANGXH bxh
	where bxh.VONG = 3 and bxh.HANG = 1
)))

/*Buoi 3*/
-- a. Xử lý chuỗi, ngày, giờ
	--1. Cho biết NGAYTD, TENCLB1, TENCLB2, KETQUA các trận đấu diễn ra vào tháng 3 trên sân nhà mà không bị thủng lưới
select td.NGAYTD, clb1.TENCLB, clb2.TENCLB, td.KETQUA
from TRANDAU td, CAULACBO clb1, CAULACBO clb2
where td.MACLB1 = clb1.MACLB and td.MACLB2 = clb2.MACLB and MONTH(td.NGAYTD) = 3
and (LEFT(td.KETQUA, 1) = '0' or RIGHT(td.KETQUA,1) = '0')

	--2. Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ lót là 0
select MACT, HOTEN, NGAYSINH
from CAUTHU
where HOTEN like '_% Công %_'
	
	--3. Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ không phải là họ Nguyễn
select MACT, HOTEN, NGAYSINH
from CAUTHU
where MACT not in (
	select MACT
	from CAUTHU
	where HOTEN like N'Nguyễn %_'
)

	--4. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ của những huấn luyện viên Việt Nam có tuổi từ 35-40
select MAHLV, TENHLV, NGAYSINH, DIACHI
from HUANLUYENVIEN
where (YEAR(GETDATE()) - YEAR(NGAYSINH) >= 35) and (YEAR(GETDATE()) - YEAR(NGAYSINH) <= 70 )

	--5. Cho biết tên CLB có huấn luyện viên trưởng sinh vào ngày 20 / 5
select clb.TENCLB
from (HUANLUYENVIEN hlv inner join HLV_CLB hlvclb on hlv.MAHLV = hlvclb.MAHLV)
inner join CAULACBO clb on hlvclb.MACLB = clb.MACLB
where DAY(hlv.NGAYSINH) = 20 and MONTH(hlv.NGAYSINH) = 5

	--6. Cho biết tên CLB, tên tỉnh mà CLB đóng quân có số bàn thắng nhiều nhất tính tới hết vòng 3 năm 2009
select top 1 clb.TENCLB, tinh.TENTINH, cast(SUBSTRING(bxh.HIEUSO, 1, CHARINDEX('-', bxh.HIEUSO, 1)-1) as int) as [Số bàn thắng]
from CAULACBO clb inner join TINH tinh on clb.MATINH = tinh.MATINH
inner join BANGXH bxh on bxh.MACLB = clb.MACLB
where bxh.VONG = 3
order by [Số bàn thắng] desc

--b. Truy vấn con
	--1. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước
	-- ngoài (Có quốc tịch khác “Việt Nam”) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu
	-- thủ nước ngoài.
select clb.TENCLB, clb.MACLB, COUNT(ct.MACT) as [số lượng]
from (CAULACBO clb inner join SANVD svd on clb.MASAN = svd.MASAN)
inner join CAUTHU ct on ct.MACLB = clb.MACLB
where ct.MAQG <> 'VN'
group by clb.TENCLB, clb.MACLB

	--2. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao nhất năm 2009.
select top 1 clb.TENCLB, tinh.TENTINH, cast(SUBSTRING(bxh.HIEUSO, 1, CHARINDEX('-', bxh.HIEUSO, 1)-1) as int)
	- cast(SUBSTRING(bxh.HIEUSO, CHARINDEX('-', bxh.HIEUSO, 1)+1, LEN(bxh.HIEUSO)) as int) as [Hiệu số bàn thắng]
from CAULACBO clb inner join TINH tinh on clb.MATINH = tinh.MATINH
inner join BANGXH bxh on bxh.MACLB = clb.MACLB
order by [Hiệu số bàn thắng] desc

	--3. Cho biết danh sách các trận đấu ( NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của
	-- câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009.
select td.NGAYTD, svd.TENSAN, td.MACLB1, td.MACLB2, td.KETQUA 
from TRANDAU td inner join SANVD svd on td.MASAN = svd.MASAN
where td.MACLB1 in (
	select top 1 bxh.MACLB
	from BANGXH bxh
	where bxh.VONG = 3
	order by bxh.DIEM 
) or td.MACLB2 in (
	select top 1 bxh.MACLB
	from BANGXH bxh
	where bxh.VONG = 3
	order by bxh.DIEM 
)

	--4. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại
	-- (kể cả sân nhà và sân khách) trong mùa giải năm 2009.
	-- Tìm các đối thủ chưa đối của đội A -> rỗng : A đấu với tất cả các câu lạc bộ (not exists)
select clb1.MACLB
from CAULACBO clb1
where not exists (
	select clb2.MACLB
	from CAULACBO clb2
	where clb2.MACLB != clb1.MACLB
	except
	( 
		select t1.MACLB1
		from TRANDAU t1
		where t1.MACLB1 = clb1.MACLB
		union
		select t2.MACLB2
		from TRANDAU t2
		where t2.MACLB2 = clb1.MACLB
	)	 
) 



/* 1 sinh viên đăng kí tất cả các môn học -> dùng phép chia 
select distinct StudentId from Inscriptption i1
where not exists (
	select CourseID from Course
	except
	(select CourseId from Inscription i2 where i2.StudentId = i2.StudentId)
)
*/

	--5. Cho biết mã câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại (chỉ tính sân nhà) trong mùa giải năm 2009


--c. Bài tập về Rule
	--1. Khi thêm cầu thủ mới, kiểm tra vị trí trên sân của cầu thủ chỉ thuộc một trong các vị trí sau : Thủ môn, tiền đạo, tiền vệ,
	-- trung vệ, hậu vệ
	alter table CAUTHU
	add check(VITRI = N'Thủ môn' and VITRI = N'Tiền đạo' and VITRI = N'Tiền vệ' and VITRI = N'Trung vệ' and VITRI = N'Hậu vệ')

	--2. Khi phân công huấn luyện viên, kiểm tra vai trò của huấn luyện vi ên chỉ thuộc một trong
	-- các vai trò sau: HLV chính, HLV phụ, HLV thể lực, HLV thủ môn.
	alter table HLV_CLB
	add check (VAITRO = N'HLV Chính' and VAITRO = N'HLV phụ' and VAITRO = N'HLV thủ môn' and VAITRO = N'HLV thể lực')

	--3. Khi thêm cầu thủ mới, kiểm tra cầu thủ đó có tuổi phải đủ 18 trở lên (chỉ tính năm sinh
	alter table CAUTHU
	add check (YEAR(GETDATE()) - YEAR(NGAYSINH) >= 18)

	--4. Kiểm tra kết quả trận đấu có dạng số_bàn_thắng- số_bàn_thua	alter table TRANDAU	add check (KETQUA like '_%-%_')
--d. Bài tập về View
	--1. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của cầu thủ trong đội bóng SHB Đà Nẵng có quốc tích Braxin
select ct.MACT, ct.HOTEN, ct.NGAYSINH, ct.DIACHI, ct.VITRI
from CAUTHU ct inner join CAULACBO clb on ct.MACLB = clb.MACLB
inner join QUOCGIA qg on ct.MAQG = qg.MAQG
where clb.TENCLB = N'SHB Đà Nẵng' and qg.TENQG = 'Brazil'

	--2. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận đấu vòng 3 của mùa bóng 2009
select td.MATRAN, td.NGAYTD, svd.TENSAN, clb1.MACLB, clb2.MACLB, td.KETQUA
from TRANDAU td inner join SANVD svd on td.MASAN = svd.MASAN
inner join CAULACBO clb1 on td.MACLB1 = clb1.MACLB
inner join CAULACBO clb2 on td.MACLB2 = clb2.MACLB
where td.VONG = 3 and td.NAM = 2009

	--3. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc của các huấn luyện viên có 
	-- quốc tịch Việt Nam
select hlv.MAHLV, hlv.TENHLV, hlv.NGAYSINH, hlv.DIACHI, hlv_clb.VAITRO, clb.TENCLB
from HUANLUYENVIEN hlv inner join HLV_CLB hlv_clb on hlv.MAHLV = hlv_clb.MAHLV
inner join CAULACBO clb on hlv_clb.MACLB = clb.MACLB
where hlv.MAQG = 'VN'

	--4. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài ( có quốc tịch khác Việt
	-- Nam tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài
select clb.MACLB, clb.TENCLB, svd.TENSAN, svd.DIACHI, count(ct.MACT) as [Số lượng cầu thủ nước ngoài]
from CAULACBO clb inner join SANVD svd on clb.MASAN = svd.MASAN
inner join CAUTHU ct on clb.MACLB = ct.MACLB
where ct.MAQG <> 'VN'
group by clb.MACLB, clb.TENCLB, svd.TENSAN, svd.DIACHI having count(ct.MACT) > 1

	--5. Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiển đạo trong các câu lạc bộ thuộc địa bàn tỉnh đó quản lý
select t.TENTINH, count(ct.MACT)
from CAUTHU ct, TINH t, CAULACBO clb
where ct.MACLB = clb.MACLB and t.MATINH = clb.MATINH
and ct.VITRI = N'Tiền Đạo' 
group by t.TENTINH

	--6. Cho biết tên CLB, tên tỉnh mà CLB đó đang đóng nằm ở vị trí cao nhất của BXH của vòng 3 trong năm 2009
select clb.TENCLB, t.TENTINH
from TINH t, CAULACBO clb
where t.MATINH = clb.MATINH
and clb.MACLB in (
	select top 1 bxh.MACLB
	from BANGXH bxh
	where bxh.VONG = 3 and bxh.NAM = 2009
	order by bxh.DIEM desc
)

	--7. Cho biết tên HLV đang nắm giữ 1 vị trí trong 1 câu lạc bộ mà chưa có số điện thoại
select hlv.TENHLV
from HUANLUYENVIEN hlv inner join HLV_CLB hlv_clb on hlv.MAHLV = hlv_clb.MAHLV
inner join CAULACBO clb on hlv_clb.MACLB = clb.MACLB
where hlv.DIENTHOAI is null

	--8. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa công tác tại bất cứ câu lạc bộ nào
select hlv.TENHLV
from HUANLUYENVIEN hlv
where hlv.MAHLV not in (
	select hlv.MAHLV
	from HUANLUYENVIEN hlv inner join HLV_CLB hlv_clb on hlv.MAHLV = hlv_clb.MAHLV
	inner join CAULACBO clb on hlv_clb.MACLB = clb.MACLB
) 

	--9. Cho biết kết quả của các trận đấu đã diễn ra (MACLB1, MACLB2, NAM, VONG, SOBANTHANG, SOBANTHUA)
select td.MACLB1, td.MACLB2, td.NAM, td.VONG, SUBSTRING(td.KETQUA,1,CHARINDEX('-',td.KETQUA,1)-1) as [Số bàn thắng của đội 1]
, SUBSTRING(td.KETQUA,CHARINDEX('-',td.KETQUA,1) + 1,LEN(td.KETQUA)) as [Số bàn thua của đội 1]
from TRANDAU td

	--10. Cho biết kết quả các trận đấu trên sân nhà (MACLB, NAM, VONG, SOBANTHANG, SOBANTHUA)
select td.MACLB1, td.NAM, td.VONG,  SUBSTRING(td.KETQUA,1,CHARINDEX('-',td.KETQUA,1)-1) as [Số bàn thắng]
, SUBSTRING(td.KETQUA,CHARINDEX('-',td.KETQUA,1) + 1,LEN(td.KETQUA)) as [Số bàn thua]
from TRANDAU td

	--11. Cho biết kết quả các trận đấu trên sân khách (MACLB, NAM, VONG, SOBANTHANG,SOBANTHUA)
select td.MACLB2, td.NAM, td.VONG,  SUBSTRING(td.KETQUA,1,CHARINDEX('-',td.KETQUA,1)-1) as [Số bàn thua]
, SUBSTRING(td.KETQUA,CHARINDEX('-',td.KETQUA,1) + 1,LEN(td.KETQUA)) as [Số bàn thắng]
from TRANDAU td

	--12. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA)
	-- của câu lạc bộ CLB có thứ hạng cao nhất trong bảng xếp hạng vòng 3 năm 2009
select *
from TRANDAU td
where td.MACLB1 in (
	select top 1 bxh.MACLB
	from BANGXH bxh
	order by bxh.DIEM desc
)

	--13. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA)
	-- của câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009
select *
from TRANDAU td
where td.MACLB1 in (
	select top 1 bxh.MACLB
	from BANGXH bxh
	order by bxh.DIEM
)