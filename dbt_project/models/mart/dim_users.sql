WITH users AS (
     SELECT
        id AS user_id,
        first_name,
        last_name,
        email,
        age,
        gender,
        city,
        state,
        country,
        traffic_source,
        user_creation_timestamp AS user_created_at
        FROM {{ ref('stg_ecommerce__users')}}
),

user_order_summary AS (
    SELECT
        user_id,
        total_orders,
        total_spend,
        first_order_date,
        last_order_date
    FROM {{ ref('int_user_order_summary') }}
)
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.age,
    u.gender,
    u.city,
    u.state,
    u.country,
    u.traffic_source,
    u.user_created_at,
    COALESCE(uos.total_orders, 0) AS total_orders, 
    COALESCE(uos.total_spend, 0.0) AS total_lifetime_spend, 
    uos.first_order_date,
    uos.last_order_date

FROM users AS u
LEFT JOIN user_order_summary AS uos
    ON u.user_id = uos.user_id
