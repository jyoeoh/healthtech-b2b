-- Q: how often are slots waster/converted to attended appointments?

select
    slot.slot_id,
    slot.appointment_date,
    slot.appointment_time,
    slot.is_available,
    count(app.appointment_id) > 0 as was_booked, -- boolean for if slot was ever booked (true)
    max(app.status = 'attended') as was_attended -- if appointment was ever attended

from {{ ref('stg_raw_data_slots')  }} as slot
left join {{ ref('stg_raw_data_appointments')  }} as app using (slot_id)
group by
    slot.slot_id,
    slot.appointment_date,
    slot.appointment_time,
    slot.is_available