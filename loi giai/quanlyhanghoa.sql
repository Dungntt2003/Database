select masp, tensp from sanpham
where nuocsx = 'trung quoc';
select masp, tensp from sanpham 
where donvi = 'cay'
intersect select masp, tensp from sanpham 
where donvi = 'quyen';
select masp, tensp from sanpham
where tensp like 'B%01';
select masp, tensp from sanpham where nuocsx = 'trung quoc'
and (trigia > 30000 and trigia < 40000);
select masp, tensp from sanpham where nuocsx = 'trung quoc' or nuocsx = 'thai lan'
and (trigia > 30000 and trigia < 40000);
