with trips_renamed as
(
    select 'fhv' as type, pickup_datetime, dropOff_datetime, pickup_locationID,dropOff_locationID
    from {{ ref('stg__fhv_tripdata')}}
    union all
    select 'fhvhv' as type, pickup_datetime, dropOff_datetime, pickup_locationID,dropOff_locationID
    from {{ ref('stg__fhvhv_tripdata')}}
    union all
    select 'green' as type, pickup_datetime, dropOff_datetime, pickup_locationID,dropOff_locationID
    from {{ ref('stg__green_tripdata')}}
    union all
    select 'yellow' as type, pickup_datetime, dropOff_datetime, pickup_locationID,dropOff_locationID
    from {{ ref('stg__yellow_tripdata')}}
)
select
    type,
    pickup_datetime,
    dropOff_datetime,
    datediff('minute', pickup_datetime, dropOff_datetime) as duration_min,
    datediff('second', pickup_datetime, dropOff_datetime) as duration_sec,
    pickup_locationID,
    dropOff_locationID
from trips_renamed
