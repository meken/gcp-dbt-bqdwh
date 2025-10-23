{{ config(materialized='table') }}

SELECT 
    DISTINCT Status as status
FROM
    {{ source('raw', 'sales_order_header') }}
