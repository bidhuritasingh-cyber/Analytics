{{ config(
    materialized = 'view'
)}}

SELECT
    campaign_id, 
    campaign_name, 
    channel, 
    start_date,
    end_date,
    budget,
    spend,
    target_segment,
    (end_date-start_date) AS days_running
FROM {{ source('marketing', 'campaigns')}}