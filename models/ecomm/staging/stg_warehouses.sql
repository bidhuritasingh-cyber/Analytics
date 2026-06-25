{{ config(materialized='view') }}

select
    warehouse_id,
    warehouse_name,
    city,
    state,
    capacity,
    is_active
from {{ source('inventory', 'warehouses') }}