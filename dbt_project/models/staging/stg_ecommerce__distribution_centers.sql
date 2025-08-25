WITH source AS (
    SELECT * 
    FROM {{source('thelook_ecommerce', 'distribution_centers')}}
)

SELECT
    id, 
    name
FROM source 