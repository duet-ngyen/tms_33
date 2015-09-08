FactoryGirl.define do
  factory :subject do
    title {Faker::Name.title}
    description {Faker::Lorem.paragraph 5}
    factory :invalid_title_subject do
      title ""
    end
    factory :invalid_description_subject do
      description ""
    end
  end
end
