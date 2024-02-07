FactoryBot.define do
  factory :cart_temp do
    quantity { 1 }
    abandoned { false }
    item { nil }
    profile { nil }
  end
end
