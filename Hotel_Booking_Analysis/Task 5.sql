#Most Popular Payment Method by City
With PaymentCounts as
(
Select City, Payment, count(Payment) as PaymentCount
from walmartsales
group by City, Payment
),
RankedPayments as
(
Select city, Payment, PaymentCount,
Row_number() over(Partition by City order by PaymentCount desc) as Rnk
from PaymentCounts
)
select city, Payment, PaymentCount
from RankedPayments
where Rnk = 1
Order by City;
