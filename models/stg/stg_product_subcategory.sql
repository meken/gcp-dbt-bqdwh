{{ config(materialized='table') }}

SELECT
    DISTINCT *
FROM
    {{ source('raw', 'product_subcategory') }}
