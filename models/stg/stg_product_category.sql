{{ config(materialized='table', schema='curated', tags=['staging']) }}

SELECT
    DISTINCT *
FROM
    {{ source('raw', 'product_category') }}
