1. select * from subject 
where credit > 3;
2. select student_id, concat(first_name,' ',last_name) from student 
where student_id in 
(select student_id from clazz where name = 'CNTT2.01-K62');
3. select student_id, concat (student.first_name,' ',student.last_name) from student,clazz 
where student.clazz_id = clazz.clazz_id
and clazz.name like '%CNTT%';
4. select student_id, concat(first_name,' ',last_name) from student 
where student_id in 
(select student_id from enrollment where subject_id in 
(select subject_id from subject where name = 'Cơ sở dữ liệu')
intersect select student_id from enrollment where subject_id in 
(select subject_id from subject where name = 'Tin học đại cương'));
5. select student_id, concat(first_name,' ',last_name) from student 
where student_id in 
(select student_id from enrollment where subject_id in 
(select subject_id from subject where name = 'Cơ sở dữ liệu' or name = 'Tin học đại cương'));
6. select subject_id, subject.name from subject 
where subject_id in 
((select subject_id from subject) except (select subject_id from enrollment));
7. select subject.name, credit from subject where subject_id in  
(select subject_id from enrollment where student_id in
(select student_id from student where last_name = 'Nguyễn' and first_name = 'Nhật Cường')
and semester = '20171');
8. select student_id, concat (first_name,' ',last_name), midterm_score, final_score, (midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100) as subject_score
from subject join (select * from student join enrollment using (student_id)) as Gop using (subject_id)
where subject.name = 'Tin học đại cương' and semester = '20171';
9. select student_id 
from subject join (select * from student join enrollment using (student_id)) as Gop using (subject_id)
where subject_id = 'IT1110' and semester = '20171' 
and (midterm_score < 3 or final_score < 3 or (midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100) < 4);
10. select student_id, concat(first_name,' ',last_name), monitor_id as monitor, name 
from (select * from clazz join student using (clazz_id)) as Gop;