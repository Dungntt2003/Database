
create table enroll_class (
    student_id char(8),
    class_id char(8),
    time_enroll date,
    primary key (student_id, class_id)
);


--- Them sua xoa tren bang giang vien

select * from lecturer;
--- Them du lieu cho bang giang vien
insert into lecturer (lecturer_id,name, phone, email, year, gender, school) values 
('GV01','Nguyene Huu Duc','0912412667','duc@soict.edu.vn',1967,'Nam','CNTT&TT');
--- Sua bang giang vien
update lecturer set school = 'Co khi' 
where email like '%@cokhi%';
-- Xoa bang giang vien
delete from lecturer where extract (year from now()) - year > 60;

-- 3. Sinh vien co nguy co duoi hoc

select student_id, name from student where warning_level = 3;

--- 6. Chon ra sinh vien truot mon 'Co so du lieu' trong ky 2022.2 (co qua trinh hoac ck < 3 hoac tongket < 4);
select student_id,name from student where student_id in (
select student_id from enrollment join subject using (subject_id)
where midterm_score < 3 or endterm_score < 3 or midterm_score*(1-percentage)+ endterm_score*percentage < 4 and 
subject.name = 'Co so du lieu'); 

--- 9. Chon ra sinh vien hoc mon 'Kien truc may tinh nhieu nhat'
select student_id, name , clazz from student where student_id in
(select student_id from enrollment join subject using (subject_id) 
where subject.name = 'Co so du lieu'
group by (student_id) order by (count(*)) desc limit 1);


---- 12.Danh sách môn học có ít nhất 2 giảng viên phụ trách ky 20211

select subject_id, subject.name from subject where subject_id in
(select subject_id from teaching join class using (class_id) where semester = '20211'
group by (subject_id) having count(*) >=2);


--- 15. Danh sách các lớp môn 'Kiến trúc máy tính' được mở kì ‘20191’

select class_id from class join enrollment using (subject_id) where subject_id in 
(select subject_id from subject where name = 'Kien truc may tinh') and semester = '20191';

---- 18. Liệt kê lớp học ở phòng 301 D9 

select class_id, subject_id from class where place = '301 D9';

--- 21. Đưa ra ds sinh viên và tổng số tín tích lũy trong kỳ 

select * from (select student_id, name from student) as C1 join (select student_id, count(so_tin) as tong_so_tin from enrollment join  subject using (subject_id) where semester = '20211'
group by (student_id)) as C2 using (student_id);



----- ****************************** VIEW
--- 2. DS sinh viên 1 lớp 138898 trong kỳ 20222 
create view danhsachsv as 
select student_id, student.name from student where student_id in
(select student_id from enroll_class join class using (class_id) where 
subject_id in (select subject_id from enrollment where semester = '20222') and class_id = '189989');
select * from danhsachsv;
----- 5. DS lớp được mở kỳ 20203 
create view dslop_20203 as
select class_id, subject_id from class join enrollment using (subject_id) where semester = '20203' 
order by (class_id) desc;
select * from dslop_20203;


----- function / procedure 

---- 2. Cho 1 ma lop, 1 ky hoc tinh so sv tong lop day 

create or replace function num_of_students(lop_id char(100), ky char(100)) returns integer as
$$
declare n integer;
begin
	select into n count(*) from enroll_class join enrollment using (student_id)
	where semester = ky 
	group by (class_id) having class_id = lop_id;
	return n;
end;
$$
language plpgsql;

-- su dung function tren

select num_of_students('1399890','20222');


-----5 . Cho 1 ma sv , kiem tra no bao nhieu tin trong 1 ky 
create or replace function diem_tk (mssv char(10), ky char(10), ma_mon char(10)) returns real 
as $$
declare tongket real;
begin 
	select into tongket (midterm_score* (1-percentage) + percentage* endterm_score)
	from enrollment join subject using (subject_id)
	where student_id = mssv and semester = ky and subject_id = ma_mon;
	return tongket;
end;
$$
language plpgsql;
-- VD : 
select diem_tk('20215009','20222','IT4110');
-- dung cursor :
create or replace function no_mon (mssv char(10),ky char(10)) returns integer
as 
$$
declare so_tin_no integer;
declare f record;
begin 
	so_tin_no := 0;
	for f in select * from enrollment join subject using (subject_id) 
	where subject_id = mssv and semester = ky
	loop
	if ((midterm_score* (1-percentage) + percentage* endterm_score)) < 4  
	or midterm_score < 3
	or endterm_score < 4 then
	so_tin_no := so_tin_no + so_tin;
	end if;
	end loop;
	return so_tin_no;
end;
$$
language plpgsql;

--- demo chay
select no_mon ('20215009','20222');


--- Trigger 

-- 2. Cap nhap so tin no trong ky cho sinh vien 


