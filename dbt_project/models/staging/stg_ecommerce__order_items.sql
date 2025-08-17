WITH source AS (
    SELECT * 
    FROM {{source('thelook_ecommerce', 'order_items')}}
)

SELECT 
    id,
    order_id,
    user_id,
    product_id,
    inventory_item_id,
    status
FROM source