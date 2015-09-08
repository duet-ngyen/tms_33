FactoryGirl.define do
  factory :task do
    title {Faker::Name.title}
    description {Faker::Lorem.paragraph 5}
    factory :invalid_title_task do
      title ""
    end
    factory :invalid_description_task do
      description ""
    end
  end
end
