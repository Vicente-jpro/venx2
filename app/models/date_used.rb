class DateUsed < ApplicationRecord
  belongs_to :company
  validates :company, uniqueness: true
  
  scope :find_company, ->(company) { find_by(company_id: company.id)}
end
