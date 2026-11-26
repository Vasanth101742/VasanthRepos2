

Create procedure sp_PTOOrderinflowDetails as 
select * from Sales_Inflow where trim (itemcode) in ('S07003','S07005','S07007','S07011','S07013'
,'S07050','S07066','S07087','S07096','Z07002','Z07034','Z07040','S07106','S07067')

GO

