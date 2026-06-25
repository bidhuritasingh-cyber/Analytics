{{ config(materialized='view') }}

select
    customer_id,
    first_name,
    last_name,
    first_name || ' ' || last_name    as full_name,
    lower(email)                      as email,
    phone,
    city,
    state,
    signup_date,
    is_active,
    updated_at
from {{ source('customers', 'customers') }}
where customer_id is not null