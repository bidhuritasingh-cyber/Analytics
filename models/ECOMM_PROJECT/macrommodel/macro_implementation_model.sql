{{
    config(alias = 'stg_orders_macro')

}}
select
    order_id,
    net_amount,
    {{ get_order_tier('net_amount') }}   as order_tier
from {{ ref('stg_orders') }}