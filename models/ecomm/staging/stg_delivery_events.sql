{{ config(materialized='view') }}

select
    event_id,
    shipment_id,
    event_type,
    event_time,
    location,
    case
        when event_type = 'delivered' then true
        else false
    end                              as is_final_event
from {{ source('logistics', 'delivery_events') }}