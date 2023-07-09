select * from de1.hanghoa;
select * from de1.nhanvien;
select quequan,count(*) from de1.nhanvien
group by(quequan) having quequan = 'Quang Ninh';
select tenhh from de1.hanghoa 
where dongia >= ALL(select dongia from de1.hanghoa);
select * from de1.chitiet;
select * from de1.hoadon;
select * from de1.chitiet join de1.hoadon using (mahd);
select soluong from de1.chitiet join de1.hoadon using (mahd)
where mahh = 'HH01' and ngaylap ='2023-02-14';
select tennv from de1.nhanvien
where manv not in  
(select manv from de1.hoadon );
select soluong*dongia, mahh, tenhh from de1.chitiet join de1.hanghoa using (mahh) as Gop join de1.hoadon using (mahd)
where ngaylap = '2023-02-14';
select * from de1.hanghoa join de1.chitiet using (mahh) as Gop join de1.hoadon using (mahd);