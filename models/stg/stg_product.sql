{{ config(materialized='table', tags=['staging']) }}

SELECT 
  DISTINCT * EXCEPT(discontinued_date)
FROM 
    {{ source('raw', 'product') }}
