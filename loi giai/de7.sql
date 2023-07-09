select name, address from de7.student 
where studentid in (select studentid from de7.take where subjectcode in 
					(select subject.subjectcode from de7.subject where subject.name = 'co so du lieu'));
select name, address from de7.student where address = 'ha noi' and studentid in (select studentid from de7.take where subjectcode in 
					(select subject.subjectcode from de7.subject where subject.name = 'co so du lieu'));
select * from de7.student where studentid in
(select studentid from de7.take group by (studentid) having count (*) = (select count(*) from de7.subject));
select count(*) as tong_so_sinh_vien from (select subjectcode from de7.take where subjectcode = 'su01') as Gop;
select subjectcode, count(*) from de7.take group by (subjectcode) having subjectcode = 'su01';
