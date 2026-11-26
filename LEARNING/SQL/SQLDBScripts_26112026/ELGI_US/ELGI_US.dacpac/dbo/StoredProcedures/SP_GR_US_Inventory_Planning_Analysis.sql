CREATE proc [dbo].[SP_GR_US_Inventory_Planning_Analysis]
as
begin

WITH demand_data AS (
    SELECT
        compnr,
        item,
        site,
        AVG(CASE 
            WHEN CAST(CONCAT([year], '-', RIGHT('00' + CAST(peri AS varchar(2)),2), '-01') AS date) >= DATEADD(MONTH,-4,GETDATE())
            THEN COALESCE(acip, 0) 
        END) AS avg_3_month_demand,
        AVG(COALESCE(acip, 0)) AS last_12_months_demand,
        STDEV(CASE 
            WHEN CAST(CONCAT([year], '-', RIGHT('00' + CAST(peri AS varchar(2)),2), '-01') AS date) >= DATEADD(MONTH,-4,GETDATE())
            THEN COALESCE(acip, 0) 
        END) AS last_3_months_stddev,
        STDEV(COALESCE(acip, 0)) AS last_12_months_stddev
    FROM ln_whinr125
    WHERE deleted='N' and  CAST(CONCAT([year], '-', RIGHT('00' + CAST(peri AS varchar(2)),2), '-01') AS date)
          BETWEEN DATEADD(MONTH,-13,GETDATE()) AND DATEADD(MONTH,-1,GETDATE())  
    GROUP BY compnr, item, site
),
forecast_data AS (
    SELECT plni, AVG(quan) AS monthly_demand
    FROM ln_cpdsp200
    WHERE spdt BETWEEN CAST(GETDATE() AS date) AND DATEADD(MONTH,3,GETDATE())
      AND plnc = 'ACT' and deleted='N'
    GROUP BY plni
),
forecast_length AS (
    SELECT plni, MAX(spdt) AS fc_length
    FROM ln_cpdsp200 where deleted='N'
    GROUP BY plni
)
SELECT
    d.compnr,
    d.site,
    mm.clus AS planning_cluster,
    TRIM(d.item) AS item,
    (SELECT i.dsca FROM ln_tcibd001 i WHERE d.item = i.item AND i.compnr = '3100') AS [Desc],
    (SELECT i.cdf_extd FROM ln_tcibd001 i WHERE d.item = i.item AND i.compnr = '3100') AS [ExtDesc],
    d.avg_3_month_demand,
    d.last_12_months_demand,
    COALESCE(d.last_3_months_stddev, 0) AS last_3_months_stddev,
    COALESCE(d.last_12_months_stddev, 0) AS last_12_months_stddev,
    ss.sfst AS safety_stock,
    ss.oqmf AS order_increment,
    COALESCE(f.monthly_demand, 0) AS avg_monthly_demand_next_3_months,
    DATEDIFF(DAY, GETDATE(), fc.fc_length) * 5 / 7 AS forecast_length,
    p.otbp AS vendor,
    p.ugip AS global_purchase,
    p.prip AS unit_price,
    p.suti AS supply_time,
    ss.sfst * COALESCE(p.prip, 0) AS safety_cost,
    (SELECT aitc FROM ln_tcibd004 ics
     WHERE citt = '110' AND ics.item = d.item AND ics.bpid = p.otbp and deleted='N') AS vendpn,
    AVG(CASE 
        WHEN pol.ddte BETWEEN DATEADD(MONTH, -13,GETDATE()) AND DATEADD(MONTH,-1,GETDATE()) 
             AND DATEDIFF(DAY, pol.odat, pol.ddte) > 1 
        THEN DATEDIFF(DAY, pol.odat, pol.ddte)/7*5 
    END) AS avg_lead_time_last_year,
    COUNT(CASE 
        WHEN pol.ddte BETWEEN DATEADD(MONTH, -13,GETDATE()) AND DATEADD(MONTH,-1,GETDATE())
        THEN 1 
    END) AS receipt_count_last_year,
    ROUND(STDEV(CASE 
        WHEN pol.ddte BETWEEN DATEADD(MONTH,-13,GETDATE()) AND DATEADD(MONTH,-1,GETDATE())
        THEN CASE 
                 WHEN DATEDIFF(DAY, pol.odat, pol.ddte)/7*5 - p.suti > 0 
                 THEN DATEDIFF(DAY, pol.odat, pol.ddte)/7*5 - p.suti 
                 ELSE 0 
             END
    END), 0) AS lead_time_stddev_last_year
FROM demand_data d
LEFT JOIN ln_tdpur401 pol
    ON pol.item = d.item AND pol.site = d.site AND d.compnr = pol.compnr and pol.deleted='N'
LEFT JOIN ln_tcibd250 ss
    ON d.item = ss.item AND d.site = ss.site and ss.deleted='N'
LEFT JOIN ln_tcemm050 mm
    ON d.site = mm.site and mm.deleted='N'
LEFT JOIN forecast_data f
    ON CONCAT(mm.clus, d.item) = f.plni
LEFT JOIN forecast_length fc
    ON CONCAT(mm.clus, d.item) = fc.plni
JOIN ln_tdipu081 p
    ON p.item = d.item AND p.compnr = d.compnr AND p.site = d.site and p.deleted='N'
WHERE pol.orno IN (
          SELECT orno FROM ln_tdpur400 poh
          WHERE poh.opor = '' AND pol.orno = poh.orno and poh.deleted='N'
      ) 
   OR pol.orno IS NULL
GROUP BY
    d.compnr, d.item, d.site,
    d.avg_3_month_demand, d.last_12_months_demand,
    d.last_3_months_stddev, d.last_12_months_stddev,
    ss.sfst, ss.oqmf, mm.clus, fc.fc_length, f.monthly_demand,
    p.otbp, p.ugip, p.prip, p.suti
ORDER BY d.avg_3_month_demand DESC;



end

GO

