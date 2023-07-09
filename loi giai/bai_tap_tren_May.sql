select hoten from bai_tap.giangvien
where diachi = 'Hai Ba Trung, Ha Noi'
order by (hoten) desc;
select hoten, diachi, ngaysinh from 
bai_tap.giangvien join bai_tap.thamgia using (gv) as GOP join bai_tap.detai using (dt)
where tendt = 'Tinh toan luoi';
select hoten, diachi, ngaysinh from 
bai_tap.giangvien join bai_tap.thamgia using (gv) as GOP join bai_tap.detai using (dt)
where tendt = 'Phan loai van ban' or tendt = 'Dich tu dong Anh Viet';
select hoten , count(*) as so_luong_dt 
from bai_tap.giangvien join bai_tap.thamgia using (gv) as GOP join bai_tap.detai using (dt)
group by (hoten)
having count(*) >= 2;
select hoten , count(*) as so_luong_dt 
from bai_tap.giangvien join bai_tap.thamgia using (gv) as GOP join bai_tap.detai using (dt)
group by (hoten)
having count(*) >=2 ;
select hoten  
from bai_tap.giangvien join bai_tap.thamgia using (gv) as GOP join bai_tap.detai using (dt)
group by (hoten)
having count(*) >= ALL(select count(*) from bai_tap.giangvien join bai_tap.thamgia using (gv) as GOP join bai_tap.detai using (dt)
group by (hoten));
select tendt from bai_tap.detai 
where kinhphi >= all (select kinhphi from bai_tap.detai);
select hoten, ngaysinh,tendt from bai_tap.giangvien join bai_tap.thamgia using (gv) as GOP join bai_tap.detai using (dt)
where diachi = 'Tay Ho, Ha Noi';
select hoten, ngaysinh,tendt from bai_tap.giangvien join bai_tap.thamgia using (gv) as GOP join bai_tap.detai using (dt)
where tendt = 'Phan loai van ban' ;
select hoten, count(*) as soluongdt, sum(sogio) as so_gio
from bai_tap.giangvien join bai_tap.thamgia using (gv) as GOP join bai_tap.detai using (dt)
group by (hoten);
