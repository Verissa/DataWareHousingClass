WITH trips_renamed AS (
    -- Assuming there are columns pickup_locationID and dropoff_locationID in mart__fact_all_taxi_trips
    SELECT
        'taxi' as type,
        pickup_locationID,
        dropoff_locationID,
        pickup_datetime,
        dropoff_datetime,
        CASE
            WHEN p.Borough <> d.Borough THEN 1
            ELSE 0
        END AS different_borough
    FROM
        mart__fact_all_taxi_trips t
        INNER JOIN mart__dim_locations p ON t.pickup_locationID = p.LocationID
        INNER JOIN mart__dim_locations d ON t.dropoff_locationID = d.LocationID
)

SELECT
    EXTRACT(DAYOFWEEK FROM pickup_datetime) AS weekday,
    COUNT(*) AS total_trips,
    SUM(different_borough) AS trips_different_borough,
    (SUM(different_borough) / COUNT(*)) * 100 AS percentage_different_borough
FROM
    trips_renamed
GROUP BY
    weekday
ORDER BY
    weekday;
