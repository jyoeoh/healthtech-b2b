select
    appointment_date,
    count(appointment_id) as total_appointments,
    sum(case when is_attended then 1 else 0 end) as total_attended,
    sum(case when is_cancelled then 1 else 0 end) as total_cancelled,
    sum(case when is_no_show then 1 else 0 end) as total_no_show,
    round(sum(case 
        when is_attended then 1 else 0 end)
        /nullif(count(appointment_id), 0),2) as daily_attendance_rate,
    round((sum(case 
        when is_cancelled then 1 else 0 end)
        +sum(case when is_no_show then 1 else 0 end))
        /nullif(count(appointment_id), 0),2) as dropoff_rate
        
from {{ ref('int_appointment_funnel') }}
group by appointment_date
order by appointment_date