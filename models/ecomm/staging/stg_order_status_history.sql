{{ config(materialized='view') }}

select
    history_id,
    order_id,
    status,
    changed_at,
    changed_by
from {{ source('orders', 'order_status_history') }}