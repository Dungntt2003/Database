select * from general.giangvien where diachi = 'Hai Ba Trung' order by (hoten) desc;
select hoten, diachi, ngaysinh from general.giangvien where giangvienid in
(select giangvienid from general.thamgia where detaiid in 
(select detaiid from general.detai where tendt = 'Tinh toan luoi'));
select hoten, diachi, ngaysinh from general.giangvien where giangvienid in
(select giangvienid from general.thamgia where detaiid in 
(select detaiid from general.detai where tendt = 'Phan loai van ban' or tendt = 'Dich tu dong Anh Viet')); 
select * from general.giangvien where giangvienid in 
(select giangvienid from general.thamgia group by (giangvienid) having count(*) >=2);
select * from general.giangvien where giangvienid in 
(select giangvienid from general.thamgia group by (giangvienid) order by (count(*)) desc limit 1);
select * from general.detai where kinhphi <= ALL (select kinhphi from general.detai);
select hoten, tendt from general.giangvien join general.thamgia using (giangvienid) as C1 join general.detai using (detaiid) 
where diachi = 'Tay Ho';
select * from general.giangvien join general.thamgia using (giangvienid) as C1 join general.detai using (detaiid)
where extract (year from ngaysinh) < 1980 and tendt = 'Phan loai van ban';
