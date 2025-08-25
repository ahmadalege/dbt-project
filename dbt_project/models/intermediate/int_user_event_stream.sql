WITH events AS (
    SELECT
        id AS event_id,
        user_id,
        city,
        state,
        event_type,
        traffic_source
    FROM {{ ref('stg_ecommerce__events') }}
),

users AS (
    SELECT
        id AS user_id,
        first_name,
        last_name,
        email,
        age,
        gender AS user_gender,
        country,
        created_at
    FROM {{ ref('stg_ecommerce__users') }}
)

SELECT
    e.event_id,
    e.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.age,
    u.user_gender,
    u.country AS user_country,
    u.created_at AS user_created_at, 
    e.city AS event_city,
    e.state AS event_state,
    e.event_type,
    e.traffic_source
FROM events AS e
LEFT JOIN users AS u
    ON e.user_id = u.user_id
