FactoryBot.define do
  factory :product do
    name { 'Lorem Ipsum' }
    user { association(:user) }
    category { association(:category) }
    brand { association(:brand) }
    description { 'type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the re' }
    price { '10' }
    quantity { '20' }
    sku { '2FSS$4343' }
    status { 'draft' }

    # trait :category do
    #   association :category, factory: [:category]
    # end

    # trait :brand do
    #   association :brand, factory: [:brand]
    # end
  end
end
