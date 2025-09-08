{{ config(materialized='table', schema='curated', tags=['staging']) }}

SELECT 
    DISTINCT Status as status
FROM
    {{ source('raw', 'sales_order_header') }}
