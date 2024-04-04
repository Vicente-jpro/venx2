module CompanyConcerns 
    def register_date_company_used_the_app(company)
      expiration = PlanExpiration.new(Time.now)

      Plan.find_or_create_by!(
        sign_date: Time.now,
        expiration_date: expiration.get_date,
        company: company
      )
    end 

    def is_expired?(plan)
      date = PlanExpiration.new(Time.now)
      is_expired = date.is_expired?(plan.expiration_date)

      is_expired
    end
end
