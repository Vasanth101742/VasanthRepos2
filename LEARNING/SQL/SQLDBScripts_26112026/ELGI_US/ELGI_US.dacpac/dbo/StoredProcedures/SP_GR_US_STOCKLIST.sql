CREATE proc [dbo].[SP_GR_US_STOCKLIST]

as 
begin 



--	WITH CommonData AS (
--    SELECT
--        im.item,
--        im.cdf_extd AS alpha,
--        CAST(im.cpln AS NVARCHAR) AS major_cat,
--        CAST(im.citg AS NVARCHAR) AS gl_tbl,
--        MAX(CASE WHEN attr.attr = 'Horsepower' THEN CAST(attr.valu AS decimal) END) AS hp,
--        MAX(CASE WHEN attr.attr = 'Group' THEN CAST(attr.valu AS NVARCHAR) END) AS gp,
--        MAX(CASE WHEN attr.attr = 'Series' THEN CAST(attr.valu AS NVARCHAR) END) AS se,
--        MAX(CASE WHEN attr.attr = 'Pressure' THEN CAST(attr.valu AS NVARCHAR) END) AS pr,
--        MAX(CASE WHEN attr.attr = 'Speed Control' THEN CAST(attr.valu AS NVARCHAR) END) AS sc,
--        MAX(CASE WHEN attr.attr = 'Cooling Type' THEN CAST(attr.valu AS NVARCHAR) END) AS ct,
--        MAX(CASE WHEN attr.attr = 'Voltage' THEN CAST(attr.valu AS NVARCHAR) END) AS vt
--    FROM  ln_tcibd001 AS im 
--    LEFT JOIN  ln_txibd006 AS attr ON attr.item = im.item and attr.deleted='N'
--    WHERE im.compnr='3100' and im.deleted='N'
--    GROUP BY im.item, im.cdf_extd, CAST(im.cpln AS NVARCHAR), CAST(im.citg AS NVARCHAR)
--),
--Warehouse AS (
--	SELECT
--		wh.site,
--		wh.cwar,
--		isite.item,
--		isite.srce_kw AS srce
--	FROM  ln_tcibd150 AS isite
--	JOIN  ln_whwmd200 AS wh ON isite.site=wh.site and wh.deleted='N'
--	where isite.deleted='N' -- and isite.compnr between 3100 and 3150
--),
--StockData AS (
--    SELECT
--        CASE 
--            WHEN stock.cwar IN ('110CLT','120PCD') THEN 'EAST'
--            WHEN stock.cwar = '110LAX' THEN 'WEST'
--            ELSE 'OTHER'
--        END AS coast,
--        stock.compnr,
--        CAST('2000-01-01' AS date) AS mrp_date,
--        common.alpha,
--        common.major_cat,
--        TRIM(stock.item) AS item_num,
--        common.gl_tbl,
--        stock.qhnd - stock.qall - stock.qblk AS available,
--        '' AS bp,
--        '' AS orno,
--        0 AS pono,
--        0 AS ponb,
--        '' AS asnr,
--        0 AS asn_line,
--        CAST('2000-01-01' AS date) AS PromiseDate,
--        common.hp,
--        common.gp,
--        common.se,
--        common.pr,
--        common.sc,
--        common.ct,
--        common.vt,
--        warehouse.site,
--        warehouse.srce AS "source",
--        warehouse.cwar
--    FROM  ln_whwmd215 AS stock
--    JOIN CommonData AS common ON common.item = stock.item
--    JOIN Warehouse AS warehouse ON warehouse.item=stock.item AND stock.cwar=warehouse.cwar
--    WHERE ((stock.qhnd - stock.qall - stock.qblk > 0 AND warehouse.srce='tcsrce.shopfloor') OR (stock.qhnd - stock.qall - stock.qblk <> 0 AND NOT warehouse.srce='tcsrce.shopfloor'))
--	and stock.deleted='N'
--),
--IncomingData AS (
--    SELECT
--        CASE 
--            WHEN incoming.cwar IN ('110CLT','120PCD') THEN 'EAST'
--            WHEN incoming.cwar = '110LAX' THEN 'WEST'
--            ELSE 'OTHER'
--        END AS coast,
--        incoming.compnr,
--        CAST(incoming."date" AS date) AS mrp_date,
--        common.alpha,
--        common.major_cat,
--        TRIM(incoming.item) AS item_num,
--        common.gl_tbl,
--        incoming.qana,
--        incoming.bfst,
--        incoming.orno,
--        incoming.pono,
--        incoming.ponb,
--        ash.asnr,
--        asn.shsq AS asn_line,
--        CAST(ash.pddt AS date) AS asn_date,
--        common.hp,
--        common.gp,
--        common.se,
--        common.pr,
--        common.sc,
--        common.ct,
--        common.vt,
--        warehouse.site,
--        warehouse.srce,
--        warehouse.cwar
--    FROM  ln_whinp100 AS incoming
--    JOIN CommonData AS common ON common.item = incoming.item
--    JOIN Warehouse AS warehouse ON warehouse.item=incoming.item AND incoming.cwar=warehouse.cwar
--    LEFT JOIN  ln_whinh301 AS asn ON incoming.orno = asn.worn AND incoming.pono = asn.wpon AND incoming.ponb = asn.wsqn and asn.deleted='N'
--    LEFT JOIN  ln_whinh300 AS ash ON asn.shid = ash.shid AND asn.compnr = ash.compnr and ash.deleted='N'
--    WHERE incoming.kotr = 1 and incoming.bpid_ref_compnr='3100' AND NOT warehouse.srce='tcsrce.shopfloor' and incoming.deleted='N'
--)
--select * from (
--SELECT *,'Stock'as'Ttype',case when convert(NVARCHAR,(DATEDIFF(WEEK,getdate(),PromiseDate)))<0 then 'Available'else '0' end 'No.Of.Week'
--,(getdate() AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time' AS DateTime_EST ,0 as short,case when alpha like '%575%' or  alpha like '%1ph%' then 1 else 0 end 'ColorCode' FROM StockData
-- WHERE gl_tbl IN ('582','551') and compnr IN (3110,3120)

--UNION ALL

--SELECT *,'Future'as'Ttype',case when convert(NVARCHAR,DATEDIFF(WEEK,getdate(),asn_date))<=0 then '1' else convert(NVARCHAR,DATEDIFF(WEEK,getdate(),asn_date)) end  'No.Of.Week'
--,(getdate() AT TIME ZONE 'India Standard Time')  AT TIME ZONE 'Eastern Standard Time' AS DateTime_EST 
--,case when convert(NVARCHAR,DATEDIFF(WEEK,getdate(),asn_date))<=0 then '1' else convert(NVARCHAR,DATEDIFF(WEEK,getdate(),asn_date)) end  as short,case when alpha like '%575%' or  alpha like '%1ph%' then 1 else 0 end 'ColorCode'  FROM IncomingData
--WHERE gl_tbl  IN ('582','551') and asnr IS NOT NULL and coast IN ('EAST','WEST'))  a
--order by se,hp,vt


SET NOCOUNT ON;

TRUNCATE TABLE Stock_Report;  

;WITH CommonData AS (
    SELECT
        im.item,
        im.cdf_extd AS alpha,
        CAST(im.cpln AS VARCHAR(50)) AS major_cat,
        CAST(im.citg AS VARCHAR(50)) AS gl_tbl,
      MAX(CASE WHEN attr.attr = 'Horsepower' THEN CAST(attr.valu AS DECIMAL(19,2))END) AS hp,
        MAX(CASE WHEN attr.attr = 'Group' THEN CAST(attr.valu AS VARCHAR(50)) END) AS gp,
        MAX(CASE WHEN attr.attr = 'Series' THEN CAST(attr.valu AS VARCHAR(50)) END) AS se,
        MAX(CASE WHEN attr.attr = 'Pressure' THEN CAST(attr.valu AS VARCHAR(50)) END) AS pr,
        MAX(CASE WHEN attr.attr = 'Speed Control' THEN CAST(attr.valu AS VARCHAR(50)) END) AS sc,
        MAX(CASE WHEN attr.attr = 'Cooling Type' THEN CAST(attr.valu AS VARCHAR(50)) END) AS ct,
        MAX(CASE WHEN attr.attr = 'Voltage' THEN CAST(attr.valu AS VARCHAR(50)) END) AS vt
    FROM ln_tcibd001 im
    LEFT JOIN ln_txibd006 attr 
        ON attr.item = im.item 
       AND attr.deleted='N'
    WHERE im.compnr='3100' 
      AND im.deleted='N'
    GROUP BY 
        im.item, 
        im.cdf_extd, 
        CAST(im.cpln AS VARCHAR(50)), 
        CAST(im.citg AS VARCHAR(50))
),
Warehouse AS (
    SELECT
        wh.site,
        wh.cwar,
        isite.item,
        isite.srce_kw AS srce
    FROM ln_tcibd150 isite
    JOIN ln_whwmd200 wh 
        ON isite.site = wh.site 
       AND wh.deleted='N'
    WHERE isite.deleted='N'
),
StockData AS (
    SELECT
        CASE 
            WHEN stock.cwar IN ('110CLT','120PCD') THEN 'EAST'
            WHEN stock.cwar = '110LAX' THEN 'WEST'
            ELSE 'OTHER'
        END AS coast,
        stock.compnr,
        CAST('2000-01-01' AS DATE) AS mrp_date,
        common.alpha,
        common.major_cat,
        TRIM(stock.item) AS item_num,
        common.gl_tbl,
        stock.qhnd - stock.qall - stock.qblk AS available,
        '' AS bp,
        '' AS orno,
        0 AS pono,
        0 AS ponb,
        '' AS asnr,
        0 AS asn_line,
        CAST('2000-01-01' AS DATE) AS PromiseDate,
        common.hp,
        common.gp,
        common.se,
        common.pr,
        common.sc,
        common.ct,
        common.vt,
        warehouse.site,
        warehouse.srce AS source,
        warehouse.cwar
    FROM ln_whwmd215 stock
    JOIN CommonData common 
        ON common.item = stock.item
    JOIN Warehouse warehouse 
        ON warehouse.item = stock.item 
       AND stock.cwar = warehouse.cwar
    WHERE stock.deleted='N'
      AND (
            (stock.qhnd - stock.qall - stock.qblk > 0 AND warehouse.srce='tcsrce.shopfloor')
         OR (stock.qhnd - stock.qall - stock.qblk <> 0 AND warehouse.srce<>'tcsrce.shopfloor')
      )
),
IncomingData AS (
    SELECT
        CASE 
            WHEN incoming.cwar IN ('110CLT','120PCD') THEN 'EAST'
            WHEN incoming.cwar = '110LAX' THEN 'WEST'
            ELSE 'OTHER'
        END AS coast,
        incoming.compnr,
        CAST(incoming.date AS DATE) AS mrp_date,
        common.alpha,
        common.major_cat,
        TRIM(incoming.item) AS item_num,
        common.gl_tbl,
        incoming.qana AS available,
        incoming.bfst AS bp,
        incoming.orno,
        incoming.pono,
        incoming.ponb,
        ash.asnr,
        asn.shsq AS asn_line,
        CAST(ash.pddt AS DATE) AS PromiseDate,
        common.hp,
        common.gp,
        common.se,
        common.pr,
        common.sc,
        common.ct,
        common.vt,
        warehouse.site,
        warehouse.srce AS source,
        warehouse.cwar
    FROM ln_whinp100 incoming
    JOIN CommonData common 
        ON common.item = incoming.item
    JOIN Warehouse warehouse 
        ON warehouse.item = incoming.item 
       AND incoming.cwar = warehouse.cwar
    LEFT JOIN ln_whinh301 asn 
        ON incoming.orno = asn.worn 
       AND incoming.pono = asn.wpon 
       AND incoming.ponb = asn.wsqn 
       AND asn.deleted='N'
    LEFT JOIN ln_whinh300 ash 
        ON asn.shid = ash.shid 
       AND asn.compnr = ash.compnr 
       AND ash.deleted='N'
    WHERE incoming.kotr = 1 
      AND incoming.bpid_ref_compnr='3100'
      AND warehouse.srce<>'tcsrce.shopfloor'
      AND incoming.deleted='N'
)
INSERT INTO Stock_Report
(
    coast, compnr, mrp_date, alpha, major_cat,
    item_num, gl_tbl, available, bp, orno,
    pono, ponb, asnr, asn_line, PromiseDate,
    hp, gp, se, pr, sc, ct, vt,
    site, source, cwar,
    Ttype, NoOfWeek, DateTime_EST, short, ColorCode
)

SELECT
    coast, compnr, mrp_date, alpha, major_cat,
    item_num, gl_tbl, convert(decimal(19,0),available), bp, orno,
    pono, ponb, asnr, asn_line, PromiseDate,
    convert(decimal(19,2),hp), gp, se, pr, sc, ct, vt,
    site, source, cwar,
    Ttype, NoOfWeek, DateTime_EST, short, ColorCode
FROM
(
    SELECT
        coast, compnr, mrp_date, alpha, major_cat,
        item_num, gl_tbl, available, bp, orno,
        pono, ponb, asnr, asn_line, PromiseDate,
        hp, gp, se, pr, sc, ct, vt,
        site, source, cwar,
        'Stock' AS Ttype,
        CASE 
            WHEN DATEDIFF(WEEK, GETDATE(), PromiseDate) < 0 
            THEN 'Available'
            ELSE '0'
        END AS NoOfWeek,
        (GETDATE() AT TIME ZONE 'India Standard Time') 
            AT TIME ZONE 'Eastern Standard Time' AS DateTime_EST,
        0 AS short,
        CASE 
            WHEN alpha LIKE '%575%' OR alpha LIKE '%1ph%' 
            THEN 1 ELSE 0 
        END AS ColorCode
    FROM StockData
    WHERE gl_tbl IN ('582','551') 
      AND compnr IN (3110,3120)

    UNION ALL

    SELECT
        coast, compnr, mrp_date, alpha, major_cat,
        item_num, gl_tbl, available, bp, orno,
        pono, ponb, asnr, asn_line, PromiseDate,
        hp, gp, se, pr, sc, ct, vt,
        site, source, cwar,
        'Future' AS Ttype,
        CASE 
            WHEN DATEDIFF(WEEK, GETDATE(), PromiseDate) <= 0 
            THEN '1'
            ELSE CONVERT(VARCHAR(10), DATEDIFF(WEEK, GETDATE(), PromiseDate))
        END,
        (GETDATE() AT TIME ZONE 'India Standard Time') 
            AT TIME ZONE 'Eastern Standard Time',
        CASE 
            WHEN DATEDIFF(WEEK, GETDATE(), PromiseDate) <= 0 
            THEN 1
            ELSE DATEDIFF(WEEK, GETDATE(), PromiseDate)
        END,
        CASE 
            WHEN alpha LIKE '%575%' OR alpha LIKE '%1ph%' 
            THEN 1 ELSE 0 
        END
    FROM IncomingData
    WHERE gl_tbl IN ('582','551') 
      AND asnr IS NOT NULL 
      AND coast IN ('EAST','WEST')

) a order by  se,hp,vt


SELECT [coast],[compnr],[mrp_date],[alpha],[major_cat],[item_num],[gl_tbl],convert(decimal(19,2),[available])available,[bp],[orno],[pono]
,[ponb],[asnr],[asn_line],[PromiseDate],convert(decimal(19,2),[hp])hp,[gp],[se],[pr],[sc],[ct],[vt],[site],[source],[cwar],[Ttype]
,[NoOfWeek],[DateTime_EST],[short],[ColorCode],[InsertDate]
  FROM [dbo].[Stock_Report]


end

GO

