WITH orders AS (
    SELECT
        order_id,
        user_id
    FROM {{ ref('stg_ecommerce__orders') }}
),

order_items AS (
    SELECT
        order_id,
        sale_price
    FROM {{ ref('stg_ecommerce__order_items') }}
),

user_orders_joined AS (
    SELECT
        o.order_id,
        o.user_id,
        oi.sale_price
    FROM orders AS o
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
)

SELECT
    user_id,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sale_price) AS total_spend
FROM user_orders_joined
GROUP BY user_id
