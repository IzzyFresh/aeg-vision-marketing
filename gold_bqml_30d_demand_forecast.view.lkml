view: gold_bqml_30d_demand_forecast {
  sql_table_name: `analytics-386417.aeg_vision_marketing.gold_bqml_30d_demand_forecast` ;;
  label: "BQML Model 3: 30-Day Exam Demand & Chair Capacity Forecast"

  dimension: forecast_row_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(CAST(${TABLE}.forecast_date AS STRING), '-', ${TABLE}.practice_id) ;;
  }

  dimension_group: forecast {
    type: time
    label: "Forecast"
    description: "Future date (next 30 days) forecasted by BigQuery ML ARIMA_PLUS time-series model bqml_practice_exam_demand_forecaster."
    timeframes: [raw, date, week, month, day_of_week]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.forecast_date ;;
  }

  dimension: practice_id {
    type: string
    label: "Practice ID"
    sql: ${TABLE}.practice_id ;;
  }

  dimension: practice_brand {
    type: string
    label: "Regional Practice Brand"
    description: "AEG Vision regional practice brand."
    sql: ${TABLE}.practice_brand ;;
  }

  dimension: region {
    type: string
    label: "Region"
    sql: ${TABLE}.region ;;
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

  dimension: ai_budget_pacing_recommendation {
    type: string
    label: "BQML Ad Budget Pacing Recommendation"
    description: "Automated budget allocation directive based on forecasted chair utilization (<75% Under-Capacity -> Boost Local Meta & Google PMax +25%; 75-92% Optimal; >92% Near Capacity -> Shift to High-LTV FSA/HSA)."
    sql: ${TABLE}.ai_budget_pacing_recommendation ;;
  }

  measure: total_forecasted_booked_exams {
    type: sum
    label: "BQML Forecasted Booked Exams (30d)"
    description: "Total forecasted online eye exam bookings from BQML ARIMA_PLUS."
    sql: ${TABLE}.forecasted_daily_booked_exams ;;
    value_format_name: decimal_0
  }

  measure: total_forecast_lower_bound {
    type: sum
    label: "Forecast Lower Bound (90% CI)"
    description: "Lower bound of 90% prediction interval from ARIMA_PLUS."
    sql: ${TABLE}.forecast_lower_bound ;;
    value_format_name: decimal_0
  }

  measure: total_forecast_upper_bound {
    type: sum
    label: "Forecast Upper Bound (90% CI)"
    description: "Upper bound of 90% prediction interval from ARIMA_PLUS."
    sql: ${TABLE}.forecast_upper_bound ;;
    value_format_name: decimal_0
  }

  measure: total_available_chair_capacity {
    type: sum
    label: "Total Available Exam Chair Slots"
    description: "Total available optometrist exam chair slots over the forecasted period."
    sql: ${TABLE}.daily_chair_capacity ;;
    value_format_name: decimal_0
  }

  measure: projected_chair_utilization_pct {
    type: number
    label: "Projected Chair Utilization (%)"
    description: "Forecasted booked exams divided by available optometrist chair capacity."
    sql: SAFE_DIVIDE(${total_forecasted_booked_exams}, NULLIF(${total_available_chair_capacity}, 0)) ;;
    value_format_name: percent_1
  }

  measure: total_unfilled_chair_slots {
    type: sum
    label: "Forecasted Unfilled Exam Chair Slots"
    description: "Projected empty doctor chair slots where local paid social/search demand falls short of clinic capacity."
    sql: ${TABLE}.unfilled_daily_chair_slots ;;
    value_format_name: decimal_0
  }

  measure: total_unfilled_chair_revenue_opportunity {
    type: sum
    label: "Unfilled Chair Revenue Opportunity ($)"
    description: "Estimated clinical + optical revenue opportunity ($410/visit) sitting in projected empty exam chairs over the next 30 days."
    sql: ${TABLE}.unfilled_chair_revenue_opportunity_usd ;;
    value_format_name: usd
  }
}
