
# 1. Monthly Sales Overview Dashboard

### Revenue

```dax
Revenue = 
SUM('public fact_table'[price])
```

### Most Sold Product Category

```dax
Top Category Name = 
MAXX (
    TOPN (
        1;
        SUMMARIZE (
            'public dim_product';
            'public dim_product'[product_category];
            "OrderCount"; DISTINCTCOUNT ( 'public fact_table'[order_id] )
        );
        [OrderCount]; DESC
    );
    [product_category]
)
```

### Order Quantity

```dax
Orders = DISTINCTCOUNT('public fact_table'[order_id])
```

### Order Quantity

```dax
Orders = DISTINCTCOUNT('public fact_table'[order_id])
```

###  Saisonality Index Per Month

```dax
Seasonality Index (Month only) = 
IF(
    HASONEVALUE('public dim_date'[month]);
    DIVIDE([Revenue]; [Avg Monthly Revenue (Same Year)]);
    BLANK()
)
```

###  MoM Revenue %

```dax
MoM Revenue % = 
VAR LastFactDate     = CALCULATE( MAX('public fact_table'[order_date]); ALL('public dim_date') )
VAR LastFullMonthEnd = EOMONTH( LastFactDate; -1 )
VAR CurMonthEnd      = EOMONTH( MAX('public dim_date'[Date]); 0 )
VAR RevCM            = [Revenue]
VAR RevPM            = CALCULATE( [Revenue]; DATEADD('public dim_date'[Date]; -1; MONTH) )
VAR MoM              = DIVIDE( RevCM - RevPM; RevPM )
RETURN
IF(
    NOT ISINSCOPE('public dim_date'[month]);         -- Totale/Jahreszeile
    BLANK();
    IF( CurMonthEnd > LastFullMonthEnd; BLANK(); MoM )
)
```

# 2. Product Category Overview Dashboard

###  Revenue Share By Product Category

```dax
Revenue Share by Category % = 
DIVIDE(
    [Revenue];
    CALCULATE( [Revenue]; REMOVEFILTERS('public dim_product'[product_category]) )
)
```

###  Average Order Value

```dax
AOV Index = 
DIVIDE( [AOV];
        CALCULATE( [AOV]; REMOVEFILTERS('public dim_product'[product_category]) ) )

Avg Review by Category = 
VAR OrdersInCat =
    CALCULATETABLE (
        DISTINCT ( 'public fact_table'[order_id] );
        KEEPFILTERS ( VALUES ( 'public dim_product'[product_category] ) )
    )
```

###  Average Review By Product Category

```dax
VAR ReviewsForCat =
    CALCULATETABLE (
        'public dim_reviews';
        TREATAS ( OrdersInCat; 'public dim_reviews'[order_id] )
    )
RETURN
AVERAGEX ( ReviewsForCat; 'public dim_reviews'[review_score] )
```



