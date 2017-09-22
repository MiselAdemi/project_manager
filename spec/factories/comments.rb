FactoryGirl.define do
  factory :comment do
    body "MyText"

    trait :for_project do
      commentable_type "Project"
      commentable_id { FactoryGirl.create(:project).id }
    end
  end
end
