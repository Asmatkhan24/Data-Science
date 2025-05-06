#To find the product lines in each Branch with highest profit
WITH ProductLineProfit AS 
(
    SELECT 
        Branch,
        `Product line`,
        SUM(cogs-'gross income') AS Profit,
        ROW_NUMBER() OVER (PARTITION BY Branch ORDER BY SUM(cogs-'gross income') DESC) AS Rnk
    FROM WalmartSales
    GROUP BY Branch, `Product line`
)
SELECT 
    Branch,
    `Product line`,
    Profit
FROM ProductLineProfit
where Rnk = 1;





#To rank each Product Line According to each Branch
SELECT 
    Branch,
    `Product line`,
    SUM(cogs-'gross income') AS Profit,
    RANK() OVER (PARTITION BY Branch ORDER BY SUM(cogs-'gross income') DESC) AS Rk
FROM WalmartSales
GROUP BY Branch, `Product line`
ORDER BY Branch, Rk;