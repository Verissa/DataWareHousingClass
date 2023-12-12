.echo on

SELECT 
    borough, 
    zone, 
    COUNT(*) AS trips, 
    AVG(mart__fact_all_taxi_trips.duration_min) AS avg_duration_mins
FROM 
    mart__fact_all_taxi_trips
-- Joins the taxi trips table with the locations table based on the common field "DOlocationID"
JOIN 
    mart__dim_locations ON mart__fact_all_taxi_trips.dropOff_locationID = mart__dim_locations.locationid
GROUP BY ALL;