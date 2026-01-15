select
    appointment_date,
    sum(case when is_scheduled then 1 else 0 end) as total_scheduled,
    sum(case when is_attended then 1 else 0 end) as total_attended,
    sum(case when is_cancelled then 1 else 0 end) as total_cancelled,
    sum(case when is_no_show then 1 else 0 end) as total_no_show,
    round(sum(case 
        when is_attended then 1 else 0 end)
        /nullif(sum(case when is_scheduled then 1 else 0 end), 0),2) as daily_attendance_rate,
    round((sum(case 
        when is_cancelled then 1 else 0 end)
        +sum(case when is_no_show then 1 else 0 end))
        /nullif(sum(case when is_scheduled then 1 else 0 end), 0),2) as dropoff_rate
from {{ ref('int_appointment_funnel') }}
group by appointment_date
order by appointment_date