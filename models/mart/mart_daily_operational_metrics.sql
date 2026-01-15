with slots_per_day as(
    select
        appointment_date,
        count(slot_id) as total_slots,
        sum(case when was_booked then 1 else 0 end) as slots_booked,
        round(sum(case when was_booked then 1 else 0 end)/count(slot_id),2) as slot_utilization_rate,        
        sum(case when was_attended then 1 else 0 end) as appointments_attended,
        round(sum(case when was_booked AND NOT was_attended then 1 else 0 end)
            /nullif(sum(case when was_booked then 1 else 0 end), 0),2) as no_show_rate
from {{ ref('int_slots_utilization')  }}
group by appointment_date
)

select
    slots_per_day.*,
    avg(appt.waiting_time) as avg_wait_time,
    avg(appt.scheduling_interval) as avg_scheduling_interval
from slots_per_day
left join {{ ref('int_appointment_funnel')  }} as appt using (appointment_date)
group by slots_per_day.appointment_date, total_slots, slots_booked, slot_utilization_rate, appointments_attended, no_show_rate
order by slots_per_day.appointment_date
