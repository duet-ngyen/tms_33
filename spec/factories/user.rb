FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password "abcd1234"

    factory :supervisor do
      role "supervisor"
    end
    factory :invalid_password_user do
      password ""
    end
    factory :invalid_email_user do
      email ""
    end
  end

end
