--Get raw data
with source as (
    select * from {{ source('main','fhv_bases')}}
),

renamed as (

    select
        --trim the extra blankspaces and convert all strings to upper case
        trim(upper(base_number)) as base_number,
        trim(upper(base_name)) as base_name,
        trim(upper(dba)) as doing_business_as,
        trim(upper(dba_category)) as doing_business_as_category,
        trim(upper(filename)) as filename
    
    from source
)

select * from renamed