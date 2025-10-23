{{ config(materialized='table') }}

SELECT 
    DISTINCT *
FROM
    {{ source('raw', 'country_region') }}
