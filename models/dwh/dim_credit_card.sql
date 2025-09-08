{{ config(materialized='table', schema='dwh', tags=['dimension']) }}

SELECT
  {{ dbt_utils.generate_surrogate_key(['credit_card_id']) }} AS credit_card_key,
  credit_card_id,
  card_type
FROM
  {{ ref('stg_credit_card') }}
