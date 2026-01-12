with 

source as (

    select * from {{ source('raw_bigquery_data', 'patients') }}

),

renamed as (

    select
        patient_id,
        name,
        sex,
        dob,
        insurance

    from source

)

select * from renamed