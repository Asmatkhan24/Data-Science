#Customer Segmentation based on spending
WITH CustomerSpending AS (
    SELECT 
        `Customer ID`,
        SUM(Total) AS TotalSpending
    FROM WalmartSales
    GROUP BY `Customer ID`
),
SpendingStats AS (
    SELECT 
        AVG(TotalSpending) AS AvgSpending,
        STDDEV(TotalSpending) AS SpendingDeviation
    FROM CustomerSpending
)
SELECT 
    cs.`Customer ID`,
    cs.TotalSpending,
    CASE
        WHEN cs.TotalSpending >= ss.AvgSpending + ss.SpendingDeviation THEN 'High Spender'
        WHEN cs.TotalSpending >= ss.AvgSpending - ss.SpendingDeviation AND cs.TotalSpending < ss.AvgSpending + ss.SpendingDeviation THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS SpendingTier
FROM CustomerSpending cs
CROSS JOIN SpendingStats ss
ORDER BY cs.TotalSpending desc;