{{ config (materialized = 'view')}}

SELECT 
    history_id,
    order_id,
    status,
    changed_at,
    changed_by
FROM {{source('orders', 'order_status_history')}}