--Reference https://docs.getdbt.com/guides/dbt-ecosystem/dbt-python-snowpark/9-sql-transformations
--Get raw data
with source as (
    select * from {{ source('main','green_tripdata')}} where trip_distance >= 0 and lpep_pickup_datetime <= '2022-12-31'
),

renamed as (

    select
    --removed ehail_fee (all null values)
        vendorID,
        lpep_pickup_datetime as pickup_datetime,
        lpep_dropOff_datetime as dropOff_datetime,
        passenger_count,
        trip_distance,
        ratecodeID,
        store_and_fwd_flag::boolean as store_and_fwd_flag,
        PUlocationID as pickup_locationID,
        DOlocationID as dropOff_locationID,
        payment_type,
        fare_amount,
        --https://docs.getdbt.com/sql-reference/case for handling garbage values
        extra,
        case when extra < 0.50 then 0.00
            else extra
        end as extra,
        mta_tax,
        case when mta_tax < 0.50 then 0.00
            else mta_tax
        end as mta_tax,
        tip_amount,
        case when tip_amount < 0.00 then 0.00
            else tip_amount
        end as tip_amount,
        tolls_amount,
        case when tolls_amount < 0.00 then 0.00
            else tolls_amount
        end as tolls_amount,
        improvement_surcharge,
        case when improvement_surcharge < 0.30 then 0.00
            else improvement_surcharge
        end as improvement_surcharge,
        total_amount,
        case when total_amount < 0.00 then 0.00
            else total_amount
        end as total_amount,
        trip_type,
        congestion_surcharge,
            --trim the extra blankspaces and convert all strings to upper case
        trim(upper(filename)) as filename
    
    from source
)

select * from renamed