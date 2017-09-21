FactoryGirl.define do
  factory :task do
    name "MyString"
    description "MyText"
    done 1
    deadline "2017-09-21"
    priority 1
    project { FactoryGirl.create(:project) }

    trait :invalid_task do
      name nil
    end

    trait :with_same_project do
      project { Project.first.present? ? Project.first : FactoryGirl.create(:project) }
    end
  end
end
