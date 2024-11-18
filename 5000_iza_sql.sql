-- Average Revenue of Companies
select 
	industry 
	,round(avg(revenue)) as avg_revenue 
from 
	iza
group by 1
order by 
	avg_revenue desc 


	
-- Industry Representation – Which Are the Most and Least Represented on the List?
select 
	industry 
	,count(*) as comp_count
from 
	iza
group by
	industry 
order by comp_count desc 



-- Industries with the Highest Average Revenue Growth in %
select 
	industry 
	,round(avg(growth_percent), 2) as avg_growth
from 
	iza
group by
	industry 
order by avg_growth desc 


-- TOP 5: Industries with Highest Average Growth in %
select
	industry 
	,round(avg(growth_percent), 2) as avg_growth
from 
	iza
group by
	industry 
order by 
	avg_growth desc 
limit	5


-- Top 10 Companies Increasing Employment with the Highest Growth in %
select
	name 
	,workers_growth_percent as workers_growth
	,growth_percent as growth
from 
	iza
where 
	workers_growth_percent is not null 
order by 
	workers_growth desc 
limit 10


-- Industries Increasing Employment with the Highest Average Growth in %
select
	industry 
	,round(avg(workers_growth_percent)) as workers_growth
	,round(avg(growth_percent), 2) as growth
from 
	iza
where 
	workers_growth_percent is not null 
group by
	industry	
order by 
	workers_growth desc
	
	
-- Decrease in Employment with Revenue Growth in %
select
	name 
	,workers_growth_percent as workers_growth
	,growth_percent as growth
from 
	iza
where 
	growth_percent is not null and 
	workers_growth_percent < 0
order by 
	workers_growth asc 
	
	
	
-- Revenue Growth with Decreasing Employment by Industry in %
select
	industry 
	,avg(workers_growth_percent) as workers_growth
	,avg(growth_percent) as growth
from 
	iza
where 
	growth_percent is not null and 
	workers_growth_percent < 0
group by 
	industry
order by 
	workers_growth asc
	
	
-- Average Growth for Industries which have more than 50000 employees.
select
	industry
	,round(avg(growth_percent), 2) as avg_growth
	,sum(workers) as total_workers 
from
	iza
where 
	industry in(
		select 
			industry
		from
			iza
		group by
			industry
		having
			sum(workers) > 50000)
group by industry 


-- Companies Rank within their Industry based on Revenue
SELECT 
    name, 
    industry, 
    revenue, 
    RANK() OVER (PARTITION BY industry ORDER BY revenue DESC) AS revenue_rank 
FROM 
    iza

