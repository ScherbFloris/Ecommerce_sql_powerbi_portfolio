
-- ================================================
-- Dimension & Fact Views for Olist Dataset
-- Purpose: Star-schema-style modeling for BI
-- DB: PostgreSQL (written and validated in DBeaver)
-- ================================================

-- ==========================================================
-- FACT TABLE: Orders (line-item level)
-- Purpose: Create a consolidated fact table joining orders,
--          order items, products, and reviews.
-- Model: Star-schema style (fact table with multiple dimensions)
-- Filter: Only orders after 2016-12-31
-- ==========================================================

create or replace view fact_table as
select
  -- Primary key
    ood.order_id,
  
  -- Foreign keys (link to dimensions)                            
    ood.customer_id,
    ooid.seller_id,                                  
    opd.product_id,
    oord.review_id,
  
  -- Time attributes
    ood.order_purchase_timestamp::timestamp as order_purchase_timestamp, -- key for date dimension
    ood.order_purchase_timestamp::date as order_date,
    to_char(ood.order_purchase_timestamp::date,'YYYYMMDD')::int as order_date_key,
  
  -- Measure
    ooid.price
  
from olist_orders_dataset as ood
join olist_order_items_dataset as ooid on ood.order_id = ooid.order_id
join olist_products_dataset as opd  on ooid.product_id = opd.product_id
left join olist_order_reviews_dataset as oord on ood.order_id = oord.order_id
where ood.order_purchase_timestamp::date > '2016-12-31'; -- exclude incomplete year 2016

-- Preview rows
select *
from fact_table

-- ==========================================================
-- DIMENSION TABLE: Orders
-- Purpose: Create an order dimension with temporal breakdowns 
--          (year, quarter, month) and order status.
-- Model: Supports time-based and status-based reporting in BI.
-- ==========================================================

create or replace dim_order as
select
  -- Primary key
	order_id,

  -- Raw timestamp of the order
	order_purchase_timestamp::timestamp as order_purchase_timestamp

  -- Time breakdowns (used for time-series aggregations)
	extract(year from order_purchase_timestamp::timestamp) as order_year,
	extract(quarter from order_purchase_timestamp::timestamp) as order_quarter,
	extract(month from order_purchase_timestamp::timestamp) as order_month,

  -- Current order state (delivered, shipped, canceled, etc.)
	order_status
  
from
	olist_orders_dataset
where order_id is not null
order by
	order_id;

-- Preview rows
select *
from
	dim_order;

-- ==========================================================
-- DIMENSION TABLE: reviews
-- Purpose: Create an reviews dimension
-- ==========================================================

create or replace view dim_reviews as
select distinct
  -- Primary key
	review_id,

  -- Review information
	review_creation_date,
	review_score
  
from
	olist_order_reviews_dataset
order by
	review_id;

-- Preview rows
select *
from
	dim_reviews;

-- ==========================================================
-- DIMENSION TABLE: customer
-- Purpose: Create an customer dimension
-- ==========================================================

create or replace dim_customer AS
select distinct
  -- Primay key
	customer_id,

  -- Customer information
	customer_city,
	customer_state
  
from olist_customer
order by
	customer_id;

-- Preview rows
select *
from
	dim_customer;

-- ==========================================================
-- DIMENSION TABLE: product
-- Purpose: Create an product dimension
-- ==========================================================

create or replace view dim_product AS
  
select distinct
  -- Primary key
  ooid.product_id,

  -- Product category
  pcnt.product_category_name_english AS product_category
  
from
    olist_products_dataset as opd
inner join product_category_name_translation as pcnt 
    on opd.product_category_name = pcnt.product_category_name
inner join olist_order_items_dataset as ooid
    on opd.product_id = ooid.product_id
order by
	product_id desc;

-- Preview rows
select *
from dim_product

-------------------------------------------------------------------------------------------------------------------
-- DIMENSION TABLE: date
-- Purpose: Generate a complete date dimension table covering the full range
--          of order_purchase_timestamp values from olist_orders_dataset.
-- Model: Used as a standard calendar dimension in star-schema reporting.
-- Features: Continuous daily grain, time breakdowns (year, quarter, month).
-------------------------------------------------------------------------------------------------------------------

create or replace view dim_date as
with src as (
  -- Extract valid timestamps from orders (ignore blanks/nulls)
  select to_timestamp(nullif(order_purchase_timestamp, ''), 'YYYY-MM-DD HH24:MI:SS') AS ts
  from olist_orders_dataset
  where nullif(order_purchase_timestamp, '') is not null
  
),
bounds as (
  -- Determine minimum and maximum order dates
  select MIN(ts)::date as dmin, MAX(ts)::date as dmax from src
),
series as (
  -- Generate a continuous series of dates from min to max
  select generate_series(dmin, dmax, '1 day')::date as d from bounds
)
select
  d as date,
  -- Hierarchical breakdowns for reporting
  extract(year from d)::int as year,
  extract(quarter from d)::int as quarter,
  extract(month from d)::int as month,
  to_char(d,'YYYY-MM')       as year_month
  
from series
order by d;

-- Preview rows
select *
from dim_date;
