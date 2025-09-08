{{ config(materialized='table', schema='curated', tags=['staging']) }}

SELECT
    DISTINCT *
FROM 
    {{ source('raw', 'sales_order_detail') }}
