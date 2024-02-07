FactoryBot.define do
  factory :cart_historic do
    item { nil }
    quantitiy { 1 }
    abandoned { false }
    code_cart { "MyString" }
  end
end
