--stg_customers.sql
--1. Create stg_customer_addresses.sql — rename address_type to address_category, add a column is_shipping that is TRUE when address_type = 'shipping'. 

{{ config(materialized='view') }} 
 
select 
  address_id,
  customer_id,
  address_type AS address_category,
  street,
  city,
  state,
  pincode,
  is_default,
  CASE WHEN address_type = 'shipping' THEN 'TRUE' ELSE 'FALSE' END AS is_shipping
from {{ source('customers', 'customer_addresses') }}