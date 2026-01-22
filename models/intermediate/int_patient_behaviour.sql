-- patient-level table prep for cohort analysis and modeling

select 
    patient_id,
    count(*) as total_appointments,
    sum(case when status = 'attended' then 1 else 0 end) as attended_appointments,
    sum(case when status = 'did not attend' then 1 else 0 end) as no_shows,
    avg(waiting_time) as avg_wait_time,
    avg(scheduling_interval) as avg_scheduling_interval

from {{ ref('stg_raw_data_appointments') }}
group by patient_id

