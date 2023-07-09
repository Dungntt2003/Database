select * from student;
select * from enrollment;
select * from grade;
select * from lecturer;
select * from subject;
select * from teaching;
select * from clazz;
select * from subject 
where credit > 3;
select * 
from student inner join clazz using (clazz_id);
select student_id, concat(first_name,' ',last_name) 
from student 
where student_id in 
(select student_id from clazz where name = 'CNTT2.01-K62');
select student_id, concat (student.first_name,' ',student.last_name)
from student,clazz
where student.clazz_id = clazz.clazz_id
and clazz.name = 'CNTT2.01-K62';
select student_id, concat(first_name,' ',last_name)
from student
where student_id in 
(select student_id from enrollment where subject_id in 
(select subject_id from subject where name = 'Cơ sở dữ liệu')
intersect select student_id from enrollment where subject_id in 
(select subject_id from subject where name = 'Tin học đại cương'));
select *
from student
where student_id in 
(select student_id from enrollment where subject_id in 
(select subject_id from subject where name = 'Cơ sở dữ liệu')
intersect select student_id from enrollment where subject_id in 
(select subject_id from subject where name = 'Tin học đại cương'));
select student_id, concat(first_name,' ',last_name)
from student
where student_id in 
(select student_id from enrollment where subject_id in 
(select subject_id from subject where name = 'Cơ sở dữ liệu')
union select student_id from enrollment where subject_id in 
(select subject_id from subject where name = 'Tin học đại cương'));
select student_id, concat(first_name,' ',last_name)
from student
where student_id in 
(select student_id from enrollment where subject_id in 
(select subject_id from subject where name = 'Cơ sở dữ liệu' or name = 'Tin học đại cương')); 
select subject_id, subject.name
from subject 
where subject_id not in 
(select subject_id from enrollment);
select subject_id, subject.name 
from subject 
where subject_id in 
((select subject_id from subject) except 
(select subject_id from enrollment));
select subject.name, credit from subject 
where subject_id in  
(select subject_id from enrollment where student_id in
(select student_id from student where last_name = 'Nguyễn' and first_name = 'Nhật Cường')
and semester = '20171');
select * from subject join (select * from student join enrollment using (student_id)) as Gop using (subject_id);
select student_id, concat (first_name,' ',last_name), midterm_score, final_score, (midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100) as subject_score
from subject join (select * from student join enrollment using (student_id)) as Gop using (subject_id)
where subject.name = 'Tin học đại cương' and semester = '20171';
select student_id 
from subject join (select * from student join enrollment using (student_id)) as Gop using (subject_id)
where subject_id = 'IT1110' 
and semester = '20171' 
and (midterm_score < 3 or final_score < 3 or (midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100) < 4);
select clazz_id, concat(first_name,' ',last_name) from 
student 
where student_id in 
(select monitor_id from clazz);
select * from clazz join student using (clazz_id);
with monitor_name as (
select concat(first_name,' ',last_name) from student 
where student_id in 
(select monitor_id from clazz))
select * from monitor_name;
select student_id, concat(first_name,' ',last_name), monitor_id as full_name, name 
from (select * from clazz join student using (clazz_id)) as Gop;
select concat(first_name,' ',last_name) as full_name, (2023 - extract(year from dob)) as age
from student 
where 2023 - extract(year from dob) >=25;
select student_id, concat(first_name,' ',last_name) as full_name
from student 
where extract(year from dob) = 1988 and extract(month from dob) = 10;
select name , count(*) as so_luong
from clazz
group by (clazz_id) order by (so_luong) asc;
select max(midterm_score), min(midterm_score), avg(midterm_score)
from enrollment
where subject_id in 
(select subject_id from subject where name = 'Tin học đại cương') and semester = '20171';
select lecturer_id, count(*) from teaching
group by (lecturer_id) ;
select concat(first_name,' ',last_name) as full_name, lecturer_id, count as so_luong_mon
from (select lecturer_id, count(*) from teaching
group by (lecturer_id)) as Gop join lecturer using (lecturer_id);
select subject_id , count(*) 
from teaching
group by (subject_id)
having  count(*)>= 2;
select subject_id , count(*) 
from teaching
group by (subject_id)
having  count(*)< 2;
select max(midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100)
from subject join (select * from student join enrollment using (student_id)) as Gop using (subject_id)
where subject_id = 'IT1110' and semester = '20171';
select student_id, concat (first_name,' ',last_name) as full_name
from subject join (select * from student join enrollment using (student_id)) as Gop using (subject_id)
where 
midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100 = (select max(midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100)
from subject join (select * from student join enrollment using (student_id)) as Gop using (subject_id)
where subject_id = 'IT1110' and semester = '20171')
and subject_id = 'IT1110' and semester = '20171';
