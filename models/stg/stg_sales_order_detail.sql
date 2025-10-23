{{ config(materialized='table', tags=['staging']) }}

SELECT
    DISTINCT *
FROM 
    {{ source('raw', 'sales_order_detail') }}
