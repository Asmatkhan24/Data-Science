#Best Product Line by Customer Type
select `Customer type`, `Product line`, count(*) as count_of_PL from walmartsales
group by `Customer type`, `Product line`
order by `Customer type`, count_of_PL desc;