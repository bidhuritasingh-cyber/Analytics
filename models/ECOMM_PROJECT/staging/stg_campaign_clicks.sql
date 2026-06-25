
SELECT 
    click_id,
    campaign_id,
    customer_id,
    clicked_at,
    device_type,
    converted,
    HOUR(clicked_at) AS click_hour 
FROM {{source('marketing', 'campaign_clicks')}}