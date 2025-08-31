-- Data Quality Checks for Olist Dataset
-- Purpose: Verify integrity and consistency of raw data before aggregation
-- Tool: Validated in DBeaver (PostgreSQL)

-- NOTE: These are only three SQL-queries out of many that I wrote for data quality checks

/* Check 1: Missing values in critical columns */

select
  count(*) filter (where order_id is null) as order_id_nulls,
  count(*) filter (where customer_id is null) as customer_id_nulls,
  count(*) filter (where order_status is null) as order_status_nulls
from olist_orders_dataset;

/* Check 2: Duplicate primary keys */

CREATE OR REPLACE VIEW vw_orders_clean AS
SELECT *
FROM olist_orders_dataset
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL
  AND order_status IS NOT NULL;


/* Check 3: Negative or zero prices */

select
	customer_id,
	count(*) as order_count
from vw_orders_clean
group by customer_id 
-- having count(*) > 1
order by order_count desc;
