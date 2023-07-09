select * from de11.tacgia 
where email like '%gmail.com';
select idtacgia, hoten from de11.tacgia where idtacgia in
(select idtacgia from de11.vietsach where idsach in
(select idsach from de11.sach where tensach = 'Duong xua may trang'));
select idsach, count(*) as dongtacgia from de11.vietsach 
group by (idsach) having idsach = 'TP03';
select idtacgia, sum(nhuanbut) as max_nhuan from de11.vietsach 
group by (idtacgia) having sum(nhuanbut) >= ALL(select sum(nhuanbut) as tiennhuanbut from de11.vietsach
group by (idtacgia));