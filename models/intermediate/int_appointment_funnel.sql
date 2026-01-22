-- funnel model

select 
    app.appointment_id,
    app.slot_id,
    app.patient_id,
    app.scheduling_date,
    app.appointment_date,
    app.scheduling_interval,
    app.status,
    app.waiting_time,
    app.appointment_duration,

    app.status = 'scheduled' as appointment_created,
    app.status = 'attended' as is_attended,
    app.status = 'cancelled' as is_cancelled,
    app.status = 'did not attend' as is_no_show,

    app.age,
    app.age_group,
    app.sex,
    
from {{ ref('stg_raw_data_appointments') }} as app
left join {{ ref('stg_raw_data_slots') }} as slots using (slot_id)