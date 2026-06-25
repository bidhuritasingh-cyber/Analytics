{{ config(materialized='view') }}

select
    campaign_id,
    campaign_name,
    channel,
    start_date,
    end_date,
    budget,
    spend,
    target_segment,
    datediff('day', start_date, end_date)  as days_running
from {{ source('marketing', 'campaigns') }}