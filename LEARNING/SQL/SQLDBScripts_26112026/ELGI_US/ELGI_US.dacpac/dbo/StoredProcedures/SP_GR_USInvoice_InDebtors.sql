 
CREATE proc [dbo].[SP_GR_USInvoice_InDebtors]
as begin

DECLARE @TBL_G AS TABLE                
(                
ID    INT IDENTITY(1,1),                
docno   int                   
)  

  insert into @TBL_G
  select Slno from [USINVOCIE_JSON] a 
  left join acr_debtors_US b on b.ttyp=left(a.ninv,3)  and b.ninv=right(a.ninv,8) and b.compnr=a.Compnr and  b.OutstandingAmth>0
  where DocStatus='O' and isnull(b.compnr,'')='' 
  order by Slno

DECLARE @STARTID AS INT                
DECLARE @ENDID AS INT                
DECLARE @DocNo AS INT                      
            
                
SET @STARTID = 1                
SET @ENDID = (SELECT COUNT(*) FROM @TBL_G)                
                
WHILE( @STARTID < = @ENDID )                
BEGIN                
                
set @DocNo =(select docno from @TBL_G where ID=@STARTID) 

INSERT INTO [dbo].[acr_debtors_US]
([compnr],[ttyp],[ninv],[line],[itbp],[ccur],[rate_1],[docd],[prod],[year],[InvAmth],[PaidAmth],[OutstandingAmth]
,[BPName],[refnumber],[paymentstatus],[payment_date],[dued],[Ageing],[AgeingOrder],[DueType])

select Compnr,left(ninv,3),right(ninv,8),0,itbp,ccur,1,docd,1,[Year],amti,0,amti
,nama,Slno,'Pending',null,dued,Ageing,AgeingOrder,DueType from [USINVOCIE_JSON] 
where Slno=@DocNo

update [USINVOCIE_JSON] set DocStatus='C' where Slno=@DocNo

SET @STARTID = @STARTID + 1                
END 

end

GO

