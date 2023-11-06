--Reference https://docs.getdbt.com/guides/dbt-ecosystem/dbt-python-snowpark/9-sql-transformations
--Get raw data
with source as (
    select * from {{ source('main','fhvhv_tripdata')}} where request_datetime <= '2022-12-31'
),

renamed as (

    select
        --trim the extra blankspaces and convert all strings to upper case
        trim(upper(hvfhs_license_num)) as highvol_forhiresevs_licenseNum,
        trim(upper(dispatching_base_num)) as dispatching_base_number,
        trim(upper(originating_base_num)) as originating_base_number,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropOff_datetime,
        PUlocationID as pickup_locationID,
        DOlocationID as dropOff_locationID,
        trip_miles,
        trip_time,
        base_passenger_fare,
        tolls,
        bcf as black_car_fund,
        sales_tax,
        airport_fee,
        case when airport_fee < 2.50 then 0.00
            else airport_fee
        end as airport_fee,
        tips,
        driver_pay,
        congestion_surcharge,
        --converting string values to boolean
        shared_request_flag::boolean as shared_ride_request_flag,
        shared_match_flag::boolean as shared_ride_match_flag,
        access_a_ride_flag:: boolean as access_a_ride_flag,
        wav_request_flag:: boolean as wheelchairAccessVan_request_flag,
        wav_match_flag:: boolean as wheelchairAccessVan_match_flag, 
        trim(upper(filename)) as filename
    
    from source
)

select * from renamed