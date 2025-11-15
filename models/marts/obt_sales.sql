{{ config(
    materialized='table',
    
    partition_by={
      'field': 'order_date',
      'data_type': 'date',
      'granularity': 'day'
    }
) }}

SELECT
  * EXCEPT(
    address_key,
    date_key,
    product_key,
    sales_key,
    customer_key,
    order_date_key,
    order_status_key,
    credit_card_key,
    ship_address_key
  )
FROM
  {{ ref('fact_sales') }}
LEFT JOIN
  {{ ref('dim_product') }}
ON
  fact_sales.product_key = dim_product.product_key
LEFT JOIN
  {{ ref('dim_customer') }}
ON
  fact_sales.customer_key = dim_customer.customer_key
LEFT JOIN
  {{ ref('dim_credit_card') }}
ON
  fact_sales.credit_card_key = dim_credit_card.credit_card_key
LEFT JOIN
  {{ ref('dim_order_status') }}
ON
  fact_sales.order_status_key = dim_order_status.order_status_key
LEFT JOIN
  {{ ref('dim_address') }}
ON
  fact_sales.ship_address_key = dim_address.address_key
LEFT JOIN
  {{ ref('dim_date') }}
ON
  fact_sales.order_date_key = dim_date.date_key
