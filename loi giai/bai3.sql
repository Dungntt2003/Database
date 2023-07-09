select tenda from bai3.duan;
select hoten from bai3.nhanvien where manv in 
(select manv from bai3.thamgia where mada in
(select mada from bai3.duan where tenda = 'Quan ly dao tao'));
select hoten from bai3.nhanvien where manv in 
(select manv from bai3.thamgia where mada in
(select mada from bai3.duan where tenda = 'Quan ly dao tao') intersect (select mada from bai3.duan where tenda = 'Dao tao tu xa'));
select hoten from bai3.nhanvien where manv in 
(select manv from bai3.thamgia where mada in
(select mada from bai3.duan where tenda = 'Quan ly dao tao') except (select mada from bai3.duan where tenda = 'Dao tao tu xa'));
select map from bai3.nhanvien where manv not in 
(select manv from bai3.thamgia);
select count(*) from bai3.nhanvien where map in 
(select map from bai3.phong where tenp = 'NCKH');
select mada from bai3.duan group by (mada) having 
count(*) = (select count(*) from bai3.nhanvien where map in 
(select map from bai3.phong where tenp = 'NCKH'));
select manv, sum(ngansach)/count(*) as trung_binh from bai3.duan join bai3.thamgia using (mada) 
group by (manv) having manv = 'NV01'; 
select count(*) as so_nhanvien_thamgia from bai3.thamgia 
group by (mada) having mada in 
(select mada from bai3.duan where tenda = 'Quan ly dao tao');
select mada, count(*) as so_nhanvien_thamgia from bai3.thamgia 
group by (mada) having count(*) >10;
select tenda from bai3.duan  
where mada in 
(select mada as so_nhanvien_thamgia from bai3.thamgia 
group by (mada) having count(*) >10);
select count(*) from bai3.thamgia group by (mada);
select mada from bai3.thamgia group by (mada) having count(*) >= ALL(select count(*) from bai3.thamgia group by (mada));
select tenda from bai3.duan 
where mada in 
(select mada from bai3.thamgia group by (mada) having count(*) >= ALL(select count(*) from bai3.thamgia group by (mada)));
