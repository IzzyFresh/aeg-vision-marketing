view: bronze_ga4_events {
  sql_table_name: `analytics-386417.aeg_vision_marketing.bronze_ga4_events` ;;
  label: "Bronze Raw GA4 Event Stream (BigQuery Export)"

  dimension: event_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}.ga4_session_id, '-', ${TABLE}.event_name, '-', CAST(${TABLE}.event_timestamp AS STRING)) ;;
  }

  dimension_group: event {
    type: time
    label: "GA4 Event"
    description: "Date of the raw GA4 event."
    timeframes: [raw, date, week, month]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_date_parsed ;;
  }

  dimension: event_name {
    type: string
    label: "GA4 Event Name"
    description: "Raw GA4 event name: page_view, view_frame_gallery, select_practice_location, begin_exam_booking, or book_eye_exam."
    sql: ${TABLE}.event_name ;;
  }

  dimension: step_order {
    type: number
    label: "Funnel Step Order (1-5)"
    description: "Sequential order of the GA4 event in the online eye exam booking funnel."
    sql: ${TABLE}.step_order ;;
  }

  dimension: user_pseudo_id {
    type: string
    label: "GA4 User Pseudo ID"
    sql: ${TABLE}.user_pseudo_id ;;
  }

  dimension: ga4_session_id {
    type: string
    label: "GA4 Session ID"
    sql: ${TABLE}.ga4_session_id ;;
  }

  dimension: practice_brand {
    type: string
    label: "Practice Brand (Extracted Param)"
    sql: ${TABLE}.practice_brand ;;
  }

  dimension: state {
    type: string
    label: "State (Geo Struct)"
    sql: ${TABLE}.geo.region ;;
  }

  dimension: dma_market {
    type: string
    label: "DMA Metro (Geo Struct)"
    sql: ${TABLE}.geo.metro ;;
  }

  dimension: device_category {
    type: string
    label: "Device Category (Device Struct)"
    sql: ${TABLE}.device.category ;;
  }

  dimension: operating_system {
    type: string
    label: "Device OS (Device Struct)"
    sql: ${TABLE}.device.operating_system ;;
  }

  dimension: traffic_source {
    type: string
    label: "Traffic Source (Traffic Struct)"
    sql: ${TABLE}.traffic_source.source ;;
  }

  dimension: traffic_medium {
    type: string
    label: "Traffic Medium (Traffic Struct)"
    sql: ${TABLE}.traffic_source.medium ;;
  }

  dimension: campaign_theme {
    type: string
    label: "Campaign Name (Traffic Struct)"
    sql: ${TABLE}.traffic_source.name ;;
  }

  measure: total_events {
    type: count
    label: "Total Raw GA4 Events"
    description: "Total count of raw GA4 events in the Bronze export table."
  }

  measure: unique_sessions {
    type: count_distinct
    label: "Unique GA4 Sessions"
    sql: ${ga4_session_id} ;;
  }

  measure: unique_users {
    type: count_distinct
    label: "Unique GA4 Users"
    sql: ${user_pseudo_id} ;;
  }
}
