.echo on

-- Counting trips by Zone from mart__fact_all_taxi_trips with a filter on the count
SELECT zone, count(t.*) trips  
FROM "main"."main"."mart__fact_all_taxi_trips" t 
JOIN "main"."main"."mart__dim_locations" l ON t.pickup_locationID = l.locationid 
GROUP BY all 
HAVING trips < 100000