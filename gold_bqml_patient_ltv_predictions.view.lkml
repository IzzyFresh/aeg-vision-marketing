view: gold_bqml_patient_ltv_predictions {
  sql_table_name: `analytics-386417.aeg_vision_marketing.gold_bqml_patient_ltv_predictions` ;;
  label: "BQML Model 2: Optical Spend & 24m pLTV"

  dimension: appointment_id {
    primary_key: yes
    type: string
    label: "Appointment ID"
    description: "Unique appointment ID scored by BQML model bqml_optical_ltv_regressor (LINEAR_REG)."
    sql: ${TABLE}.appointment_id ;;
  }

  dimension: vbb_bidding_segment {
    type: string
    label: "BQML Value-Based Bidding (VBB) Segment"
    description: "Audience segment for Google Ads & Meta Value-Based Bidding: Tier 1: VIP Designer Optical + Specialty Lens ($550+), Tier 2: High-Attach Eyewear & Contacts ($320-$549), or Tier 3: Standard Routine Exam (<$320)."
    sql: ${TABLE}.vbb_bidding_segment ;;
  }

  dimension: predicted_first_visit_revenue_usd {
    type: number
    label: "BQML Predicted First-Visit Revenue ($)"
    description: "BQML Linear Regression prediction of total exam + optical dispensary spend on the first visit."
    sql: ${TABLE}.predicted_first_visit_revenue_usd ;;
    value_format_name: usd
  }

  dimension: predicted_optical_dispensary_spend_usd {
    type: number
    label: "BQML Predicted Optical Dispensary Spend ($)"
    description: "Predicted retail eyewear and lens spend at the optical dispensary."
    sql: ${TABLE}.predicted_optical_dispensary_spend_usd ;;
    value_format_name: usd
  }

  dimension: predicted_24m_patient_ltv_usd {
    type: number
    label: "BQML Predicted 24-Month Patient LTV ($)"
    description: "Predicted 24-month customer lifetime value incorporating repeat annual exams, designer frame upgrades, and contact lens replenishment."
    sql: ${TABLE}.predicted_24m_patient_ltv_usd ;;
    value_format_name: usd
  }

  measure: avg_predicted_first_visit_revenue {
    type: average
    label: "Avg BQML Predicted First-Visit Value ($)"
    description: "Average predicted first-visit revenue per booked patient."
    sql: ${predicted_first_visit_revenue_usd} ;;
    value_format_name: usd
  }

  measure: avg_predicted_optical_spend {
    type: average
    label: "Avg BQML Predicted Optical Spend ($)"
    description: "Average predicted optical dispensary eyewear spend per patient."
    sql: ${predicted_optical_dispensary_spend_usd} ;;
    value_format_name: usd
  }

  measure: avg_predicted_24m_patient_ltv {
    type: average
    label: "Avg BQML Predicted 24-Month LTV ($)"
    description: "Average predicted 24-month patient lifetime value."
    sql: ${predicted_24m_patient_ltv_usd} ;;
    value_format_name: usd
  }

  measure: total_predicted_24m_ltv_pipeline {
    type: sum
    label: "Total Predicted 24-Month LTV Pipeline ($)"
    description: "Sum of predicted 24-month patient LTV across all acquired patients."
    sql: ${predicted_24m_patient_ltv_usd} ;;
    value_format_name: usd
  }
}
