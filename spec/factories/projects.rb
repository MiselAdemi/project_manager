FactoryGirl.define do
  factory :project do
    name { FFaker::HipsterIpsum.word }
    description { FFaker::HipsterIpsum.paragraph }
    user { User.first }
  end

  factory :invalid_project, class: Project do
    name { FFaker::HipsterIpsum.word }
    description nil
    user { User.first }
  end
end
