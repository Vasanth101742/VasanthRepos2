create view vw_Integration_Ledger_list as
Select T$LEAC as leac,T$DESC,concat(t$leac,' - ',T$DESC) as leacname from TTFGLD008ALL
where T$LEAC in 
('EC0401001','EC0101006','EC0301001','EC0301002','EC0301006','EA0100000',
--Below leac added on 31Jul2024
'AA0102001','AA0103001','AA0103013','AA0104001','AA0104004','AA0104016','AA0104019',
'AA0108004','AA0108005')

GO

