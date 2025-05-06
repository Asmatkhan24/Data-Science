#Identifying Repeat Customers
WITH CustomerPurchases AS (
    SELECT 
        `Customer ID`, 
        Date AS PurchaseDate, 
        LEAD(Date) OVER (PARTITION BY `Customer ID` ORDER BY STR_TO_DATE(Date, '%d-%m-%Y')) AS NextPurchaseDate
    FROM WalmartSales
),
RepeatPurchases AS (
    SELECT 
        `Customer ID`, 
        STR_TO_DATE(PurchaseDate, '%d-%m-%Y') AS PurchaseDate,
        STR_TO_DATE(NextPurchaseDate, '%d-%m-%Y') AS NextPurchaseDate,
        DATEDIFF(STR_TO_DATE(NextPurchaseDate, '%d-%m-%Y'), STR_TO_DATE(PurchaseDate, '%d-%m-%Y')) AS DaysBetween
    FROM CustomerPurchases
    WHERE NextPurchaseDate IS NOT NULL
)
SELECT 
    `Customer ID`, 
    PurchaseDate, 
    NextPurchaseDate, 
    DaysBetween
FROM RepeatPurchases
WHERE DaysBetween <= 30
ORDER BY `Customer ID`, PurchaseDate;