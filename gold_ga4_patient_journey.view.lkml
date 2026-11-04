view: gold_ga4_patient_journey {
  sql_table_name: `analytics-386417.aeg_vision_marketing.gold_ga4_patient_journey` ;;
  label: "Gold Patient Journey (GA4 to Clinic EHR)"

  dimension: appointment_id {
    primary_key: yes
    type: string
    label: "Appointment ID"
    description: "Unique clinic appointment identifier linking GA4 online booking to practice EHR/POS outcome."
    sql: ${TABLE}.appointment_id ;;
  }

  dimension: ga4_session_id {
    type: string
    label: "GA4 Session ID"
    description: "Google Analytics 4 session identifier."
    sql: ${TABLE}.ga4_session_id ;;
  }

  dimension: ga4_user_pseudo_id {
    type: string
    label: "GA4 User Pseudo ID"
    description: "Anonymous GA4 cookie/device identifier."
    sql: ${TABLE}.ga4_user_pseudo_id ;;
  }

  dimension_group: booking {
    type: time
    label: "Online Booking"
    description: "Date when the patient booked their appointment on the website (GA4 book_eye_exam event)."
    timeframes: [raw, date, week, month, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.booking_date ;;
  }

  dimension_group: appointment {
    type: time
    label: "Scheduled Exam"
    description: "Date of the scheduled in-clinic eye exam (includes upcoming 14-day scheduled appointments for BQML live scoring)."
    timeframes: [raw, date, week, month, year, day_of_week]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.appointment_date ;;
  }

  dimension: lead_time_days {
    type: number
    label: "Booking Lead Time (Days)"
    description: "Number of days between the online GA4 booking date and the scheduled clinic appointment date. Longer lead times (>10 days) correlate strongly with higher No-Show risk."
    sql: ${TABLE}.lead_time_days ;;
  }

  dimension: practice_id {
    type: string
    label: "Practice ID"
    sql: ${TABLE}.practice_id ;;
  }

  dimension: practice_brand {
    type: string
    label: "Regional Practice Brand"
    description: "AEG Vision regional practice brand where the appointment is scheduled."
    sql: ${TABLE}.practice_brand ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    label: "State"
    sql: ${TABLE}.state ;;
  }

  dimension: dma_market {
    type: string
    label: "DMA Market"
    sql: ${TABLE}.dma_market ;;
  }

  dimension: campaign_id {
    type: string
    label: "Campaign ID"
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: acquisition_channel {
    type: string
    label: "Acquisition Channel"
    description: "Marketing channel that acquired the booking (Paid Social - Meta, Paid Social - TikTok, Paid Search - Google, Paid Video - YouTube)."
    sql: ${TABLE}.acquisition_channel ;;
  }

  dimension: campaign_theme {
    type: string
    label: "Campaign Theme"
    description: "Marketing campaign theme that drove the patient booking."
    sql: ${TABLE}.campaign_theme ;;
  }

  dimension: utm_source {
    type: string
    label: "GA4 UTM Source"
    sql: ${TABLE}.utm_source ;;
  }

  dimension: utm_medium {
    type: string
    label: "GA4 UTM Medium"
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: device_category {
    type: string
    label: "GA4 Device Category"
    description: "Device used during GA4 booking session (mobile vs desktop)."
    sql: ${TABLE}.device_category ;;
  }

  dimension: exam_type {
    type: string
    label: "Booked Exam Type"
    description: "Type of optometry appointment booked (Comprehensive Eye Exam, Contact Lens Fitting & Exam, Medical / Dry Eye Evaluation, Pediatric Vision Exam)."
    sql: ${TABLE}.exam_type ;;
  }

  dimension: insurance_verified {
    type: yesno
    label: "Vision Insurance Pre-Verified Online?"
    description: "Whether the patient verified their VSP/EyeMed/insurance benefits during the online booking flow."
    sql: ${TABLE}.insurance_verified ;;
  }

  dimension: insurance_carrier {
    type: string
    label: "Vision Insurance Carrier / Payor"
    description: "Vision plan or payment method (VSP Vision Care, EyeMed, UnitedHealthcare Vision, Davis Vision, Self-Pay / FSA-HSA)."
    sql: ${TABLE}.insurance_carrier ;;
  }

  dimension: patient_age_group {
    type: string
    label: "Patient Age Group"
    description: "Age bracket of the patient (18-29, 30-44, 45-59, 60+)."
    sql: ${TABLE}.patient_age_group ;;
  }

  dimension: is_new_patient {
    type: yesno
    label: "Is New Patient?"
    description: "True if this is the patient's first visit to an AEG Vision clinic."
    sql: ${TABLE}.is_new_patient ;;
  }

  dimension: frames_viewed_count {
    type: number
    label: "GA4 Virtual Frame Gallery Views"
    description: "Number of designer frames the patient browsed or virtually tried on during their GA4 booking session."
    sql: ${TABLE}.frames_viewed_count ;;
  }

  dimension: appointment_status {
    type: string
    label: "Appointment Status"
    description: "Current clinic status: Completed, No_Show, Cancelled, or Scheduled (upcoming next 14 days)."
    sql: ${TABLE}.appointment_status ;;
  }

  dimension: optical_dispensary_attached {
    type: yesno
    label: "Purchased Eyewear at Dispensary?"
    description: "True if the patient purchased frames, lenses, or contact lenses during their completed visit."
    sql: ${TABLE}.optical_dispensary_attached ;;
  }

  measure: total_appointments {
    type: count
    label: "Total Booked Appointments"
    description: "Count of total booked appointments."
  }

  measure: completed_visits_count {
    type: count_distinct
    label: "Completed Visits"
    description: "Number of completed in-chair appointments."
    sql: ${appointment_id} ;;
    filters: [appointment_status: "Completed"]
  }

  measure: noshow_visits_count {
    type: count_distinct
    label: "No-Show Visits"
    description: "Number of appointments where the patient did not show up."
    sql: ${appointment_id} ;;
    filters: [appointment_status: "No_Show"]
  }

  measure: upcoming_scheduled_count {
    type: count_distinct
    label: "Upcoming Scheduled Appointments"
    description: "Number of future scheduled appointments in the next 14 days."
    sql: ${appointment_id} ;;
    filters: [appointment_status: "Scheduled"]
  }

  measure: average_lead_time_days {
    type: average
    label: "Avg Booking Lead Time (Days)"
    description: "Average number of days between online booking and appointment date."
    sql: ${lead_time_days} ;;
    value_format_name: decimal_1
  }

  measure: average_frames_viewed {
    type: average
    label: "Avg Virtual Frames Viewed in GA4"
    description: "Average number of frames browsed in the GA4 frame gallery per booking."
    sql: ${frames_viewed_count} ;;
    value_format_name: decimal_1
  }

  measure: total_realized_revenue {
    type: sum
    label: "Total Realized Patient Revenue ($)"
    description: "Total clinical exam + optical dispensary revenue collected from completed visits."
    sql: ${TABLE}.realized_patient_revenue_usd ;;
    value_format_name: usd
  }

  measure: total_optical_dispensary_revenue {
    type: sum
    label: "Total Optical Dispensary Revenue ($)"
    description: "Total revenue from designer frames, progressive lenses, and contact lenses."
    sql: ${TABLE}.total_optical_dispensary_usd ;;
    filters: [appointment_status: "Completed"]
    value_format_name: usd
  }

  measure: average_revenue_per_completed_patient {
    type: average
    label: "Avg Revenue Per Completed Exam ($)"
    description: "Average combined clinical + optical spend per completed patient visit."
    sql: ${TABLE}.realized_patient_revenue_usd ;;
    filters: [appointment_status: "Completed"]
    value_format_name: usd
  }
}
