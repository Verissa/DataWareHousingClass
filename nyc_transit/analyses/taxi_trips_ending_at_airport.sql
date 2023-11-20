SELECT
    COUNT(*) as total_trips
FROM
    mart__fact_all_taxi_trips
WHERE
    dropOff_locationID IN (
        SELECT
            LocationID
        FROM
            mart__dim_locations
        WHERE
            service_zone IN ('Airports', 'EWR')
    );
    
