select * from "Product";
select * from "NCC";
select * from "Provide";
1.select distinct "NCC"."Name"  
from "NCC" join (select * 
from "Product" join "Provide" using ("MSP")) as Gop using ("MCC")
where "Color" = 'red';
2. select distinct "NCC"."Name"  
from "NCC" join (select * 
from "Product" join "Provide" using ("MSP")) as Gop using ("MCC")
where "Color" = 'red' or "Color" = 'white';
3.select distinct "NCC"."Name"  
from "NCC" join (select * 
from "Product" join "Provide" using ("MSP")) as Gop using ("MCC")
where "Color" = 'red' intersect
select distinct "NCC"."Name"  
from "NCC" join (select * 
from "Product" join "Provide" using ("MSP")) as Gop using ("MCC")
where "Color" = 'black';
4. select "MCC" from "NCC" join (select * 
from "Product" join "Provide" using ("MSP")) as Gop using ("MCC")
where "Color" = 'red';
5. select "MCC" from "NCC" join (select * 
from "Product" join "Provide" using ("MSP")) as Gop using ("MCC")
where "Color" = 'red' intersect 
select "MCC" from "NCC" join (select * 
from "Product" join "Provide" using ("MSP")) as Gop using ("MCC")
where "Color" = 'white';
6. select distinct "MCC" from "NCC" join (select * 
from "Product" join "Provide" using ("MSP")) as Gop using ("MCC")
where "Color" = 'red' or "Color" = 'white';
7. select * from "NCC" join "Provide" using ("MCC") as C1;
8. select "MSP", count (*) as So_luong_NCC from "Provide" 
group by ("MSP") having count(*) >=2;
9. select "MSP" from "NCC" join "Provide" using ("MCC") 
where "Money" = (select max("Money") from  "NCC" join "Provide" using ("MCC")
where "Name" = 'Vingroup');
