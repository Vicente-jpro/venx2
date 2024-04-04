class Plan < ApplicationRecord
  belongs_to :company

  scope :find_by_company, ->(company) { find_by(company_id: company.id)}
end
