{{ config(materialized='table', schema='curated', tags=['staging']) }}

SELECT 
  DISTINCT * EXCEPT(discontinued_date)
FROM 
    {{ source('raw', 'product') }}
