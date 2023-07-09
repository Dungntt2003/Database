select * from bai16.company where address = 'London';
select * from bai16.company where 2023 - extract(year from establishday) = 110 and extract(month from establishday) = 11; 
select product.name, color, price, quantity from bai16.company join bai16.supply using (companyid) as C1 join bai16.product using (productid)
where company.name = 'Audi';
select * from bai16.company join bai16.supply using (companyid) as C1 join bai16.product using (productid)
where quantity > 2000;
select companyid , count(*) as num_of_supply from (select * from bai16.company join bai16.supply using (companyid) as C1 join bai16.product using (productid)
where quantity > 2000) as C2 group by (companyid) having count(*) >=2;
select * from bai16.company where companyid in 
(select companyid from bai16.supply where productid in 
(select productid from bai16.product where 
color = 'black'));
select * from bai16.company join bai16.supply using (companyid) as C1 join bai16.product using (productid) where 
company.name = 'Porche';
select productid , count(quantity) as num_of_quan from  (select * from bai16.company join bai16.supply using (companyid) as C1 join bai16.product using (productid) where 
company.name = 'Porche') as C2 group by (productid);
select * from bai16.company where companyid not in 
(select companyid from bai16.supply);