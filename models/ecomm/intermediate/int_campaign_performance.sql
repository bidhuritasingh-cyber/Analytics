{{ config(materialized='ephemeral') }}

select
    c.campaign_id,
    c.campaign_name,
    c.channel,
    c.start_date,
    c.end_date,
    c.budget,
    c.spend,
    count(cc.click_id)                as total_clicks,
    count(case when cc.converted
        then 1 end)                   as conversions,
    round(count(case when cc.converted then 1 end)
        / nullif(count(cc.click_id),0) * 100, 2) as conversion_rate,
    round(c.spend / nullif(
        count(case when cc.converted then 1 end),0),2) as cost_per_conversion
from {{ ref('stg_campaigns') }} c
left join {{ ref('stg_campaign_clicks') }} cc
    on c.campaign_id = cc.campaign_id
group by 1,2,3,4,5,6,7