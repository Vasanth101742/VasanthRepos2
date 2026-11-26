



CREATE proc [dbo].[SP_PROC]
as
begin
select cadr,nama,namc,pstc,ccit,dsca,ccty,LN01,LN02,LN03 from LN_TCCOM130 a
where compnr='3100'
end

GO

