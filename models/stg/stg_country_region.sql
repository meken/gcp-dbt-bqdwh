{{ config(materialized='table', tags=['staging']) }}

SELECT 
    DISTINCT *
FROM
    {{ source('raw', 'country_region') }}
