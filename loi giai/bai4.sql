select tenmh from bai4.monhoc;
select mssv, hoten, ngaysinh from bai4.sinhvien where quequan = 'Ha Noi';
select mssv from bai4.dangky where msmh = 'M1' or msmh = 'M2';
select * from bai4.monhoc;
select tenmh from bai4.monhoc where msmh in 
(select msmh from bai4.dangky where mssv = '2021');
select distinct hoten from bai4.sinhvien where 
mssv in (select mssv from bai4.dangky where msmh in
		(select msmh from bai4.monhoc where tengv = 'Le Quan'));
select tenmh, diem from bai4.dangky join bai4.monhoc using (msmh)
where mssv in 
(select mssv from bai4.sinhvien where hoten = 'Nguyen Van A');
select count(*) from bai4.monhoc where tengv = 'Le Quan';
select mssv from bai4.dangky group by (mssv) having count(*) = (select count(*) from bai4.monhoc where tengv = 'Le Quan');
select tenmh from bai4.monhoc where msmh not in 
(select msmh from bai4.dangky);
select mssv from bai4.dangky group by (mssv) having count(*) > 5;
select avg(diem) from bai4.dangky where mssv in 
(select mssv from bai4.sinhvien where hoten = 'Nguyen Van A');
select max(diem) from bai4.dangky where msmh in 
(select msmh from bai4.monhoc where tenmh = 'Co so du lieu');
select hoten from bai4.sinhvien where mssv in (
select mssv from bai4.dangky where diem = (select max(diem) from bai4.dangky where msmh in 
(select msmh from bai4.monhoc where tenmh = 'Co so du lieu')));
