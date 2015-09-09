FactoryGirl.define do
  factory :course do

    title {Faker::Name.title}
    description {Faker::Lorem.paragraph 5}

    factory :valid_course do
      title {Faker::Name.title}
      description {Faker::Lorem.paragraph 5}
    end

    factory :invalid_title_too_short do
      title  {Faker::Name.title[0..1]}
    end

    factory :invalid_title_too_long do
      title  {Faker::Lorem.paragraph[0..50]}
    end

    factory :invalid_description_too_short do
      description {Faker::Name.title[0..1]}
    end
  end
end
