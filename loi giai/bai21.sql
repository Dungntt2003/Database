select orderid, concat(firstname,' ',lastname) as fullname, orderdate, totalamount
from bai21.orders join bai21.customer on orders.customerid = customer.customerid
where extract(month from orderdate) = 6 and extract (year from orderdate ) = 2004;
select * from bai21.products where lower(title) like '%airport%';
select category, count(*) as number_of_pro from bai21.products 
group by (category) ;
select * from bai21.products where prod_id not in 
(select prod_id from bai21.orderlines 
 where extract (month from orderdate) = 12 and extract (year from orderdate) = 2004);
 select * from bai21.customer where customerid in
 (select customerid from bai21.orders);
 select max(age), min(age), avg(age) from bai21.products join bai21.orderlines using (prod_id) as C1 join bai21.orders 
 using (orderid) as C2 join bai21.customer using (customerid)
 where title = 'AIRPORT ROBBERS';
 select prod_id, count(*) as num_of_pro from 
 (select * from bai21.products join bai21.orderlines using (prod_id) where extract (month from orderdate) = 6
 and extract (year from orderdate) =2023) as C1
 group by prod_id order by (count(*)) desc ;
 select distinct * from bai21.customer where customerid in
 (select customerid from bai21.orders where totalamount > 1500);
 select country , count(*) as num_of_cus from bai21.customer group by (country);
 select country, count (*) as num_of_order from bai21.customer join bai21.orders using (customerid) group by (country);
 select * from (select country , count(*) as num_of_cus from bai21.customer group by (country)) as C1 join 
 ( select country, count (*) as num_of_order from bai21.customer join bai21.orders using (customerid) group by (country)) as C2
 using (country);
 select * from bai21.customer join bai21.orders using (customerid) as C1 join bai21.orderlines using 
 (orderid) as C2 join bai21.products using (prod_id) where gender = 'female';
select prod_id , count(*) as number from ( select * from bai21.customer join bai21.orders using (customerid) as C1 join bai21.orderlines using 
 (orderid) as C2 join bai21.products using (prod_id) where gender = 'female') as Gop 
 group by (prod_id) order by (count(*)) desc limit 1;
 select * from bai21.customer join bai21.orders using (customerid) where totalamount > 2000;
 select gender, avg(age) from ( select * from bai21.customer join bai21.orders using (customerid) where totalamount > 2000) as C1
 group by (gender);