FactoryBot.define do
  factory :invoice_historic do
    cliente_name { "MyString" }
    total { "9.99" }
    sub_total { "9.99" }
    value_delivered_customer { "9.99" }
    customer_change { "9.99" }
    payment_method { "MyString" }
    profile { nil }
    cart_historic { nil }
  end
end
