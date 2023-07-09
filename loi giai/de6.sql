select * from de6.sinhvien where quequan = 'Ha Nam';
select * from de6.sinhvien where mssv in 
(select mssv from de6.hoc where mamon 
in (select mamon from de6.monhoc where tenmon = 'Co so du lieu'));
select mamon, count(*) from de6.hoc 
group by (mamon) having mamon = 'HP02';
select mssv, count(*) from de6.hoc group by (mssv) 
having count(*) = (select count(*) from de6.monhoc);
select quequan, count(*) from (select * from de6.sinhvien where gioitinh = 'nu' and cpa >=3.2) as Gop
group by (quequan) having quequan = 'Ha Nam';

