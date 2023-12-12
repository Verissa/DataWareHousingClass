.echo on

-- Select all columns from mart__fact_all_taxi_trips where there is no matching LocationID in mart__dim_locations
SELECT mart__fact_all_taxi_trips.*
FROM "main"."main"."mart__fact_all_taxi_trips"
LEFT JOIN "main"."main"."mart__dim_locations"
ON mart__fact_all_taxi_trips.pickup_locationID = mart__dim_locations.locationid
WHERE mart__dim_locations.locationid IS NULL;