WITH source AS (
    SELECT * 
    FROM {{source('thelook_ecommerce', 'users')}}
)

SELECT 
    id,
    first_name,
    last_name,
    email,
    age,
    gender,
    city,
    state,
    country,
    traffic_source,
    created_at,
    CAST(created_at AS TIMESTAMP) AS user_creation_timestamp

FROM source