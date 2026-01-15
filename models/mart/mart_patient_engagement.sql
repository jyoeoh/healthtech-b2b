select
    patient_id,
    total_appointments,
    attended_appointments,
    no_shows,
    round(attended_appointments/nullif(total_appointments,0),2) as patient_attendance_rate,
    avg_wait_time,
    avg_scheduling_interval,
    case 
        when total_appointments >= 5 and no_shows = 0 then 'High engagement'
        when total_appointments >3 and no_shows <= 1 then 'Medium engagement'
        when no_shows >= 2 then 'High no-show risk'
        else 'Low engagement'
    end as engagement_segment

from {{ ref('int_patient_behaviour') }}
order by patient_attendance_rate desc