select * from cauthu;
select macauthu, hoten, so, vitri, ngaysinh from cauthu;
select * from cauthu
where so = '7' and vitri = 'Tien ve';
select * from 
cauthu join quocgia using (maqg) as Gop join caulacbo using (maclb)
where tenqg = 'Viet Nam' and tenclb = 'BECAMEX BINH DUONG';
select macauthu, hoten, ngaysinh,vitri from 
cauthu join quocgia using (maqg) as Gop join caulacbo using (maclb)
where tenqg = 'Brazin' and tenclb = 'SHB DA NANG';
