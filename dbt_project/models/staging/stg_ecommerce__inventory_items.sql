WITH source AS (
    SELECT * FROM {{source('thelook_ecommerce', 'inventory_items')}}
)

SELECT
    id,
    product_id,
    created_at,
    sold_at,
    cost,
    product_category,
    product_name,
    product_brand,
    product_retail_price,
    product_department,
    product_sku

FROM source