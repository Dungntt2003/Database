select * from edu1.khachhang;
select * from edu1.khachhang where diachi = 'Quy Nhon';
select * from edu1.khachhang where diachi = 'Quy Nhon' or 
diachi = 'Tuy Phuoc' and loaikh = 'VIP';
select * from edu1.hoadon where extract (month from ngaylaphd)= 8;
select * from edu1.hanghoa where dongia between '50' and '100';
select * from edu1.chitiethd where soluong > 10;
select * from edu1.chitiethd join edu1.hoadon using (mahd)
where mahd = '001';
select * from edu1.chitiethd join edu1.hoadon using (mahd) as C1
join edu1.hanghoa using (mah) where soluong*dongia between 
'1000' and '20000';
select * from edu1.khachhang where makh not in 
(select makh from edu1.hoadon where extract (month from ngaylaphd) = 6);
select * from edu1.chitiethd join edu1.hoadon using (mahd) as C1
join edu1.hanghoa using (mah) where extract (month from ngaylaphd) = 6;
select * from edu1.hanghoa where mah in 
(select mah from edu1.hoadon);
select * from edu1.khachhang;
select * from edu1.hanghoa;
select * from edu1.hoadon;
select * from edu1.chitiethd;
select makh,tenkh, sum(dongia*soluong) as tongtien from edu1.khachhang join edu1.hoadon using (makh) as C1 join edu1.chitiethd using (mahd) as C2 join edu1.hanghoa using (mah)
group by (makh,tenkh);
select makh,tenkh, sum(dongia*soluong) as tongtien from edu1.khachhang join edu1.hoadon using (makh) as C1 join edu1.chitiethd using (mahd) as C2 join edu1.hanghoa using (mah)
group by (makh,tenkh) having sum (dongia* soluong) > '200000';
select mah, tenh, count(*) as soluong from edu1.hoadon join edu1.chitiethd using (mahd) as c1 join edu1.hanghoa using (mah)
group by (mah,tenh);
select mahd, sum(dongia*soluong) as total from edu1.hoadon join edu1.chitiethd using (mahd) as C1 join edu1.hanghoa using (mah)
group by (mahd) having sum(dongia*soluong) > '50000';
select mahd from  edu1.hoadon join edu1.chitiethd using (mahd) as C1 join edu1.hanghoa using (mah)
where mah in ('H001','H002')
group by (mahd) having count(*) >= 3;
select makh, count(*) as total_hoadon from edu1.khachhang join edu1.hoadon using (makh)
group by (makh);
select mahd, sum(dongia*soluong), sum(dongia*soluong)*0.95 as Khuyen_mai from
edu1.hoadon join edu1.chitiethd using (mahd) as C1 join edu1.hanghoa using (mah)
group by (mahd) having sum(dongia*soluong) > '50000';
select makh from  edu1.khachhang join edu1.hoadon using (makh) as C1 join edu1.chitiethd using (mahd) as C2 join edu1.hanghoa using (mah)
where loaikh = 'Vip' and extract (year from ngaylaphd) = '2018'
group by (makh) having sum(dongia*soluong) > '200000';
select makh,tenkh, sum(dongia*soluong) as tongtien from edu1.khachhang join edu1.hoadon using (makh) as C1 join edu1.chitiethd using (mahd) as C2 join edu1.hanghoa using (mah)
group by (makh,tenkh) order by (sum(dongia*soluong)) desc limit 1;
select mahd from edu1.hoadon join edu1.chitiethd using (mahd) as C1 join edu1.hanghoa using (mah)
where extract (month from ngaylaphd) = '5' and extract(year from ngaylaphd) = '2008'
group by (mahd) order by (sum(dongia*soluong)) desc limit 1; 
