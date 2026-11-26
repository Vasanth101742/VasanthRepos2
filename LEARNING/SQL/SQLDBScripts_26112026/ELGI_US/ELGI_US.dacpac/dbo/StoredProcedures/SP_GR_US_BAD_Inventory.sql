CREATE proc [dbo].[SP_GR_US_BAD_Inventory]
as
begin
SET NOCOUNT ON;

--- Old Code 

--WITH site_lookup AS ( SELECT compnr, cwar, site FROM ln_whwmd200 where deleted='N' and compnr between 3100 and 3150 )
--, demand_company AS ( SELECT compnr, item, 1 AS used_flag_company FROM ln_whinr110 
--WHERE CAST(trdt AS date) > DATEADD(MONTH, -12, CAST(GETDATE() AS date)) AND koor IN ('1','3','17','96') AND kost = '5' and deleted='N' and compnr between 3100 and 3150 GROUP BY compnr, item )
--, demand_site AS ( SELECT d.compnr, d.item, s.site, 1 AS used_flag_site FROM ln_whinr110 d JOIN site_lookup s ON d.compnr = s.compnr AND d.cwar = s.cwar 
--WHERE CAST(d.trdt AS date) > DATEADD(MONTH, -12, CAST(GETDATE() AS date)) AND d.koor IN ('1','3','17','96') AND d.kost = '5' and d.deleted='N' and d.compnr between 3100 and 3150 GROUP BY d.compnr, d.item, s.site )
--, available_inventory AS ( SELECT t.cdf_extd AS Alpha, t.dsca AS Description, t.cpln AS MajorCat, t.seak AS TPL, t.ctyp AS Type
--, t.item AS ItemNum, t.citg AS GLTbl, SUM(w.qhnd - w.qall) AS Available, w.compnr, s.site, COALESCE(ss.sfst,0) AS safety_stock 
--FROM ln_tcibd001 t JOIN ln_whwmd215 w ON t.item = w.item AND t.compnr = '3100' and w.deleted='N' JOIN site_lookup s ON w.compnr = s.compnr AND w.cwar = s.cwar 
--LEFT JOIN ln_tcibd250 ss ON w.item = ss.item AND s.site = ss.site and ss.deleted='N' WHERE (w.qhnd - w.qall) > 0 AND w.qall = 0 and t.deleted='N'
--GROUP BY t.cdf_extd, t.cpln, t.dsca, t.seak, t.ctyp, t.item, t.citg, w.compnr, s.site, ss.sfst )
--, purchase_price AS ( SELECT compnr, item, prip AS buy_price, otbp AS vendor_code 
--FROM ( SELECT compnr, item, prip, otbp, ROW_NUMBER() OVER (PARTITION BY compnr, item ORDER BY prip ASC) AS rn FROM ln_tdipu001 where deleted='N' ) x WHERE rn = 1 )
--, last_received_cost AS ( SELECT item, compnr, ROUND(FIRST_VALUE(mauc_1) OVER (PARTITION BY item, compnr ORDER BY CAST(trdt AS date) DESC),2) AS last_cost FROM ln_whina113 where deleted='N' and compnr between 3100 and 3150 )
--SELECT distinct q.Alpha, q.Description, q.Item, (q.Available) AS Sum_Available, (q.[Sales Price]) AS Sum_Sales_Price, q.Type 
--FROM ( SELECT lc.last_cost / 0.9 AS [Sales Price], ai.Alpha, ai.MajorCat, ai.TPL, ai.Description, ai.Type, TRIM(ai.ItemNum) AS Item, ai.GLTbl, ai.Available, ai.compnr, ai.site, ai.safety_stock, lc.last_cost AS Last_Cost
--, COALESCE(lc.last_cost * (ai.Available - ai.safety_stock), 0) AS Ext_Excess_Cost, pp.vendor_code AS Vendor_Code,
--CASE WHEN ds.used_flag_site IS NOT NULL THEN 'Y' ELSE 'N' END AS Used_Last_12_Months_Site, CASE WHEN dc.used_flag_company IS NOT NULL THEN 'Y' ELSE 'N' END AS Used_Last_12_Months_Company 
--FROM available_inventory ai LEFT JOIN demand_site ds ON ai.ItemNum = ds.item AND ai.compnr = ds.compnr AND ai.site = ds.site LEFT JOIN demand_company dc ON ai.ItemNum = dc.item AND ai.compnr = dc.compnr 
--LEFT JOIN purchase_price pp ON ai.ItemNum = pp.item AND ai.compnr = pp.compnr LEFT JOIN last_received_cost lc ON ai.ItemNum = lc.item AND ai.compnr = lc.compnr WHERE ai.compnr > 3000 ) q 
--WHERE q.Used_Last_12_Months_Company = 'N' AND q.Type IN ('102', '103') AND q.compnr = 3110
---Old Code 

TRUNCATE TABLE Bad_Inventory_Report;

;WITH site_lookup AS (
    SELECT compnr, cwar, site 
    FROM ln_whwmd200 
    WHERE deleted='N' 
      AND compnr BETWEEN 3100 AND 3150
),
demand_company AS (
    SELECT compnr, item, 1 AS used_flag_company
    FROM ln_whinr110 
    WHERE CAST(trdt AS date) > DATEADD(MONTH, -12, CAST(GETDATE() AS date))
      AND koor IN ('1','3','17','96')
      AND kost = '5'
      AND deleted='N'
      AND compnr BETWEEN 3100 AND 3150
    GROUP BY compnr, item
),
demand_site AS (
    SELECT d.compnr, d.item, s.site, 1 AS used_flag_site
    FROM ln_whinr110 d
    JOIN site_lookup s 
        ON d.compnr = s.compnr 
       AND d.cwar = s.cwar
    WHERE CAST(d.trdt AS date) > DATEADD(MONTH, -12, CAST(GETDATE() AS date))
      AND d.koor IN ('1','3','17','96')
      AND d.kost = '5'
      AND d.deleted='N'
      AND d.compnr BETWEEN 3100 AND 3150
    GROUP BY d.compnr, d.item, s.site
),
available_inventory AS (
    SELECT
        t.cdf_extd AS Alpha,
        t.dsca AS Description,
        t.ctyp AS Type,
        t.item AS ItemNum,
        SUM(w.qhnd - w.qall) AS Available,
        w.compnr
    FROM ln_tcibd001 t
    JOIN ln_whwmd215 w 
        ON t.item = w.item 
       AND w.deleted='N'
    JOIN site_lookup s 
        ON w.compnr = s.compnr 
       AND w.cwar = s.cwar 
    WHERE (w.qhnd - w.qall) > 0 
      AND w.qall = 0 
      AND t.deleted='N'
    GROUP BY 
        t.cdf_extd,
        t.dsca,
        t.ctyp,
        t.item,
        w.compnr
),
last_received_cost AS (
    SELECT item, compnr,
           ROUND(
               FIRST_VALUE(mauc_1) OVER (
                   PARTITION BY item, compnr 
                   ORDER BY CAST(trdt AS date) DESC
               ),2
           ) AS last_cost
    FROM ln_whina113 
    WHERE deleted='N'
      AND compnr BETWEEN 3100 AND 3150
)

INSERT INTO Bad_Inventory_Report
(
    Alpha,
    Description,
    Item,
    Sum_Available,
    Sum_Sales_Price,
    Type
)
SELECT DISTINCT
    ai.Alpha,
    ai.Description,
    TRIM(ai.ItemNum) AS Item,
    ai.Available,
    lc.last_cost / 0.9 AS Sales_Price,
    ai.Type
FROM available_inventory ai
LEFT JOIN demand_company dc
    ON ai.ItemNum = dc.item
   AND ai.compnr = dc.compnr
LEFT JOIN last_received_cost lc
    ON ai.ItemNum = lc.item
   AND ai.compnr = lc.compnr
WHERE dc.used_flag_company IS NULL
  AND ai.Type IN ('102','103')
  AND ai.compnr = 3110;


  select * from Bad_Inventory_Report

end

GO

