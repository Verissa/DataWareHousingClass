--Get raw data
with source as (
    select * from {{ source('main','fhv_tripdata')}}
),

renamed as (

    select
        --trim the extra blankspaces and convert all strings to upper case and removed SR_flag column
        trim(upper(dispatching_base_num)) as dispatching_base_number,
        pickup_datetime,
        dropOff_datetime,
        PUlocationID as pickup_locationID,
        DOlocationID as dropOff_locationID,
        trim(upper(affiliated_base_number)) as affiliated_base_number,
        trim(upper(filename)) as filename
    
    from source
)

select * from renamed