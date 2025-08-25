WITH products AS (
    SELECT
        id AS product_id,
        cost,
        category,
        name AS product_name,
        brand AS product_brand,
        retail_price,
        department,
        sku
    FROM {{ ref('stg_ecommerce__products') }}
)

SELECT
    product_id,
    product_name,
    product_brand,
    category,
    department,
    sku,
    cost AS product_cost,
    retail_price AS product_retail_price
FROM products
