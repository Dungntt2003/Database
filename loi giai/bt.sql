
select distinct student_id from "enrollment" ;
select distinct on (student_id) student_id, semester from "enrollment";
select * from "subject";
select "MON"."name" 
from "subject" as "MON"
where "MON"."credit" > 5;
select * from "student";
select "student_id", concat("first_name",' ',"last_name") as "name" from "student"; 
select * from "clazz";
select "student"."first_name"
from "student", "clazz" 
where "student"."clazz_id" = "clazz"."clazz_id" and "clazz"."name" = 'CNTT2.01-K62';
select * from student;
select student.dob from student;
select * from enrollment;
select * from teaching;
select distinct student.first_name 
from student, subject, enrollment 
where student.student_id = enrollment.student_id 
and subject.subject_id = enrollment.subject_id 
and subject.name = N'Lập trình Java' 
and subject.name = N'Lập trình nhúng';
select distinct student.first_name 
from student, subject, enrollment 
where student.student_id = enrollment.student_id 
and subject.subject_id = enrollment.subject_id 
and subject.name = N'Cơ sở dữ liệu' ;
select distinct student.first_name 
from student, subject, enrollment 
where student.student_id = enrollment.student_id 
and subject.subject_id = enrollment.subject_id 
and subject.name = N'Lập trình Java' 
or subject.name = N'Lập trình nhúng';
select distinct subject.name 
from subject ,  enrollment
where subject.subject_id <> enrollment.subject_id;
select subject.name , subject.credit 
from subject, enrollment, student 
where subject.subject_id = enrollment.subject_id
and student.student_id = enrollment.student_id
and enrollment.semester = '20171'
and concat(student.last_name, ' ',student.first_name) = N'Nguyễn Hoài An';
select student.student_id,clazz.name, clazz.monitor_id 
from clazz, student
where clazz.clazz_id = student.clazz_id;
select enrollment.student_id , count(*) as subject_count , max(final_score), min(final_score)
from enrollment
group by (student_id);
select * from grade;
select * from teaching;
select distinct student.student_id 
from student, enrollment
where enrollment.student_id = student.student_id 
and enrollment.final_score < 3 
or enrollment.midterm_score < 3 
or enrollment.final_score * 0.7 + enrollment.midterm_score* 0.3 < 4;
select enrollment.student_id , count(*) as subject_count , max(final_score), min(final_score)
from enrollment
group by (student_id)
having min(final_score) >5;
select enrollment.student_id from enrollment
where enrollment.subject_id = 'IT3090';
(select enrollment.student_id from enrollment
where enrollment.subject_id = 'IT3090') intersect (select enrollment.student_id from enrollment
where enrollment.subject_id = 'IT1110');
select student_id from 
enrollment 
where subject_id= 'IT3090' order by (student_id) desc;
select student_id from 
enrollment 
where subject_id= 'IT3090' order by (student_id) desc limit 3 offset 0;
select student_id from enrollment 
where subject_id = 'IT3090';
select student_id from enrollment 
where subject_id = 'IT3090';
select distinct concat(first_name , ' ',last_name)
from student, enrollment 
where student.student_id = enrollment.student_id 
and subject_id = 'IT3090';
select concat(first_name , ' ',last_name) 
from student
where student_id in
(select student_id from enrollment where subject_id = 'IT3090');
select distinct student_id from enrollment where final_score >=  (select min(final_score) from enrollment);
select * from subject;
select concat (first_name, ' ',last_name) from student ;
select extract (year from current_date);
select student_id 
from student 
where (2023 - extract(year from dob)> 25);
select student_id 
from student
where extract(month from dob) = '10'
and extract(year from dob) = '1988';
select  clazz_id, count(*) as student_in
from student 
group by clazz_id;
select max(midterm_score), min(midterm_score) , avg (midterm_score) 
from enrollment, subject
where enrollment.subject_id = subject.subject_id
and subject.name = N'Mạng máy tính'
and enrollment.semester  = '20172';
select * from lecturer;
select * from teaching;
select lecturer_id , count (lecturer_id)
from teaching
group by (lecturer_id);
select * from subject
where credit >= 3;
select student_id , concat(first_name,' ',last_name) 
from student, clazz
where student.clazz_id = clazz.clazz_id
and clazz.name = 'CNTT2.01-K62';
select student_id , concat(first_name,' ',last_name) 
from student join clazz
on student.clazz_id = clazz.clazz_id
and clazz.name = 'CNTT2.01-K62';
select student_id , concat(first_name,' ',last_name) 
from student
where clazz_id in 
(select clazz_id from clazz where clazz.name = 'CNTT2.01-K62');
select student_id , concat(first_name,' ',last_name) 
from student
where clazz_id in 
(select clazz_id from clazz where clazz.name like '%CNTT%');
select student_id , concat(first_name,' ',last_name) 
from student
where student_id in
(select student_id from enrollment where subject_id 
in (select subject_id from subject where name = N'Cơ sở dữ liệu'))
intersect 
select student_id , concat(first_name,' ',last_name) 
from student
where student_id in
(select student_id from enrollment where subject_id 
in (select subject_id from subject where name = N'Tin học đại cương'));
select student_id , concat(first_name,' ',last_name) as Ho_va_ten
from student
where student_id in
(select student_id from enrollment where subject_id 
in (select subject_id from subject where name = N'Cơ sở dữ liệu')
intersect select student_id from enrollment where subject_id 
in (select subject_id from subject where name = N'Tin học đại cương' ));
select student_id , concat(first_name,' ',last_name) as Ho_va_ten
from student
where student_id in
(select student_id from enrollment where subject_id 
in (select subject_id from subject where name = N'Cơ sở dữ liệu')
union select student_id from enrollment where subject_id 
in (select subject_id from subject where name = N'Tin học đại cương' ));
select student_id
from student
where student_id in
(select student_id from subject where name = 'Tin học đại cương' or name = 'Cơ sở dữ liệu');
select * from subject 
where subject_id not in 
(select subject_id from enrollment);
select subject_id from subject except (select subject_id from enrollment);
select * from subject
where subject_id  in 
(select subject_id in enrollment where student_id in
(select student_id from student where first_name = 'NGoc An' and last_name = 'Bui')
and semester = '20171')
