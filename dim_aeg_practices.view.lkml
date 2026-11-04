view: dim_aeg_practices {
  sql_table_name: `analytics-386417.aeg_vision_marketing.dim_aeg_practices` ;;
  label: "AEG Practice Brands & Clinics"

  dimension: practice_id {
    primary_key: yes
    type: string
    label: "Practice ID"
    description: "Unique identifier for the AEG Vision regional practice group (e.g., AEG-TX-01)."
    sql: ${TABLE}.practice_id ;;
  }

  dimension: practice_brand {
    type: string
    label: "Regional Practice Brand"
    description: "Local optometry brand name under AEG Vision's Keep-Your-Brand operating model (e.g., Texas State Optical - Dallas, North Suburban Vision Consultants, Envision Eyecare Group)."
    sql: ${TABLE}.practice_brand ;;
  }

  dimension: region {
    type: string
    label: "Geographic Region"
    description: "AEG Vision US operating region (Southwest, Midwest, Mountain, Southeast)."
    sql: ${TABLE}.region ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    label: "State"
    description: "Two-letter US State code where the practice group operates (TX, IL, NE, OH, CO, FL)."
    sql: ${TABLE}.state ;;
  }

  dimension: dma_market {
    type: string
    label: "DMA Metro Market"
    description: "Designated Market Area (DMA) metropolitan region for local paid search and social ad targeting."
    sql: ${TABLE}.dma_market ;;
  }

  dimension: clinic_specialty {
    type: string
    label: "Clinic Specialty Focus"
    description: "Primary clinical and optical specialty of the regional practice brand."
    sql: ${TABLE}.clinic_specialty ;;
  }

  dimension: clinic_locations_count {
    type: number
    label: "Clinic Locations in Group"
    description: "Number of physical optometry clinic locations in this regional practice group."
    sql: ${TABLE}.clinic_locations_count ;;
  }

  dimension: daily_chair_capacity {
    type: number
    label: "Daily Exam Chair Capacity"
    description: "Maximum number of daily eye exam appointments available across optometrist chairs in this practice group."
    sql: ${TABLE}.daily_chair_capacity ;;
  }

  dimension: monthly_exam_target {
    type: number
    label: "Monthly Exam Target"
    description: "Monthly target for completed eye exams across this regional practice group."
    sql: ${TABLE}.monthly_exam_target ;;
  }

  dimension: dma_affluence_index {
    type: number
    label: "DMA Affluence Index"
    description: "Market affluence multiplier influencing designer eyewear and specialty lens demand."
    sql: ${TABLE}.dma_affluence_index ;;
    value_format_name: decimal_2
  }

  measure: total_clinic_locations {
    type: sum
    label: "Total Clinic Locations"
    description: "Total number of physical optometry clinics across selected AEG Vision practice brands."
    sql: ${clinic_locations_count} ;;
  }

  measure: total_daily_chair_capacity {
    type: sum
    label: "Total Daily Chair Capacity"
    description: "Total daily eye exam slot capacity across selected practice brands."
    sql: ${daily_chair_capacity} ;;
  }
}
