# Analytics Project: 
## Medical Appointment Scheduling System

This project analyzes a synthetic healthcare appointment scheduling dataset to simulate product analytics work for a B2B SaaS company serving medical clinics.
Resource: [LINK](https://www.kaggle.com/datasets/carogonzalezgaltier/medical-appointment-scheduling-system)

### Goal:
- To model appointment workflows, patient behavior, and operational efficiency using modern analytics tooling (BigQuery, dbt, SQL), and to surface insights that could
inform product decisions, workflow automation, and customer-facing reporting (Looker).

### Tables:
- **Appointments**: appointment lifecycle, status, waiting times, lead times
- **Slots**: time-based availability for appointments
- **Patients**: demographic information

The project follows a layered analytics modeling approach using dbt:
- **stg_ models**: clean and standardize raw data (checking types, naming)
- **int_ models**: add business meaning at the entity level (joining the tables for appointments, patients, slots)
- **mart_ models**: aggregate data into product and operational KPIs for analytics and Looker Studio

### Notes 
#### Appointment Funnel Modeling

The source data stores only the final status of an appointment (e.g. attended, cancelled, no-show), rather than each lifecycle event.
As a result:
- The funnel is modeled as outcome-based rather than step-based
- "Total appointments" is used as the funnel entry point (count of appointment IDs)
- Drop-off rate is defined as (cancelled + no-show) / total appointments

This approach avoids misleading metrics and reflects how real-world production systems often store data.



