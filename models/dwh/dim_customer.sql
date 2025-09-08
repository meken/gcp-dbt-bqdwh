{{ config(materialized='table', schema='dwh', tags=['dimension']) }}

SELECT
  {{ dbt_utils.generate_surrogate_key(['customer_id']) }} AS customer_key,
  stg_customer.customer_id,
  stg_person.business_entity_id AS person_business_entity_id,
  CONCAT( 
    COALESCE(stg_person.first_name,""), " ", 
    COALESCE(stg_person.middle_name,""), " ", 
    COALESCE(stg_person.last_name,"") 
  ) AS full_name,
  stg_person.total_purchase_ytd,
  stg_person.date_first_purchase,
  stg_person.birth_date,
  stg_person.marital_status,
  stg_person.yearly_income,
  stg_person.gender,
  stg_person.total_children,
  stg_person.number_children_at_home,
  stg_person.education,
  stg_person.occupation,
  stg_person.home_owner_flag,
  stg_person.number_cars_owned,
  stg_person.commute_distance
FROM
  {{ ref('stg_customer') }}
LEFT JOIN
  {{ ref('stg_person') }}
ON
  stg_customer.person_id = stg_person.business_entity_id
