{{ config(materialized='view') }}

select
    invoice_id,
    order_id,
    invoice_date,
    due_date,
    amount,
    tax_amount,
    status,
    datediff('day', invoice_date, due_date)  as payment_terms_days
from {{ source('finance', 'invoices') }}