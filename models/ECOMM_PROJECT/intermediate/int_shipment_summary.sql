--Create int_shipment_summary.sql (ephemeral) — join stg_shipments and stg_delivery_events to get total events per shipment, latest event type, and whether the shipment was delayed.

{{config(materialized = 'ephemeral')}}

WITH event_aggregates AS (
    SELECT
        shipment_id,
        COUNT(event_id) AS total_events,
        MAX_BY(event_type, event_time) AS latest_event_type
    FROM {{ref('stg_delivery_events')}} 
    GROUP BY shipment_id
)

SELECT
    s.shipment_id,
    COALESCE(e.total_events, 0) AS total_events,
    e.latest_event_type,
    CASE 
        WHEN s.delivered_date > s.expected_date THEN TRUE
        WHEN s.delivered_date IS NULL AND CURRENT_DATE() > s.expected_date THEN TRUE
        ELSE FALSE
    END AS is_delayed
FROM {{ref('stg_shipments')}} s
LEFT JOIN event_aggregates e 
    ON s.shipment_id = e.shipment_id