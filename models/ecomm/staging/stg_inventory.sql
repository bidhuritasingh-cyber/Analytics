{{ config(materialized='view') }}

select
    inventory_id,
    product_id,
    warehouse_id,
    stock_qty,
    reorder_level,
    case
        when stock_qty = 0                then 'out_of_stock'
        when stock_qty <= reorder_level   then 'low_stock'
        else                                   'in_stock'
    end                                   as stock_status,
    last_updated
from {{ source('inventory', 'inventory') }}