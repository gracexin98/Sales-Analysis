---- Inspecting Data
-- select * from [dbo].[sales_data_sample]; 


---- Checking unique values
-- select distinct STATUS from [dbo].[sales_data_sample]; --Nice one to plot
-- select distinct YEAR_ID from [dbo].[sales_data_sample];
-- select distinct PRODUCTLINE from [dbo].[sales_data_sample]; ---Nice to plot
-- select distinct COUNTRY from [dbo].[sales_data_sample]; ---Nice to plot
-- select distinct DEALSIZE from [dbo].[sales_data_sample]; ---Nice to plot
-- select distinct TERRITORY from [dbo].[sales_data_sample]; ---Nice to plot
-- select distinct MONTH_ID from [dbo].[sales_data_sample]
--     where YEAR_ID = 2003;


---- ANALYSIS
---- Let's start by grouping sales by productline
-- select PRODUCTLINE, sum(sales) AS Revenue
-- from [dbo].[sales_data_sample]
-- group by PRODUCTLINE
-- order by 2 desc;

-- select YEAR_ID, sum(sales) AS Revenue
-- from [dbo].[sales_data_sample]
-- group by YEAR_ID
-- order by 2 desc;

-- select  DEALSIZE,  sum(sales) AS Revenue
-- from [dbo].[sales_data_sample]
-- group by  DEALSIZE
-- order by 2 desc; 


---- What was the best month for sales in a specific year? How much was earned that month? 
-- select  MONTH_ID, sum(sales) AS Revenue, count(ORDERNUMBER) AS Frequency
-- from [dbo].[sales_data_sample]
-- where YEAR_ID = 2004 --change year to see the rest
-- group by  MONTH_ID
-- order by 2 desc;


---- November seems to be the month, what product do they sell in November, Classic Cars
-- select  MONTH_ID, PRODUCTLINE, sum(sales) AS Revenue, count(ORDERNUMBER)
-- from [dbo].[sales_data_sample]
-- where YEAR_ID = 2004 AND MONTH_ID = 11 --change year to see the rest
-- group by  MONTH_ID, PRODUCTLINE
-- order by 3 desc;


---- Who is our best customer (this could be best answered with RFM)
-- DROP TABLE IF EXISTS #rfm
-- ;with rfm as 
-- (
-- 	select 
-- 		CUSTOMERNAME, 
-- 		sum(sales) AS MonetaryValue,
-- 		avg(sales) AS AvgMonetaryValue,
-- 		count(ORDERNUMBER) AS Frequency,
-- 		max(ORDERDATE) last_order_date,
-- 		(select max(ORDERDATE) from [dbo].[sales_data_sample]) AS max_order_date,
-- 		DATEDIFF(DD, max(ORDERDATE), (select max(ORDERDATE) from [dbo].[sales_data_sample]) ) AS Recency -- (DD, max(ORDERDATE), max_order_date)
-- 	from [dbo].[sales_data_sample]
-- 	group by CUSTOMERNAME
-- ),
-- rfm_calc as
-- (
-- 	select r.*,
-- 		NTILE(4) OVER (order by Recency desc) rfm_recency,
-- 		NTILE(4) OVER (order by Frequency) rfm_frequency,
-- 		NTILE(4) OVER (order by MonetaryValue) rfm_monetary
-- 	from rfm r
-- )
-- select 
-- 	c.*, rfm_recency+ rfm_frequency+ rfm_monetary as rfm_cell,
-- 	cast(rfm_recency as varchar) + cast(rfm_frequency as varchar) + cast(rfm_monetary as varchar)rfm_cell_string
-- into #rfm
-- from rfm_calc c

-- select CUSTOMERNAME , rfm_recency, rfm_frequency, rfm_monetary,
-- 	case 
-- 		when rfm_cell_string in (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141) then 'lost_customers'  --lost customers
-- 		when rfm_cell_string in (133, 134, 143, 244, 334, 343, 344, 144) then 'slipping away, cannot lose' -- (Big spenders who haven’t purchased lately) slipping away
-- 		when rfm_cell_string in (311, 411, 331) then 'new customers'
-- 		when rfm_cell_string in (222, 223, 233, 322) then 'potential churners'
-- 		when rfm_cell_string in (323, 333,321, 422, 332, 432) then 'active' --(Customers who buy often & recently, but at low price points)
-- 		when rfm_cell_string in (433, 434, 443, 444) then 'loyal'
-- 	end rfm_segment

-- from #rfm