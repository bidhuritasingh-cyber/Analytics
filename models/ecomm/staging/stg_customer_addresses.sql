{{ config(materialized='view') }}

select
    address_id,
    customer_id,
    address_type                           as address_category,
    street,
    city,
    state,
    pincode,
    is_default,
    case
        when address_type = 'shipping' then true
        else false
    end                                    as is_shipping
from {{ source('customers', 'customer_addresses') }}