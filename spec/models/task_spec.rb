require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:project) { FactoryGirl.create(:project, :with_user) }
  subject {
    described_class.new(name: "Anything", description: "Lorem ipsum", deadline: DateTime.now, priority: 0, project_id: project.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a deadline" do
    subject.deadline = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a priority" do
    subject.priority = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a project" do
    subject.project_id = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:project) }
    it { should have_many(:comments) }
  end
end
