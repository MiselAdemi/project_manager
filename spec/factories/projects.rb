FactoryGirl.define do
  factory :project do
    name { FFaker::HipsterIpsum.word }
    description { FFaker::HipsterIpsum.paragraph }
    user { User.first }

    trait :with_user do
      user { FactoryGirl.create(:user) }
    end
  end

  factory :invalid_project, class: Project do
    name { FFaker::HipsterIpsum.word }
    description nil
    user { User.first }
  end
end
