{{ config(materialized='view')     }}

select
    click_id,
    campaign_id,
    customer_id,
    clicked_at,
    hour(clicked_at)    as click_hour,
    device_type,
    converted
from {{ source('marketing', 'campaign_clicks') }}