11. select concat(first_name,' ',last_name) as full_name, (2023 - extract(year from dob)) as age
from student where 2023 - extract(year from dob) >=25;
12. select student_id, concat(first_name,' ',last_name) as full_name
from student where extract(year from dob) = 1988 and extract(month from dob) = 10;
13. select name , count(*) as so_luong
from clazz group by (clazz_id) order by (so_luong) desc;
14. select max(midterm_score), min(midterm_score), avg(midterm_score)
from enrollment where subject_id in 
(select subject_id from subject where name = 'Tin học đại cương') and semester = '20171';
15. select concat(first_name,' ',last_name) as full_name, lecturer_id, count as so_luong_mon
from (select lecturer_id, count(*) from teaching
group by (lecturer_id)) as Gop join lecturer using (lecturer_id);
16. select subject_id , count(*) as lecturer_in_charge
from teaching group by (subject_id) having  count(*)>= 2;
17. select subject_id , count(*) as lecturer_in_charge
from teaching group by (subject_id) having  count(*)< 2;
18. select student_id, concat (first_name,' ',last_name) as full_name
from subject join (select * from student join enrollment using (student_id)) as Gop using (subject_id)
where midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100 = (select max(midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100)
from subject join (select * from student join enrollment using (student_id)) as Gop using (subject_id)
where subject_id = 'IT1110' and semester = '20171')
and subject_id = 'IT1110' and semester = '20171';