select mav , tenvaccine from lopkhac.vaccine where mav not in 
(select mav from lopkhac.tiem);
select count(*) from lopkhac.tiem where noitiem = 'Bach Khoa';
select mand, hoten, diachi from lopkhac.nguoidan where mand in 
(select mand from lopkhac.tiem where mav in 
(select mav from lopkhac.vaccine where tenvaccine = 'Pfizer') and muitiem = 3); 
select mand, hoten, diachi, tuoi from lopkhac.nguoidan 
where mand in (select mand from lopkhac.tiem 
group by (mand) having count(*) >=2);
