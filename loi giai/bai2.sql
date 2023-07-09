select hoten, tuoi from bai2.nhanvien where msnv in 
(select msnv from bai2.lamviec where msp in
(select msp from bai2.phong where tenphong = 'To chuc')
intersect (select msp from bai2.phong where tenphong = 'Kinh doanh'));
select msp, count(*)as so_nhan_vien from bai2.lamviec 
group by (msp) having count(*) >= 20;
select sum(nganquy)as tong_ngan_quy from bai2.lamviec join bai2.phong using (msp)
group by (msnv);
select msnv, luong from bai2.nhanvien as hihi
where msnv in (select msnv from bai2.lamviec) and luong >= (select sum(nganquy)as tong_ngan_quy from bai2.lamviec join bai2.phong using (msp) as haha
group by (msnv));
select mstruongphong, sum(nganquy) as tong_tien from bai2.phong
group by (mstruongphong);
select mstruongphong, sum(nganquy) as tong_tien from bai2.phong
group by (mstruongphong) having sum(nganquy) >= ALL(select sum(nganquy) as tong_tien from bai2.phong
group by (mstruongphong));
select hoten from bai2.nhanvien where msnv in (select mstruongphong as tong_tien from bai2.phong
group by (mstruongphong) having sum(nganquy) >= ALL(select sum(nganquy) as tong_tien from bai2.phong
group by (mstruongphong)));
