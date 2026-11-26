create procedure nooflines as
begin
SELECT 
    t.NAME AS TableName,
    SUM(p.rows) AS noOfRows
FROM 
    sys.tables AS t
INNER JOIN 
    sys.partitions AS p ON t.object_id = p.object_id
WHERE 
    p.index_id IN (0, 1)  -- 0 = heap, 1 = clustered index
GROUP BY 
    t.Name
ORDER BY 
    TableName 

end

GO

