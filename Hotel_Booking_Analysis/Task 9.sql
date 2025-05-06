#Finding Top 5 Customers by Sales Volume
SELECT 
    `Customer ID`, 
    ROUND(SUM(Total), 2) AS TotalRevenue,
    rank() over (order by sum(Total) desc) as 'Rank'
FROM WalmartSales
GROUP BY `Customer ID`
order by TotalRevenue desc
LIMIT 5;