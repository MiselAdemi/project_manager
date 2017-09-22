FactoryGirl.define do
  factory :comment do
    body "MyText"

    trait :for_project do
      commentable_type "Project"
      commentable_id { FactoryGirl.create(:project).id }
    end

    trait :for_task do
      commentable_type "Task"
      commentable_id { FactoryGirl.create(:task).id }
    end
  end
end
