select
	dp.month_name,
	dp.year,
	sum(op.revenue)
from orders_project op
join date_project dp on op.order_date = dp.date
group by 
	dp.year, dp.month_name, dp.month
order by 
	dp.year asc,
	dp.month asc
	
	
select
	pp.brand,
	sum(op.revenue) as Total_Revenue,
	row_number() over (
		order by sum(op.revenue) DESC
	) as rank
from orders_project op
join products_project pp on op.product_id = pp.product_id 
group by pp.brand


select 
	brand,
	brand_revenue,
	(brand_revenue / sum(brand_revenue) over ()) * 100 as dominance
from (
	select
		pp.brand as brand,
		sum(op.revenue) as brand_revenue
	from orders_project op
	join products_project pp on op.product_id = pp.product_id 
	group by pp.brand
)
order by dominance desc

select 
	pp.brand,
	pp.product_category,
	sum(op.revenue),
	row_number() over (
		partition by pp.brand
		order by sum(op.revenue) desc
	)
from orders_project op
join products_project pp on op.product_id = pp.product_id 
group by  pp.brand, pp.product_category

select 
	pp.product_category,
	cp.region,
	sum(op.revenue )
from orders_project op 
join customers_project cp on cp.customer_id = op.customer_id 
join products_project pp on pp.product_id = op.product_id 
group by pp.product_category, cp.region 
order by region
	

select 
	cp.customer_id,
	sum(op.revenue) as customer_revennue
from orders_project op 
join customers_project cp on cp.customer_id = op.customer_id 
group by cp.customer_id 
order by sum(op.revenue ) desc
limit 10

select 
	customer_id,
	customer_revenue,
	(customer_revenue / sum(customer_revenue) over ()) * 100 as dominance
from (
	select 
		cp.customer_id as customer_id,
		sum(op.revenue) as customer_revenue
	from orders_project op 
	join customers_project cp on cp.customer_id = op.customer_id 
	group by cp.customer_id 
)
order by customer_revenue  desc
limit 10



	