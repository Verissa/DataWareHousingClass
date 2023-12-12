.echo on

-- Comparing individual fare to zone, borough, and overall average fare
SELECT 
    fare_amount,
    zone,
    AVG(fare_amount) OVER (PARTITION BY zone) AS zone_avg_fare,
    borough,
    AVG(fare_amount) OVER (PARTITION BY borough) AS borough_avg_fare,
    AVG(fare_amount) OVER () AS overall_avg_fare
FROM "main"."staging"."stg__yellow_tripdata" yellowtrips
JOIN "main"."main"."mart__dim_locations" locations ON yellowtrips.pickup_locationid = locations.locationid;