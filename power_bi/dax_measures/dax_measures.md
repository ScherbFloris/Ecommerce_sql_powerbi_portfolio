
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
