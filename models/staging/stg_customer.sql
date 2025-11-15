{{ config(materialized='table') }}

SELECT 
    DISTINCT *
FROM
    {{ source('raw', 'customer') }}
