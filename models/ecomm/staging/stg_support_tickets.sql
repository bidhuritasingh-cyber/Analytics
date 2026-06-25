{{ config(materialized='view') }}

select
    ticket_id,
    customer_id,
    order_id,
    ticket_type,
    priority,
    status,
    created_at,
    resolved_at,
    sla_hours,
    datediff('hour', created_at,
        coalesce(resolved_at, current_timestamp))  as hours_to_resolve,
    case
        when resolved_at is null then false
        when datediff('hour', created_at, resolved_at) > sla_hours then true
        else false
    end                                            as is_sla_breached
from {{ source('support', 'support_tickets') }}