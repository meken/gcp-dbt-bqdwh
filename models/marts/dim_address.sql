{{ config(materialized='table') }}

SELECT
  {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_key,
  stg_address.address_id,
  stg_address.city AS city,
  stg_state_province.name AS state,
  stg_country_region.name AS country
FROM
  {{ ref('stg_address') }}
LEFT JOIN
  {{ ref('stg_state_province') }}
ON
  stg_address.state_province_id = stg_state_province.state_province_id
LEFT JOIN
  {{ ref('stg_country_region') }}
ON
  stg_state_province.country_region_code = stg_country_region.country_region_code
