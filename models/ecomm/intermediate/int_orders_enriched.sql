{{ config(materialized='ephemeral') }}

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    o.net_amount,
    o.discount_amount,
    o.shipping_amount,
    count(oi.item_id)                 as item_count,
    sum(oi.quantity)                  as total_quantity,
    sum(oi.line_total)                as calculated_total,
    case
        when o.net_amount >= 5000 then 'high'
        when o.net_amount >= 2000 then 'medium'
        else 'low'
    end                               as order_tier,
    case
        when o.status = 'completed'   then TRUE
        else FALSE
    end                               as is_completed
from {{ ref('stg_orders_ecomm') }} o
left join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
group by 1,2,3,4,5,6,7