FactoryBot.define do
  factory :item do
    name_item { "MyString" }
    manufacturing_date { "2024-01-29" }
    expiration_date { "2024-01-29" }
    quantity { 1 }
    price { "9.99" }
    tax { "9.99" }
    item_code { "MyString" }
    profite_value { "9.99" }
    supplier { nil }
    category { nil }
    profile { nil }
    sector { nil }
  end
end
