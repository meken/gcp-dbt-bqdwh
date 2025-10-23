{{ config(materialized='table') }}

SELECT
    DISTINCT *
FROM 
    {{ source('raw', 'sales_order_detail') }}
