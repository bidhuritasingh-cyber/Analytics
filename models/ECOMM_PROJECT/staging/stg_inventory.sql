--stg_inventory.sql
{{ config(materialized='view') }} 
 
select 
    i.inventory_id, 
    i.product_id, 
    i.warehouse_id, 
    i.stock_qty, 
    i.reorder_level, 
    case 
        when i.stock_qty = 0          then 'out_of_stock' 
        when i.stock_qty <= i.reorder_level then 'low_stock' 
        else                               'in_stock' 
    end                               as stock_status, 
    i.last_updated 
from {{ source('inventory', 'inventory') }} i 