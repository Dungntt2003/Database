select * from de3.company;
select name, address from de3.company where address = 'Ha Nam';
select * from de3.company join de3.supply using (companyid) as Gop join de3.product 
using (productid) where numberofem > 1000
and color = 'vang';
select company.name, companyid from de3.company join de3.supply using (companyid) as Gop join de3.product 
using (productid) where color = 'vang';
select * from de3.company 
where companyid not in 
(select companyid from de3.supply);
select * from de3.company 
where (2019 - establishday = 19) ;
select sum(numberofem) from de3.company where address = 'Ha Noi';
select avg(quantity) from de3.company join de3.supply using (companyid) as Gop join de3.product 
using (productid) where company.name = 'Vingroup';
