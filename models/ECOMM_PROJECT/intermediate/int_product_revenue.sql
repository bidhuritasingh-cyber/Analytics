-- Create int_product_revenue.sql (ephemeral) — join stg_order_items and stg_products to calculate total revenue and total units sold per product.

{{ config(materialized='ephemeral') }}

with order_items as (
    select 
        product_id,
        quantity,
        unit_price,
        discount,
        (quantity * unit_price) - discount as line_total 
    from {{ ref('stg_order_items') }}
),

products as (
    select 
        product_id,
        product_name
    from {{ ref('stg_products') }}
)

select
    p.product_id,
    p.product_name,
    sum(o.quantity)   as total_units_sold,
    sum(o.line_total) as total_revenue
from products p
left join order_items o 
    on p.product_id = o.product_id
group by 
    p.product_id,
    p.product_name
