WITH order_items AS (
    SELECT
        order_id,
        user_id,
        sale_price,
        created_at
    FROM {{ ref('stg_ecommerce__order_items') }}
)

SELECT
    user_id,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sale_price) AS total_spend,
    MIN(created_at) AS first_order_date,
    MAX(created_at) AS last_order_date  
FROM order_items
GROUP BY user_id