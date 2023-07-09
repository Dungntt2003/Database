select * from bai20.monhoc where sotinchi < 3;
select * from bai20.monhoc order by hocphi desc limit 1;
select sum(hocphi)as total_hocphi from bai20.sinhvien join bai20.dangky using (mssv) as C1 join bai20.monhoc using (mamon)
where mssv = '20215009';
select max(diemgk) as max_of_gk, max(diemck) as max_of_ck from bai20.dangky where mssv = '20215009' and mamon = 'IT3290';
select sum(sotinchi) from bai20.dangky join bai20.monhoc using (mamon) where mssv = '202014009';
select (diemgk*0.3 + diemck*0.7)*sotinchi/ (select sum(sotinchi) from bai20.dangky join bai20.monhoc using (mamon) where mssv = '202014009')
 as gpa
from bai20.dangky join bai20.monhoc using (mamon) where mssv = '20214009';
select * from bai20.dangky where mssv = '20215009';
select count(*) as number , mamon from (select * from bai20.dangky where mssv = '20215009') as C1 
group by (mamon) having mamon = 'IT3290' and count(*) = 2;