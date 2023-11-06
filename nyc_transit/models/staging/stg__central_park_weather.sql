--Get raw data
with source as (
    select * from {{ source('main','central_park_weather')}}
),

renamed as (

    select
    --trim the extra blankspaces and convert all strings to upper case
        trim(upper(station)) as station,
        trim(upper(name)) as name,
        --converting date column from raw data to date data type
        date::date as date,
        --converting columns from raw data to double and int data types
        awnd::double as avg_daily_windspeed,
        prcp::double as precipitation,
        snow::double as snowfall,
        snwd::double as snow_depth,
        tmax::int as max_temperature,
        tmin::int as min_temperature,
        trim(upper(filename)) as filename
    
    from source
)

select * from renamed