{{ config(materialized='table', tags=['staging']) }}

SELECT 
    DISTINCT *
FROM
    {{ source('raw', 'customer') }}
