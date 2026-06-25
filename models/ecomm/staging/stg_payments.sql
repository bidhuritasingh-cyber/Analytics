{{ config(materialized='view') }}

select
    payment_id,
    order_id,
    payment_date,
    payment_method,
    amount,
    status,
    gateway,
    case when status = 'success'  then amount else 0 end  as collected_amount,
    case when status = 'refunded' then amount else 0 end  as refunded_amount
from {{ source('finance', 'payments') }}