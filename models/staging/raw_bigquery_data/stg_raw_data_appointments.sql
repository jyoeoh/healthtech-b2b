with 

source as (

    select * from {{ source('raw_bigquery_data', 'appointments') }}

),

renamed as (

    select
        appointment_id,
        slot_id,
        scheduling_date,
        appointment_date,
        appointment_time,
        scheduling_interval,
        status,
        check_in_time,
        appointment_duration,
        start_time,
        end_time,
        waiting_time,
        patient_id,
        sex,
        age,
        age_group

    from source

)

select * from renamed