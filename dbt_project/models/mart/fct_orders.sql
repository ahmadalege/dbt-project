WITH orders AS (
    SELECT
        order_id,
        user_id,
        status AS order_status,
        gender,
        created_at AS order_created_at 
    FROM {{ ref('stg_ecommerce__orders') }}
),
order_product_details AS (
    SELECT
        order_id,
        product_id,
        sale_price,
        profit_per_item,
        discount_per_item
    FROM {{ ref('int_order_product_details') }}
),


order_totals AS (
    SELECT
        order_id,
        SUM(sale_price) AS order_total_revenue,
        SUM(profit_per_item) AS order_total_profit,
        SUM(discount_per_item) AS order_total_discount,
        COUNT(product_id) AS total_items_ordered
    FROM order_product_details
    GROUP BY order_id
)

SELECT
    o.order_id,
    o.user_id,
    o.order_status,
    o.gender,
    o.order_created_at,
    ot.order_total_revenue,
    ot.order_total_profit,
    ot.order_total_discount,
    ot.total_items_ordered

FROM orders AS o
LEFT JOIN order_totals AS ot
    ON o.order_id = ot.order_id
