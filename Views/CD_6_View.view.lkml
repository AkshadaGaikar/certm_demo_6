view: cd_6_View {
  # # You can specify the table name if it's different from the view name:
  sql_table_name: `@{GCP_PROJECT}.@{REPORTING_DATASET}.DAILY_TRANSACTION_AGG` ;;

  # Define your dimensions and measures here, like this:
  # dimension: BOOKING_DATE1 {
  #   description: "Booking Date"
  #   type: date_time
  #   sql:  ${TABLE}.BOOKING_DATE ;;
  # }
  dimension_group: Booking {
    type: time
    timeframes: [date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BOOKING_DATE ;;
  }

  dimension: GDS_CODE {
    description: "GDS Code"
    type: string
    sql: ${TABLE}.GDS_CODE ;;
  }
  dimension:bookings{
    description: "Net Booking"
    hidden: yes
    type: number
    sql: ${TABLE}.BOOKINGS_PASSENGER_COUNT ;;
  }

  #------------------- Booking Date
  parameter: Booking_Date_Quarter_Year {
    type: unquoted
    group_label: "Multi Dimension_Filter"
    # label: "Duration Filter(Departure Date)"
    # view_label: "Daily Transaction"
    default_value: "Year_Quarter"
    allowed_value: {
      label: "Booking Date"
      value: "BOOKING_DATE"
    }
    allowed_value: {
      label: "Booking Year Month"
      value: "Year_Month"
    }
    allowed_value: {
      label: "Booking Month"
      value: "Month"
    }
    allowed_value: {
      label: "Booking Year Quarter"
      value: "Year_Quarter"
    }
    allowed_value: {
      label: "Booking Year"
      value: "Year"
    }
  }
  dimension: Booking_Duration {
    type: string
    group_label: "Multi Dimension"
    #view_label: "Daily Transaction"
    label_from_parameter:Booking_Date_Quarter_Year
    sql:
      {%if Booking_Date_Quarter_Year._parameter_value=="BOOKING_DATE"%}
      Cast(${TABLE}.BOOKING_DATE as date)

      {% elsif Booking_Date_Quarter_Year._parameter_value=="Year_Month"%}
      concat(extract(year from ${TABLE}.BOOKING_DATE),concat('-',case when length(cast(extract(month from ${TABLE}.BOOKING_DATE) as string))=1 then concat('0',cast(extract(month from ${TABLE}.BOOKING_DATE) as string)) else cast(extract(month from ${TABLE}.BOOKING_DATE) as string) end))

      {% elsif Booking_Date_Quarter_Year._parameter_value=="Month"%}
      case when length(cast(extract(month from BOOKING_DATE) as string))=1 then concat('0',cast(extract(month from BOOKING_DATE) as string)) else cast(extract(month from BOOKING_DATE) as string) end

      {% elsif Booking_Date_Quarter_Year._parameter_value=="Year_Quarter"%}
      concat(extract(Year from BOOKING_DATE), concat('-Q', cast(format_date('%Q',BOOKING_DATE) as string)))

      {% elsif Booking_Date_Quarter_Year._parameter_value=="Year"%}
      extract(year from BOOKING_DATE)
      {% else %}
      NULL
      {% endif %}
      ;;
  }
  #-------------------



  # dimension: Predictive_Analysis_1_Link {
  #   type: string
  #   #description: "This link will take you to Predictive analysis 1 Dashboard"
  #   group_label: "Menu Link"
  #   sql: 1 ;;
  #   html:  <div>
  #       <nav style='font-size: 18px; padding: 5px 10px 0 10px; height: 60px'>
  #       <a style='color: #27a9e1; padding: 5px 15px; border-bottom: solid 1px #27a9e1; float:left; line-height=40px' href='/dashboards/126?Booking Date={{_filters['Vertext_AI_MIDT.Booking_date']}}&GDS CODE={{_filters['Vertext_AI_MIDT.GDS_CODE']}}' >Predictive Analysis 1</a>
  #   <a style='color: #ffffff; padding: 5px 15px; border-top:solid 1px #27a9e1; border-left: solid 1px #27a9e1;border-right: solid 1px #27a9e1; border-radius: 5px 5px 0 0;float: left; line-height: 40px; font-weight:bold; background-color: #27a9e1' href='#Home'>Predictive Analysis 2</a>

  #       </div>;;
  # }

  # dimension: Predictive_Analysis_2_Link {
  #   #description: "This link will take you to Predictive analysis 2 Dashboard"
  #   type: string

  #   # group_label: "Menu Link"
  #   sql: 1 ;;
  #   html:  <div>
  #       <nav style='font-size: 18px; padding: 5px 10px 0 10px; height: 60px'>
  #       <a style='color: #ffffff; padding: 5px 15px; border-top:solid 1px #27a9e1; border-left: solid 1px #27a9e1;border-right: solid 1px #27a9e1; border-radius: 5px 5px 0 0;float: left; line-height: 40px; font-weight:bold; background-color: #27a9e1' href='#Home' >Predictive Analysis 1</a>
  #   <a style='color: #27a9e1; padding: 5px 15px; border-bottom: solid 1px #27a9e1; float:left; line-height=40px' href='/dashboards/125?Booking Date={{_filters['Vertext_AI_MIDT.Booking_date']}}&GDS CODE={{_filters['Vertext_AI_MIDT.GDS_CODE']}}'>Predictive Analysis 2</a>

  #       </div>;;
  # }



  # dimension: Predictive_Analysis_reg {
  #   #description: "This link will take you to Predictive analysis 2 Dashboard"
  #   type: string

  #   # group_label: "Menu Link"
  #   sql: 1 ;;
  #   html:  <div>
  #         <nav style='font-size: 18px; padding: 5px 10px 0 10px; height: 60px'>
  #         <a style='color: #ffffff; padding: 5px 15px; border-top:solid 1px #27a9e1; border-left: solid 1px #27a9e1;border-right: solid 1px #27a9e1; border-radius: 5px 5px 0 0;float: left; line-height: 40px; font-weight:bold; background-color: #27a9e1' href='#Home' >Predictive Analysis (Time Series)</a>
  #     <a style='color: #27a9e1; padding: 5px 15px; border-bottom: solid 1px #27a9e1; float:left; line-height=40px' href='/dashboards/Predictive_Analysis::regression?Duration Type={{_filters['CD_View.Booking_Duration']}}&Booking Date={{_filters['CD_View.Booking_date']}}&GDS CODE={{_filters['CD_View.GDS_CODE']}}'>Predictive Analysis (Regression)</a>

  #     </div>;;
  # }





  #-------------------
  measure: Actual_Booking {
    description: "Actual booking"
    type: sum
    sql: ${bookings};;
  }

}
