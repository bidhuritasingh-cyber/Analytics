{{ config(materialized='view') }}

select
    shipment_id,
    order_id,
    warehouse_id,
    carrier,
    tracking_number,
    shipped_date,
    expected_date,
    delivered_date,
    status,
    datediff('day', shipped_date,
        coalesce(delivered_date, current_date))  as transit_days,
    case
        when delivered_date > expected_date then true
        else false
    end                                          as is_delayed
from {{ source('logistics', 'shipments') }}