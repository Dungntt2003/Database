select * from edu.sinhvien where hoten not like '[NLT]%';
select * from edu.sinhvien where malop = 'CT11';
select * from edu.sinhvien where malop = 'CT11' or malop = 'CT12' or malop = 'CT13';
select * from edu.sinhvien where 2023 - extract (year from ngaysinh) between 19 and 21;
select * from edu.sinhvien where masv in 
(select masv from edu.diemhp where diemhp >=5 );
select * from edu.sinhvien join edu.diemhp using (masv) order by (malop,hoten) desc;
select * from edu.sinhvien join edu.diemhp using (masv) as C1 join edu.hocphan using (mahp) where hocky = '1' and diemhp between 5 and 7;
select * from edu.sinhvien where malop in 
(select malop from edu.lop where manganh in 
(select manganh from edu.nganh where makhoa = 'CNTT'));
select tenlop, malop, count(*) as so_sinh_vien from edu.sinhvien join edu.lop using (malop) 
group by (malop, tenlop);
select * from edu.diemhp;
select * from edu.hocphan;
select masv, sum (diemhp*sotin)/sum(sotin) as Diemtbc from edu.diemhp join edu.hocphan using (mahp) 
group by (masv);
select masv,hocky, sum (diemhp*sotin)/sum(sotin) as Diemtbc from edu.diemhp join edu.hocphan using (mahp) 
group by (masv,hocky);
select masv,hocky, sum (diemhp*sotin)/sum(sotin) as Diemtbc from edu.diemhp join edu.hocphan using (mahp) 
group by (masv,hocky) having hocky = '1';
select * from edu.sinhvien join edu.diemhp using (masv) as C1 join edu.hocphan using (mahp)
where diemhp < 5;
select hoten, masv, count(*) as so_mon from (select * from edu.sinhvien join edu.diemhp using (masv) as C1 join edu.hocphan using (mahp)
where diemhp < 5) as C1 group by (masv, hoten);
select hoten, masv, sum(sotin) as so_mon from (select * from edu.sinhvien join edu.diemhp using (masv) as C1 join edu.hocphan using (mahp)
where diemhp < 5) as C1 group by (masv, hoten);

select malop, count(*) as total_sv from edu.sinhvien group by (malop) having count(*) >10;
select * from edu.sinhvien where masv in 
(select masv from edu.diemhp join edu.hocphan using (mahp) 
group by (masv) having sum (diemhp*sotin)/sum(sotin) < 3);
select * from edu.sinhvien where masv in 
(select masv from (select * from edu.diemhp where diemhp <5) as C1
 group by (masv) having count(*) >= 2);
 select count(*) from edu.hocphan where manganh = '14902';
 select * from edu.sinhvien where masv in 
 (select masv from edu.diemhp join edu.hocphan using (mahp) where
 manganh = '14902' group by (masv) having count(*) =
 (select count(*) from edu.hocphan where manganh = '14902'));
 select hoten, count(*) as soluong from edu.sinhvien join edu.diemhp using (masv)
 where mahp in ('001','002','003') group by (hoten)
 having count(*) >=3;
 select malop, tenlop from edu.lop join edu.sinhvien using (malop) group by (malop,tenlop)
 having count(*) >10;
 select hoten from edu.sinhvien join edu.diemhp using (masv) as C1 join edu.hocphan using (mahp) group by (masv)
 having sum(diemhp* sotin) / sum(sotin) <3;
 select hoten from edu.sinhvien join edu.diemhp using (masv) as C1 join edu.hocphan using (mahp)
 where diemhp < 5 group by (hoten) having count(*) >=2;
 select masv, hoten from edu.sinhvien join edu.diemhp using (masv) as C1 join edu.hocphan using (mahp)
 group by(masv, hoten) order by (sum(diemhp*sotin)/sum(sotin)) desc limit 1;
 select masv, hoten from edu.sinhvien join edu.diemhp using (masv) as C1 join edu.hocphan using (mahp)
 where diemhp < 5 group by (masv, hoten) order by (count(*)) desc limit 1;
  select mahp,tenhp from edu.sinhvien join edu.diemhp using (masv) as C1 join edu.hocphan using (mahp)
 where diemhp < 5 group by (mahp, tenhp) order by (count(*)) desc limit 1