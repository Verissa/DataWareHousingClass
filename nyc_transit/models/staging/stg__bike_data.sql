--source : https://docs.getdbt.com/blog/coalesce-sql-love-letter
with source as (
    select * from {{ source('main','bike_data')}}
),

renamed as (

    select
        starttime:: timestamp as starttime,
        started_at:: timestamp as startedAt,
        stoptime:: timestamp as stoptime,
        ended_at:: timestamp as endedAt,
        tripduration::bigint as tripduration,
        --https://docs.getdbt.com/sql-reference/datediff
        COALESCE(tripduration, DATE_DIFF('second', startedAt, endedAt)) AS tripduration,
        --coalesce to pick the first value and when it is null it picks the value from the old schema
        coalesce(starttime, startedAt) as started_at,
        coalesce(stoptime, endedAt) as ended_at,
        'start station id',
        start_station_id,
        upper(trim(coalesce('start station id', start_station_id))) as start_station_id,
        start_station_name,
        'start station name',
        upper(trim(coalesce('start station name', start_station_name))) as start_station_name,
        start_lat::double as start_lat,
        'start station latitude':: double as 'start station latitude', 
        coalesce('start station latitude', start_lat) as start_station_latitude,
        start_lng:: double as start_lng,
        'start station longitude':: double as 'start station longitude',
        coalesce('start station longitude', start_lng) as start_station_longitude,
        'end station id',
        end_station_id,
        upper(trim(coalesce('end station id', end_station_id))) as end_station_id,
        'end station name',
        end_station_name,
        upper(trim(coalesce('end station name', end_station_name))) as end_station_name,
        'end station latitude'::double as 'end station latitude ',
        end_lat:: double as end_lat,
        coalesce('end station latitude', end_lat) as end_station_latitude,
        'end station longitude':: double as 'end station longitude',
        end_lng:: double as end_lng,
        coalesce('end station longitude', end_lng) as end_station_longitude,
        bikeid,
        ride_id,
        upper(trim(coalesce(bikeid,ride_id))) as bike_rideID,
        trim(coalesce('birth year', NULL)) as birth_year,
        gender::int as gender,
        coalesce(gender, NULL) as gender,
        coalesce(rideable_type, NULL) as rideable_type,
        usertype,
        case when usertype = 'Subscriber' then 'member'
            else 'casual'
        end as usertype,
        upper(trim(coalesce(member_casual, usertype))) as usertype,
        filename
    
    from source
)

select * from renamed