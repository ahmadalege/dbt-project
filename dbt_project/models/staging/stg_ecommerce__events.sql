WITH source AS (
    SELECT *
    FROM {{source('thelook_ecommerce', 'events')}}
)

SELECT 
id, 
user_id, 
city, 
state, 
event_type, 
traffic_source
FROM source