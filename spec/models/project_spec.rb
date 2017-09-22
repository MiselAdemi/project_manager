require 'rails_helper'

RSpec.describe Project, type: :model do
  subject {
    described_class.new(name: "Anything", description: "Lorem ipsum", user: FactoryGirl.create(:user))
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

  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
    it { should have_many(:comments) }
  end
end
