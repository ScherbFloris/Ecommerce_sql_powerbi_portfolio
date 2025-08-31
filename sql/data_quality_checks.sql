-- Data Quality Checks for Olist Dataset
-- Purpose: Verify integrity and consistency of raw data before aggregation
-- Tool: Validated in DBeaver (PostgreSQL)

-- NOTE: These are only three SQL-queries out of many that I wrote for data quality checks

/* Check 1: check and count for numm vales */

select
  count(*) filter (where order_id is null) as order_id_nulls,
  count(*) filter (where customer_id is null) as customer_id_nulls,
  count(*) filter (where order_status is null) as order_status_nulls
from olist_orders_dataset;

/* Check 2: eliminate rows containing null values in primary key */

select *
from olist_orders_dataset
where order_id is not null
  and customer_id is not null
  and order_status is not null;


/* Check 3: check if customers exist in dataset that had multiple orders */

select
	customer_id,
	count(*) as order_count
from vw_orders_clean
group by customer_id 
having count(*) > 1
order by order_count desc;

