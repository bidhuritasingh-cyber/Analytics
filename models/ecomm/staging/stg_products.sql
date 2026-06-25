{{ config(materialized='view') }}

select
    product_id,
    product_name,
    category,
    sub_category,
    brand,
    price,
    cost_price,
    price - cost_price                         as gross_margin,
    round((price - cost_price)
          / nullif(price, 0) * 100, 2)         as margin_pct,
    is_active,
    launched_at
from {{ source('products', 'products') }}