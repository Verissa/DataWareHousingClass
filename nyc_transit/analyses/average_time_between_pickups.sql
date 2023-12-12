.echo on

-- CTE to calculate time difference between consecutive pickups for each zone
WITH zone_next_pickup_secs AS (
    SELECT
        mart__dim_locations.zone,
        DATEDIFF('second', mart__fact_all_taxi_trips.pickup_datetime, 
            LEAD(mart__fact_all_taxi_trips.pickup_datetime) 
            OVER (PARTITION BY mart__dim_locations.zone ORDER BY mart__fact_all_taxi_trips.pickup_datetime)) 
        AS time_to_next_pickup
    FROM "main"."main"."mart__fact_all_taxi_trips"
    JOIN "main"."main"."mart__dim_locations" ON mart__fact_all_taxi_trips.pickup_locationid = mart__dim_locations.locationid
)

-- Calculate average time between pickups for all zones
SELECT
    zone,
    AVG(time_to_next_pickup) AS avg_time_between_pickups
FROM zone_next_pickup_secs
GROUP BY ALL;