{{ config(materialized='table') }}

SELECT 
    DISTINCT *
FROM
    {{ source('raw', 'credit_card') }}
