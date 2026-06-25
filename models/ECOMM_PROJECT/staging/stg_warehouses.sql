SELECT
    warehouse_id, 
    warehouse_name, 
    city, 
    state,
    capacity,
    is_active
FROM {{source('inventory','warehouses')}}