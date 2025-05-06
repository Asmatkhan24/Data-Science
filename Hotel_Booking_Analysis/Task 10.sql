#Which day of the week brings the highest sales
SELECT 
    rank() over (order by sum(Total) desc) as 'Rank',
    DAYNAME(STR_TO_DATE(Date, '%d-%m-%Y')) AS DayOfWeek, 
    Round(SUM(Total),2) AS TotalSales
FROM WalmartSales
GROUP BY DayOfWeek
order by TotalSales desc;