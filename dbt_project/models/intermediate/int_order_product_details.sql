WITH products AS (
    SELECT
        id AS product_id,
        department,
        cost,
        retail_price
    FROM {{ ref("stg_ecommerce__products") }}
),

order_items AS (
    SELECT
        id AS order_item_id,
        order_id,
        user_id,
        product_id,
        sale_price,
        created_at AS order_item_created_at,
        shipped_at AS order_item_shipped_at,
        delivered_at AS order_item_delivered_at,
        returned_at AS order_item_returned_at
    FROM {{ ref("stg_ecommerce__order_items") }}
),

orders AS (
    SELECT
        order_id,
        created_at AS order_created_at 
    FROM {{ ref("stg_ecommerce__orders") }}
)

SELECT
    oi.order_item_id,
    oi.order_id,
    oi.user_id,
    oi.product_id,
    oi.sale_price,
    p.department,
    p.cost,
    p.retail_price,
    o.order_created_at, 
    oi.order_item_created_at,
    oi.order_item_shipped_at,
    oi.order_item_delivered_at,
    oi.order_item_returned_at,

    oi.sale_price - p.cost AS profit_per_item,
    p.retail_price - oi.sale_price AS discount_per_item

FROM order_items AS oi
LEFT JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN orders AS o
    ON oi.order_id = o.order_id