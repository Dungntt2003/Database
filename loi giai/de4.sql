select tenhp from de4.hocphan join de4.ctdt using (mactdt)
where khoavien = 'CNTT & TT';
select * from de4.ctdt where khoavien = 'CNTT & TT';
select tenhp,sotctl, sogiobt + sogioth as tinchihp from de4.hocphan;
select * from de4.dkht join de4.hocphan using (mahp) where 
tenhp = 'ly 3';
select tenhp from de4.hocphan join de4.ctdt using (mactdt)
where tenctdt = 'Viet Nhat' intersect select tenhp from de4.hocphan join de4.ctdt using (mactdt)
where tenctdt = 'Viet Phap';
select mahp, max(diemqt) as dqt_cao_nhat, max(diemck) as diem_ck_cao_nhat, avg(diemqt) as tb, avg(diemck) as trung_binh from de4.dangky
group by (mahp);
select * from de4.sinhvien;
select masv, sum(tctl) from 
(select masv, 1* sotctl as tctl from de4.dangky join de4.hocphan using (mahp)) as Gop
group by (masv);

