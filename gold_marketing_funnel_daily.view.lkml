view: gold_marketing_funnel_daily {
  sql_table_name: `analytics-386417.aeg_vision_marketing.gold_marketing_funnel_daily` ;;
  label: "Gold Full-Funnel Marketing & Revenue"

  dimension: funnel_row_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.funnel_row_id ;;
  }

  dimension_group: report {
    type: time
    label: "Report"
    description: "Date of the ad spend, GA4 web session activity, and attributed patient bookings."
    timeframes: [raw, date, week, month, quarter, year, day_of_week]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.report_date ;;
  }

  dimension: practice_id {
    type: string
    label: "Practice ID"
    description: "Foreign key to dim_aeg_practices."
    sql: ${TABLE}.practice_id ;;
  }

  dimension: practice_brand {
    type: string
    label: "Regional Practice Brand"
    description: "Local AEG Vision practice brand name."
    sql: ${TABLE}.practice_brand ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    label: "State"
    description: "US State code of the practice brand."
    sql: ${TABLE}.state ;;
  }

  dimension: dma_market {
    type: string
    label: "DMA Market"
    description: "Designated Market Area (DMA) metro region."
    sql: ${TABLE}.dma_market ;;
  }

  dimension: campaign_id {
    type: string
    label: "Campaign ID"
    description: "Unique paid media campaign identifier."
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    description: "Specific paid media campaign name (e.g., FSA_HSA_YearEnd_Urgency, Designer_Frames_Virtual_TryOn, TikTok_Viral_Frame_Style_2026, Eye_Exam_Near_Me_HighIntent)."
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_theme {
    type: string
    label: "Campaign Theme"
    description: "Strategic marketing theme (FSA/HSA Benefits Urgency, Designer Optical Promo, GenZ Digital Eye Strain, Local High-Intent Search, Pediatric Eye Care, Dry Eye & Medical)."
    sql: ${TABLE}.campaign_theme ;;
  }

  dimension: ad_platform {
    type: string
    label: "Ad Platform"
    description: "Advertising platform: Meta (Instagram/Facebook), TikTok Ads, Google Search & Local PMax, or YouTube CTV & Shorts."
    sql: ${TABLE}.ad_platform ;;
  }

  dimension: channel_group {
    type: string
    label: "Marketing Channel Group"
    description: "Normalized channel group (Paid Social - Meta, Paid Social - TikTok, Paid Search - Google, Paid Video - YouTube)."
    sql: ${TABLE}.channel_group ;;
  }

  dimension: creative_format {
    type: string
    label: "Ad Creative Format"
    description: "Format of the social/search ad creative (Carousel_Designer_Frames, Reels_AR_TryOn_Video, Creator_POV_ShortVideo, Responsive_Search_Local_Pin)."
    sql: ${TABLE}.creative_format ;;
  }

  # --- Measures: Paid Media & Social Engagement ---
  measure: total_ad_spend {
    type: sum
    label: "Total Ad Spend ($)"
    description: "Total paid advertising spend in USD across Meta, TikTok, Google Search/PMax, and YouTube."
    sql: ${TABLE}.spend_usd ;;
    value_format_name: usd
  }

  measure: total_impressions {
    type: sum
    label: "Total Impressions"
    description: "Total ad impressions served."
    sql: ${TABLE}.impressions ;;
    value_format_name: decimal_0
  }

  measure: total_reach {
    type: sum
    label: "Total Reach"
    description: "Total unique users reached by paid social and video campaigns."
    sql: ${TABLE}.reach ;;
    value_format_name: decimal_0
  }

  measure: total_clicks {
    type: sum
    label: "Total Ad Clicks"
    description: "Total clicks from paid media ads to AEG Vision practice websites."
    sql: ${TABLE}.clicks ;;
    value_format_name: decimal_0
  }

  measure: total_video_views_75pct {
    type: sum
    label: "Video Views (75%+ Completion)"
    description: "Number of social/video views reaching at least 75% completion on TikTok, Reels, and YouTube."
    sql: ${TABLE}.video_views_75pct ;;
    value_format_name: decimal_0
  }

  measure: ctr {
    type: number
    label: "Click-Through Rate (CTR %)"
    description: "Ad clicks divided by ad impressions."
    sql: SAFE_DIVIDE(${total_clicks}, NULLIF(${total_impressions}, 0)) ;;
    value_format_name: percent_2
  }

  measure: cpc {
    type: number
    label: "Cost Per Click (CPC $)"
    description: "Average cost per ad click in USD."
    sql: SAFE_DIVIDE(${total_ad_spend}, NULLIF(${total_clicks}, 0)) ;;
    value_format_name: usd
  }

  # --- Measures: GA4 Web Funnel & Clinic Outcomes ---
  measure: total_ga4_sessions {
    type: sum
    label: "GA4 Website Sessions"
    description: "Total GA4 sessions landing on AEG Vision practice pages from paid campaigns."
    sql: ${TABLE}.ga4_website_sessions ;;
    value_format_name: decimal_0
  }

  measure: total_ga4_location_views {
    type: sum
    label: "GA4 Clinic Finder Views"
    description: "GA4 sessions where the prospective patient viewed a local practice location page."
    sql: ${TABLE}.ga4_location_finder_views ;;
    value_format_name: decimal_0
  }

  measure: total_ga4_booking_starts {
    type: sum
    label: "GA4 Exam Booking Starts"
    description: "GA4 sessions where the user initiated the online eye exam scheduler (begin_exam_booking)."
    sql: ${TABLE}.ga4_booking_flow_starts ;;
    value_format_name: decimal_0
  }

  measure: total_ga4_online_bookings {
    type: sum
    label: "GA4 Online Booked Exams"
    description: "Total online eye exam appointments booked on the website (book_eye_exam GA4 conversion event)."
    sql: ${TABLE}.ga4_online_bookings ;;
    value_format_name: decimal_0
  }

  measure: total_completed_inchair_exams {
    type: sum
    label: "Completed In-Chair Eye Exams"
    description: "Total booked eye exams where the patient actually showed up in the clinic and completed their exam."
    sql: ${TABLE}.completed_inchair_exams ;;
    value_format_name: decimal_0
  }

  measure: total_noshow_appointments {
    type: sum
    label: "No-Show Appointments"
    description: "Total booked appointments where the patient failed to show up at the clinic (No-Show)."
    sql: ${TABLE}.noshow_appointments ;;
    value_format_name: decimal_0
  }

  measure: total_new_patients_completed {
    type: sum
    label: "New Patients Acquired (Completed)"
    description: "Total first-time patients who completed an in-chair eye exam."
    sql: ${TABLE}.new_patients_completed ;;
    value_format_name: decimal_0
  }

  measure: total_optical_dispensary_orders {
    type: sum
    label: "Optical Dispensary Eyewear Orders"
    description: "Completed exams that resulted in a retail optical purchase (frames, progressive/anti-reflective lenses, or annual contact lens supply)."
    sql: ${TABLE}.optical_dispensary_orders ;;
    value_format_name: decimal_0
  }

  # --- Measures: Efficiency, Show Rate, Optical Attach & True ROAS ---
  measure: cost_per_booked_exam {
    type: number
    label: "Cost Per Booked Exam ($)"
    description: "Ad spend divided by GA4 online booked eye exams."
    sql: SAFE_DIVIDE(${total_ad_spend}, NULLIF(${total_ga4_online_bookings}, 0)) ;;
    value_format_name: usd
  }

  measure: cost_per_completed_inchair_exam {
    type: number
    label: "True Cost Per Completed In-Chair Exam ($)"
    description: "Ad spend divided by actual completed in-chair exams (accounts for appointment No-Shows)."
    sql: SAFE_DIVIDE(${total_ad_spend}, NULLIF(${total_completed_inchair_exams}, 0)) ;;
    value_format_name: usd
  }

  measure: patient_acquisition_cost_new {
    type: number
    label: "New Patient Acquisition Cost (PAC $)"
    description: "Total ad spend divided by completed new-patient exams."
    sql: SAFE_DIVIDE(${total_ad_spend}, NULLIF(${total_new_patients_completed}, 0)) ;;
    value_format_name: usd
  }

  measure: appointment_noshow_rate {
    type: number
    label: "Appointment No-Show Rate (%)"
    description: "Percentage of online booked appointments that resulted in a clinic No-Show."
    sql: SAFE_DIVIDE(${total_noshow_appointments}, NULLIF(${total_ga4_online_bookings}, 0)) ;;
    value_format_name: percent_1
  }

  measure: inchair_show_rate {
    type: number
    label: "Clinic In-Chair Show Rate (%)"
    description: "Percentage of online booked appointments that successfully converted into a completed in-chair exam."
    sql: SAFE_DIVIDE(${total_completed_inchair_exams}, NULLIF(${total_ga4_online_bookings}, 0)) ;;
    value_format_name: percent_1
  }

  measure: optical_capture_rate {
    type: number
    label: "Optical Dispensary Capture Rate (%)"
    description: "Percentage of completed eye exams where the patient also purchased frames, lenses, or contacts at the AEG optical dispensary."
    sql: SAFE_DIVIDE(${total_optical_dispensary_orders}, NULLIF(${total_completed_inchair_exams}, 0)) ;;
    value_format_name: percent_1
  }

  # --- Measures: Revenue & ROAS ---
  measure: total_realized_exam_revenue {
    type: sum
    label: "Realized Clinical Exam Revenue ($)"
    description: "Clinical fee revenue from completed eye exams, contact lens fittings, and dry-eye evaluations."
    sql: ${TABLE}.realized_exam_revenue_usd ;;
    value_format_name: usd
  }

  measure: total_realized_optical_revenue {
    type: sum
    label: "Realized Optical Dispensary Revenue ($)"
    description: "Retail optical revenue from designer frames, progressive/specialty lenses, and contact lenses."
    sql: ${TABLE}.realized_optical_revenue_usd ;;
    value_format_name: usd
  }

  measure: total_realized_revenue {
    type: sum
    label: "Total Realized Clinic + Optical Revenue ($)"
    description: "Combined realized revenue from clinical eye exams plus optical dispensary eyewear purchases."
    sql: ${TABLE}.total_realized_revenue_usd ;;
    value_format_name: usd
  }

  measure: total_lost_noshow_revenue {
    type: sum
    label: "Lost Revenue from No-Shows ($)"
    description: "Estimated clinical + optical revenue lost due to patients who booked online but did not show up for their appointment."
    sql: ${TABLE}.lost_noshow_revenue_usd ;;
    value_format_name: usd
  }

  measure: true_full_funnel_roas {
    type: number
    label: "True Full-Funnel ROAS (x)"
    description: "Total realized clinical + optical dispensary revenue divided by total paid ad spend."
    sql: SAFE_DIVIDE(${total_realized_revenue}, NULLIF(${total_ad_spend}, 0)) ;;
    value_format_name: decimal_2
  }
}
