{{ config(materialized='table') }}

SELECT 
    DISTINCT *
FROM
    {{ source('raw', 'state_province') }}
