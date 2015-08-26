FactoryGirl.define do
  factory :course do
    title {Faker::Name.title}
    description {Faker::Lorem.paragraph 5}
    factory :invalid_title_course do
      title ""
    end
    factory :invalid_description_course do
      description ""
    end
  end
end
