{{ config(materialized='table') }}

select
    co.customer_id,
    co.full_name,
    co.email,
    co.city,
    co.state,
    co.is_active,
    co.signup_date,
    co.total_orders,
    co.completed_orders,
    co.returned_orders,
    co.lifetime_value,
    co.first_order_date,
    co.last_order_date,
    case
        when co.lifetime_value >= 10000  then 'platinum'
        when co.lifetime_value >= 5000   then 'gold'
        when co.lifetime_value >= 2000   then 'silver'
        else                             'bronze'
    end                                  as customer_tier,
    datediff('day', co.last_order_date,
        current_date)                    as days_since_last_order
from {{ ref('int_customer_orders') }} co