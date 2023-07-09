select * from de2.benhnhan;
select * from de2.bacsi;
select * from de2.dieutri;
select tenbn from de2.benhnhan join de2.dieutri using (msbn)
where ngaynhapvien = '2023-02-23';
select tenbn from de2.benhnhan join de2.dieutri using (msbn) as Gop join de2.bacsi using (idbacsi)
where ten = 'Nguyen Quynh Trang';
select ten, count (*) 
from de2.benhnhan join de2.dieutri using (msbn) as Gop join de2.bacsi using (idbacsi)
group by (ten) ;
select tenbn from de2.benhnhan join de2.dieutri using (msbn)
where tenbenh = 'mat' intersect select tenbn from de2.benhnhan join de2.dieutri using (msbn)
where tenbenh = 'tao bon';
select tenbn, count (*)
from de2.benhnhan join de2.dieutri using (msbn) as Gop join de2.bacsi using (idbacsi)
group by (tenbn) having count (*) >= ALL (select count(*) from de2.benhnhan join de2.dieutri using (msbn) as Gop join de2.bacsi using (idbacsi)
group by (tenbn));
select ten from de2.bacsi 
where idbacsi not in (select idbacsi from de2.dieutri where tenbenh = 'da');
select diachi, count(*)  from de2.benhnhan join de2.dieutri using (msbn) as Gop join de2.bacsi using (idbacsi)
group by (diachi) having count (*) >= ALL (select count(*) from de2.benhnhan join de2.dieutri using (msbn) as Gop join de2.bacsi using (idbacsi)
group by (diachi));
