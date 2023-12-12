    select 
        locations.borough, 
        count(trips.*) as all_trips
    from {{ ref('mart__fact_all_taxi_trips') }} trips 
    join {{ ref('mart__dim_locations') }} locations on trips.pickup_locationID = locations.locationid 
    group by all 