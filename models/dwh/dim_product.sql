{{ config(materialized='table', schema='dwh', tags=['dimension']) }}

SELECT
  {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_key,
  stg_product.product_id,
  stg_product.name AS product_name,
  stg_product.product_number,
  stg_product.color,
  stg_product.class,
  stg_product_subcategory.name AS product_subcategory_name,
  stg_product_category.name AS product_category_name
FROM
  {{ ref('stg_product') }}
LEFT JOIN
  {{ ref('stg_product_subcategory') }}
ON
  stg_product.product_subcategory_id = stg_product_subcategory.product_subcategory_id
LEFT JOIN
  {{ ref('stg_product_category') }}
ON
  stg_product_subcategory.product_category_id = stg_product_category.product_category_id
