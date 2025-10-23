{{ config(materialized='table') }}

with spine as (
  {{ dbt_utils.date_spine(
      datepart="day",
      start_date="'2001-01-01'",
      end_date="'2030-01-01'"
  ) }}
),

formatted as (
  select
    date_day as d
  from spine
)

select
  {{ dbt_utils.generate_surrogate_key(["FORMAT_DATE('%F', d)"]) }} as date_key,
  d as full_date,
  EXTRACT(YEAR FROM d) as year,
  EXTRACT(MONTH FROM d) as month,
  EXTRACT(DAY FROM d) as day,
  EXTRACT(WEEK FROM d) as week_of_year,
  EXTRACT(DAYOFYEAR FROM d) as day_of_year,
  EXTRACT(QUARTER FROM d) as quarter_of_year,
  EXTRACT(DAYOFWEEK FROM d) as day_of_week,
  FORMAT_DATE('%B', d) as month_name,
  FORMAT_DATE('%A', d) as day_name,
  (LAST_DAY(d) = d) as is_last_day_of_month,
  (EXTRACT(DAYOFWEEK FROM d) IN (1, 7)) as is_weekend
from formatted
