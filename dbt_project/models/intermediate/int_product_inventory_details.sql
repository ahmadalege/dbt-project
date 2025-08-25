WITH inventory_items AS (
    SELECT
        id AS inventory_item_id,
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
    FROM {{ ref('stg_ecommerce__inventory_items') }}
),

products AS (
    SELECT
        id AS product_id,
        category,
        name,
        brand,
        retail_price,
        department,
        sku
    FROM {{ ref('stg_ecommerce__products') }}
)

SELECT
    ii.inventory_item_id,
    ii.product_id,
    p.category AS product_category_detail,
    p.name AS product_name_detail,
    p.brand AS product_brand_detail,
    p.retail_price AS product_retail_price_detail,
    p.department AS product_department_detail,
    p.sku AS product_sku_detail,
    ii.created_at AS inventory_created_at,
    ii.sold_at AS inventory_sold_at,
    ii.cost AS inventory_cost

FROM inventory_items AS ii
LEFT JOIN products AS p
    ON ii.product_id = p.product_id
