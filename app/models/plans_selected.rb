class PlansSelected < ApplicationRecord
  belongs_to :plan
  belongs_to :company

  enum duration: { monthly: 30, quarterly: 90, semiannual: 180,  annual: 360 }

  scope :find_by_company, ->(company) { where(company_id: company.id).take }

  def self.find_plan_selected_by_company(company) 
    PlansSelected.joins(:plan)
                 .joins(:company)
                 .where("plans_selecteds.day_used < plans_selecteds.duration and plans_selecteds.company_id = #{company.id}")
                 .take
  end

  
  #SELECT * FROM plans_selecteds
	#JOIN companies
   #	ON companies.id = plans_selecteds.company_id
   #JOIN profiles
   # ON profiles.user_id = 2;

       
end
