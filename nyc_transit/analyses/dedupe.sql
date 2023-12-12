.echo on
WITH events AS (
    SELECT
        strptime(insert_timestamp, '%d/%m/%Y %H:%M') AS insert_timestamp,
        event_id,
        event_type,
        user_id,
        strptime(event_timestamp, '%d/%m/%Y %H:%M') AS event_timestamp
    FROM "main"."main"."events"
)
SELECT
    *
FROM events
qualify row_number() OVER (PARTITION BY event_id ORDER BY insert_timestamp DESC) = 1