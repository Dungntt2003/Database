create table demo.sach (
	masach char(10) primary key,
	tensach char(100),
	namxuatban int,
	dongia money,
	theloai char(50),
	soluongcon int
);
create table demo.donhang (
	madonhang char(4) primary key,
	makhachhang char(4) ,
	ngaymuahang date
);
create table demo.khachhang 
(
	makhachhang char(4) primary key,
	tenkhachhang char(100),
	dienthoai char(10),
	email char(10),
	masothue char(10)
);

create table demo.chitiet (
	madonhang char(10),
	masach char(10),
	soluongmua int,
	primary key (madonhang,masach)
);
1.
select * from demo.sach where soluongcon <10;
2.
select count(soluongmua) from demo.sach join demo.chitiet using (masach) group by (masach) having masach = 'Tam ly dan toc An Nam';
3.
select dongia*soluongmua as money from demo.sach join demo.chitiet using (masach) as C1 join demo.donhang using (madonhang)
where madonhang = '01231' ;
4.
CREATE OR REPLACE FUNCTION demo.luu_tru_thong_tin_sach(ma_sach_input VARCHAR(10))
RETURNS TABLE (soluongmua INTEGER, soluongcon INTEGER) AS $$
BEGIN
    RETURN QUERY
    (SELECT soluongcon,masach
    FROM demo.sach  
    WHERE masach = ma_sach_input) intersect 
	(select count(soluongmua), masach from demo.sach join demo.chitiet using (masach) group by (masach) having 
	masach = ma_sach_input);
END;
$$ LANGUAGE plpgsql;

5.
select madonhang from  demo.donhang where ngaymuahang = '2023-06-25';
delete from demo.chitiet where madonhang in 
(select madonhang from  demo.donhang where ngaymuahang = '2023-06-25');
delete from demo.donhang where ngaymuahang = '2023-06-25';