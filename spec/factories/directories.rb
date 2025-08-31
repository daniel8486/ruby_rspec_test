FactoryBot.define do
  factory :directory do
    sequence(:name) { |n| "directory_#{n}" }
    parent { nil }

    trait :with_parent do
      association :parent, factory: :directory
    end

    trait :root do
     parent { nil }
     to_create { |instance| instance.save! }
    end

    trait :with_children do
      transient do
        children_count { 3 }
      end

      after(:create) do |directory, evaluator|
        create_list(:directory, evaluator.children_count, parent: directory)
      end
    end
  end
end
