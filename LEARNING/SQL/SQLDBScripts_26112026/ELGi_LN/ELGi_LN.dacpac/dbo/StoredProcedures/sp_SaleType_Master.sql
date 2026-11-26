
CREATE proc sp_SaleType_Master as
begin

Truncate table SaleType_Master
insert into saletype_master(company,saleordertype,Sales_Category,Remarks)
select distinct  company,saleordertype,0 as Sales_Category,'Considered' from elgi_sales_details 
where Invoice_Date>='2017-04-01'
order by company,saleordertype

insert into saletype_master
select distinct  company,ordertype,0 as Sales_Category,'Considered' from Sales_Inflow 
where OrderDate>='2017-04-01'
and company like '4%'
and concat(company,ordertype) not in (select distinct concat(company,SaleOrderType) from saletype_master)
order by company,ordertype



update saletype_master set Sales_Category =1 where company = 490 and saleordertype in
--('226','246','270','284','326','346','384','544','526','546','FCA','FC9','FCT')  ---- REMOVED THESE SOT DUE TO KISHORE REQUEST 236,332,516
('226','246','326','346','526','546','FCA','FCT','FC9','523','223','323','270','370','284','384' --- Kishore req ason 08-01-2019 updated sotypes
,'244','297','299')-- Kishore mail dated 19-8-2022


update saletype_master set Sales_Category =1 where company = 401 and saleordertype in 
--('223','240','244','246','225','252','344','523','RGS','516','526','544','546','FCA','FC9','FCT')
('226','246','269','326','346','526','546','FCA','FCT','FC9','223','323','523','244','344','544','268','270') --- Kishore req ason 08-01-2019 

update saletype_master set Sales_Category =1 where company = 440 and saleordertype in('223','225','226','244','344','FCA','FC9','FCT')
update saletype_master set Sales_Category =1 where company = 450 and saleordertype in('A14','244','FCA','FC9','FCT','285')
update saletype_master set Sales_Category =1 where company = 465 and saleordertype in('212','214','715')
update saletype_master set Sales_Category =1 where company = 470 and saleordertype in('P13')

update saletype_master set Sales_Category =1 where company = 553 and saleordertype in('230')

--Adlin SR Request : O6C00126470
update saletype_master set Sales_Category =1 where company = 401 and saleordertype in ('SR3')
update saletype_master set Sales_Category =1 where company = 440 and saleordertype in ('223')
update saletype_master set Sales_Category =1 where company = 490 and saleordertype in ('234')

update SaleType_Master set Remarks='Not Considerd' where Sales_Category=1

end

GO

