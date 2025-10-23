{{ config(materialized='table', tags=['staging']) }}

SELECT 
    DISTINCT * EXCEPT(comment, order_date, ship_date, due_date), 
    CAST(order_date as DATE) AS order_date, 
    CAST(ship_date as DATE) AS ship_date,
    CAST(due_date as DATE) AS due_date
FROM
    {{ source('raw', 'sales_order_header') }}
