FactoryBot.define do
  factory :invoice_temp do
    cliente_name { "MyString" }
    total { "9.99" }
    value_delivered_customer { "MyString" }
    customer_change { "9.99" }
    payment_method { "MyString" }
    code_cart { "MyString" }
    profile { nil }
  end
end
