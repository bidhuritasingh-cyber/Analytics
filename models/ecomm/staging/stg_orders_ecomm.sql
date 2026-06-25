{{ config(materialized='view') }}

select
    order_id,
    customer_id,
    order_date,
    status,
    total_amount,
    discount_amount,
    shipping_amount,
    total_amount - discount_amount    as net_amount,
    created_at,
    updated_at
from {{ source('orders', 'orders') }}
where order_id is not null