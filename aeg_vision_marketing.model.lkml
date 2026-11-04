connection: "analytics-project"

include: "*.view.lkml"

label: "AEG Vision Marketing & Predictive AI"

explore: marketing_roi_gold {
  from: gold_marketing_funnel_daily
  label: "1. Gold: Full-Funnel Marketing & Social ROI"
  description: "Executive Gold mart unifying Meta, TikTok, Google Search/PMax, and YouTube ad spend with GA4 online eye exam bookings, completed in-chair visits, No-Shows, optical dispensary eyewear revenue, and True ROAS across AEG Vision regional practice brands."

  join: dim_aeg_practices {
    type: left_outer
    relationship: many_to_one
    sql_on: ${marketing_roi_gold.practice_id} = ${dim_aeg_practices.practice_id} ;;
  }
}

explore: patient_journey_and_bqml_propensity {
  from: gold_ga4_patient_journey
  label: "2. Gold + BQML: Patient Journey, No-Show Risk & 24m pLTV"
  description: "Patient-level journey from GA4 online session and virtual frame try-on to clinic appointment outcome, joined with BQML Model 1 (Appointment No-Show Propensity Classifier) and BQML Model 2 (Optical Dispensary Spend & 24-Month Patient LTV Regressor)."

  join: gold_bqml_noshow_predictions {
    type: left_outer
    relationship: one_to_one
    sql_on: ${patient_journey_and_bqml_propensity.appointment_id} = ${gold_bqml_noshow_predictions.appointment_id} ;;
  }

  join: gold_bqml_patient_ltv_predictions {
    type: left_outer
    relationship: one_to_one
    sql_on: ${patient_journey_and_bqml_propensity.appointment_id} = ${gold_bqml_patient_ltv_predictions.appointment_id} ;;
  }

  join: dim_aeg_practices {
    type: left_outer
    relationship: many_to_one
    sql_on: ${patient_journey_and_bqml_propensity.practice_id} = ${dim_aeg_practices.practice_id} ;;
  }
}

explore: bqml_demand_and_budget_forecast {
  from: gold_bqml_30d_demand_forecast
  label: "3. Gold + BQML: 30-Day Exam Demand & Chair Capacity Forecast"
  description: "BigQuery ML ARIMA_PLUS 30-day daily eye exam demand forecast by AEG Vision practice brand, comparing forecasted online bookings against available optometrist chair capacity, unfilled chair revenue opportunity, and AI budget pacing recommendations."

  join: dim_aeg_practices {
    type: left_outer
    relationship: many_to_one
    sql_on: ${bqml_demand_and_budget_forecast.practice_id} = ${dim_aeg_practices.practice_id} ;;
  }
}

explore: bronze_ga4_events_raw {
  from: bronze_ga4_events
  label: "4. Bronze: Raw GA4 Event Stream (Medallion Lineage)"
  description: "Raw BigQuery GA4 event export table showing nested device, geo, traffic_source, and event_params structs before Silver/Gold medallion transformation."
}
