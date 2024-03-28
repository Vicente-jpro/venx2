module CompanyConcerns 
  extend ActiveSupport::Concern
  
  # Used when company is created for the first time
  def register_date_company_used_the_app(company)
    DateUsed.find_or_create_by!(
      present_day: Time.now,
      last_day: Time.now,
      company: company
    )
  end

  # Used when the company is using the app
  def update_date_company_used_the_app(company, plans_selected)
    day_now ||= Time.now.day
    day_used ||= DateUsed.find_company(company).take
                          
    day_of_yesterday = day_used.last_day
                        .day 
    
    if day_now != day_of_yesterday
      plans_selected.increment!(:day_used)
      debugger
      day_used.present_day = Time.now
      day_used.last_day = Time.now
      DateUsed.update(day_used.as_json)
      
    end
    debugger
  end


end