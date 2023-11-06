--Reference https://docs.getdbt.com/guides/dbt-ecosystem/dbt-python-snowpark/9-sql-transformations
--Get raw data
with source as (
    select * from {{ source('main','yellow_tripdata')}} where trip_distance >= 0
),

renamed as (

    select
        vendorID,
        tpep_pickup_datetime as pickup_datetime,
        tpep_dropOff_datetime as dropOff_datetime,
        passenger_count,
        trip_distance,
        ratecodeID,
        store_and_fwd_flag::boolean as store_and_fwd_flag,
        PUlocationID as pickup_locationID,
        DOlocationID as dropOff_locationID,
        payment_type,
        fare_amount,
        extra,
        --https://docs.getdbt.com/sql-reference/case for handling garbage values
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
        congestion_surcharge,
        case when congestion_surcharge < 0.00 then 0.00
            else congestion_surcharge
        end as congestion_surcharge,
        airport_fee,
        case when airport_fee < 1.25 then 0.00
            else airport_fee
        end as airport_fee,
    --trim the extra blankspaces and convert all strings to upper case
        trim(upper(filename)) as filename    
    from source
)

select * from renamed