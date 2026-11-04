view: gold_bqml_noshow_predictions {
  sql_table_name: `analytics-386417.aeg_vision_marketing.gold_bqml_noshow_predictions` ;;
  label: "BQML Model 1: Patient No-Show Propensity"

  dimension: appointment_id {
    primary_key: yes
    type: string
    label: "Appointment ID"
    description: "Unique appointment ID scored by BQML model bqml_patient_noshow_classifier (LOGISTIC_REG)."
    sql: ${TABLE}.appointment_id ;;
  }

  dimension: predicted_noshow_probability {
    type: number
    label: "BQML Predicted No-Show Probability"
    description: "Probability (0.0 to 1.0) predicted by BigQuery ML Logistic Regression that this booked appointment will result in a clinic No-Show."
    sql: ${TABLE}.predicted_noshow_probability ;;
    value_format_name: percent_1
  }

  dimension: noshow_risk_tier {
    type: string
    label: "BQML No-Show Risk Tier"
    description: "Risk bucket based on BQML predicted probability: High Risk (>=60%), Medium Risk (35-59%), or Low Risk (<35%)."
    sql: ${TABLE}.noshow_risk_tier ;;
  }

  dimension: recommended_retention_action {
    type: string
    label: "AI Recommended Patient Retention Action"
    description: "Automated workflow action recommended by BQML based on the patient's No-Show risk tier (e.g., Trigger 2-Way SMS Confirmation + $25 Frame Deposit Incentive & Overbook Slot)."
    sql: ${TABLE}.recommended_retention_action ;;
  }

  measure: avg_predicted_noshow_probability {
    type: average
    label: "Avg BQML Predicted No-Show Probability (%)"
    description: "Average BQML predicted probability of No-Show across selected appointments."
    sql: ${predicted_noshow_probability} ;;
    value_format_name: percent_1
  }

  measure: high_risk_appointments_count {
    type: count_distinct
    label: "High-Risk No-Show Appointments (>=60%)"
    description: "Count of appointments flagged by BQML in the High Risk (>=60% probability) tier."
    sql: ${appointment_id} ;;
    filters: [noshow_risk_tier: "High Risk (>=60%)"]
  }

  measure: total_revenue_at_risk {
    type: sum
    label: "BQML Total Expected Revenue at Risk ($)"
    description: "Expected clinical + optical revenue multiplied by each appointment's BQML No-Show probability."
    sql: ${TABLE}.revenue_at_risk_usd ;;
    value_format_name: usd
  }
}
