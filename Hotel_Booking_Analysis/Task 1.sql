#Aggregate total sales by branch and month
SELECT 
    Branch, 
    DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m') AS Month, -- Format the date as Year-Month 
    SUM(Total) AS MonthlySales
FROM walmartsales
GROUP BY Branch, Month
ORDER BY Branch, Month;





#Calculating the monthly sales
WITH MonthlySalesData AS (
    SELECT 
        Branch,
        DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m') AS SalesMonth,
        SUM(Total) AS MonthlySales
    FROM WalmartSales
    GROUP BY Branch, SalesMonth
)
SELECT 
    Branch,
    SalesMonth,
    MonthlySales,
    LAG(MonthlySales) OVER (PARTITION BY Branch ORDER BY SalesMonth) AS PreviousMonthlySales,
    ROUND(
        (MonthlySales - LAG(MonthlySales) OVER (PARTITION BY Branch ORDER BY SalesMonth)) 
        / LAG(MonthlySales) OVER (PARTITION BY Branch ORDER BY SalesMonth) * 100, 
        2
    ) AS GrowthPercentage
FROM MonthlySalesData
ORDER BY Branch, SalesMonth;





#Finding the top performing branch
WITH SalesGrowth AS 
(
    WITH MonthlySalesData AS 
    (
        SELECT 
            Branch,
            DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m') AS SalesMonth,
            SUM(Total) AS MonthlySales
        FROM WalmartSales
        GROUP BY Branch, SalesMonth
    )
    SELECT 
        Branch,
        SalesMonth,
        MonthlySales,
        LAG(MonthlySales) OVER (PARTITION BY Branch ORDER BY SalesMonth) AS PreviousMonthlySales,
        ROUND(
            (MonthlySales - LAG(MonthlySales) OVER (PARTITION BY Branch ORDER BY SalesMonth)) 
            / LAG(MonthlySales) OVER (PARTITION BY Branch ORDER BY SalesMonth) * 100, 
            2
        ) AS GrowthPercentage
    FROM MonthlySalesData
)
SELECT 
    Branch,
    ROUND(SUM(GrowthPercentage), 2) AS 'Total_Growth_Percentage'
FROM SalesGrowth
WHERE GrowthPercentage IS NOT NULL
GROUP BY Branch
ORDER BY Total_Growth_Percentage desc
LIMIT 1 ;