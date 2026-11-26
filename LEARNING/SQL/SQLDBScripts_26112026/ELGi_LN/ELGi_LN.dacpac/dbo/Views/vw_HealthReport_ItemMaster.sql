CREATE View vw_HealthReport_ItemMaster as
SELECT DISTINCT 
    LTRIM(RTRIM(a.ITEM)) AS ItemCode,
    CASE 
        WHEN s.ITEM IS NOT NULL THEN 'Lean Kits'
        WHEN p.ITEM IS NOT NULL THEN 'Lean P'
        ELSE 'Non Lean'
    END AS Lean,Parts
FROM TTCIBD001490 a

LEFT JOIN (
    SELECT DISTINCT LTRIM(RTRIM(ITEM)) AS ITEM
    FROM dbo.TZZSFC211ALL
    WHERE COMPANY = '490' AND ITEM <> ' '
) s ON LTRIM(RTRIM(a.ITEM)) = s.ITEM

LEFT JOIN (
    SELECT DISTINCT LTRIM(RTRIM(ITEM)) AS ITEM
    FROM dbo.TZZPUR049ALL
    WHERE COMPANY = '490' AND ITEM <> ' '
) p ON LTRIM(RTRIM(a.ITEM)) = p.ITEM
   AND s.ITEM IS NULL   -- Prevent override if already Lean Kits

   LEFT JOIN Gsc_Parts r on r.ItemCode = LTRIM(RTRIM(a.Item))

WHERE LTRIM(RTRIM(a.ITEM)) <> ' '

GO

