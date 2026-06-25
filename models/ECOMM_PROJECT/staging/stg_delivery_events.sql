--Create stg_delivery_events.sql — add a column is_final_event that is TRUE only when event_type = 'delivered'.

SELECT
    event_id,
    shipment_id,
    event_type,
    event_time,
    location,
    CASE WHEN event_type = 'delivered' THEN 'True' ELSE 'FALSE' END AS is_final_event
FROM {{source('logistics', 'delivery_events')}}