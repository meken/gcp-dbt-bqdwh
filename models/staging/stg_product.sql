{{ config(materialized='table') }}

SELECT 
  DISTINCT * EXCEPT(discontinued_date)
FROM 
    {{ source('raw', 'product') }}
