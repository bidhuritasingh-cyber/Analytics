{{ config(materialized='ephemeral') }}

select
    c.customer_id,
    c.full_name,
    c.email,
    c.city,
    c.state,
    c.is_active,
    c.signup_date,
    count(o.order_id)                 as total_orders,
    count(case when o.status = 'completed'
        then 1 end)                   as completed_orders,
    count(case when o.status = 'returned'
        then 1 end)                   as returned_orders,
    sum(case when o.status = 'completed'
        then o.net_amount else 0 end)  as lifetime_value,
    min(o.order_date)                 as first_order_date,
    max(o.order_date)                 as last_order_date
from {{ ref('stg_customers_ecomm') }} c
left join {{ ref('stg_orders_ecomm') }} o
    on c.customer_id = o.customer_id
group by 1,2,3,4,5,6,7