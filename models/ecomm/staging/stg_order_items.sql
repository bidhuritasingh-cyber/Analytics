{{ config(materialized='view') }}

select
    item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount,
    (quantity * unit_price) - discount    as line_total
from {{ source('orders', 'order_items') }}