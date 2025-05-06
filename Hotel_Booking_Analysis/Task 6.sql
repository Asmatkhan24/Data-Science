#Monthly Sales Distribution by Gender
select Gender, DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m') AS Month, Round(sum(Total), 2) as TotalSales
from walmartsales
group by Gender, Month
order by Month, Gender;