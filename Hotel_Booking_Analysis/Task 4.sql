#Detecting Anomalies in Sales Transaction
WITH ProductLineStats AS (
    SELECT 
        `Product line`,
        AVG(Total) AS AvgSales
    FROM WalmartSales
    GROUP BY `Product line`
),
AnomalousTransactions AS (
    SELECT 
        ws.`Invoice ID`,
        ws.Branch,
        ws.`Product line`,
        ws.Total AS SaleAmount,
        pls.AvgSales,
        CASE 
            WHEN ws.Total > pls.AvgSales*1.2  THEN 'High Anomaly'
            WHEN ws.Total < pls.AvgSales*0.8  THEN 'Low Anomaly'
            ELSE 'Normal'
        END AS AnomalyType
    FROM WalmartSales ws
    JOIN ProductLineStats pls
    ON ws.`Product line` = pls.`Product line`
)
SELECT 
    `Invoice ID`,
    Branch,
    `Product line`,
    SaleAmount,
    AnomalyType
FROM AnomalousTransactions
WHERE AnomalyType IN ('High Anomaly', 'Low Anomaly')
ORDER BY SaleAmount;