WITH order_product_details AS (
    SELECT
        order_id,
        product_id,
        order_created_at,
        sale_price,
        profit_per_item
    FROM {{ ref('int_order_product_details') }}
)

SELECT
    DATE(order_created_at) AS sale_date,
    product_id,
    COUNT(DISTINCT order_id) AS daily_orders,
    COUNT(order_id) AS daily_items_sold, 
    SUM(sale_price) AS daily_revenue,
    SUM(profit_per_item) AS daily_profit
FROM order_product_details
GROUP BY 1, 2
ORDER BY 1, 2
