with 

source as (

    select * from {{ source('raw_bigquery_data', 'slots') }}

),

renamed as (

    select
        slot_id,
        appointment_date,
        appointment_time,
        is_available

    from source

)

select * from renamed