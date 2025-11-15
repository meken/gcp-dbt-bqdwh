{{ config(
    materialized='table',
    
    partition_by={
      'field': 'order_date',
      'data_type': 'date',
      'granularity': 'day'
    },
    cluster_by=['product_key']
) }}

SELECT
  {{ dbt_utils.generate_surrogate_key(['sod.sales_order_id', 'sod.sales_order_detail_id']) }} AS sales_key,
  {{ dbt_utils.generate_surrogate_key(['sod.product_id']) }} AS product_key,
  {{ dbt_utils.generate_surrogate_key(['customer_id']) }} AS customer_key,
  {{ dbt_utils.generate_surrogate_key(['credit_card_id']) }} AS credit_card_key,
  {{ dbt_utils.generate_surrogate_key(['ship_to_address_id']) }} AS ship_address_key,
  {{ dbt_utils.generate_surrogate_key(['status']) }} AS order_status_key,
  {{ dbt_utils.generate_surrogate_key(['order_date']) }} AS order_date_key,
  soh.order_date,
  sod.unit_price,
  sod.unit_price_discount,
  p.standard_cost AS cost_of_goods_sold,
  sod.order_qty AS order_quantity,
  sod.order_qty * sod.unit_price AS gross_revenue,
  sod.order_qty * (sod.unit_price * (1 - sod.unit_price_discount) - p.standard_cost) AS gross_profit
FROM
  {{ ref('stg_sales_order_detail') }} sod,
  {{ ref('stg_sales_order_header') }} soh,
  {{ ref('stg_product') }} p
WHERE
  sod.sales_order_id = soh.sales_order_id
  AND sod.product_id = p.product_id
