{{
    config(
        materialized   = 'incremental',
        unique_key     = 'daily_sales_id',
        on_schema_change = 'sync_all_columns'  
    )
}}

select  {{ dbt_utils.generate_surrogate_key(['order_date']) }}
                                        as daily_sales_id,
    order_date,
    count(order_id)                     as total_orders,
    count(case when status = 'completed'
        then 1 end)                     as completed_orders,
    count(case when status = 'returned'
        then 1 end)                     as returned_orders,
    sum(case when status = 'completed'
        then net_amount else 0 end)      as gross_revenue,
    sum(discount_amount)                as total_discounts,
    avg(net_amount)                     as avg_order_value,
    current_timestamp                   as loaded_at
from {{ ref('stg_orders_ecomm') }}

{% if is_incremental() %}
    where order_date > (
        select dateadd('day', -3, max(order_date))
        from {{ this }}
    )
{% endif %}
group by 1, 2