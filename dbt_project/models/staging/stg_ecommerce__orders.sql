WITH source AS (
    SELECT * 
    FROM {{source('thelook_ecommerce', 'orders')}}
)

SELECT 
    order_id,
    user_id,
    status,
    gender,
    num_of_item

FROM source