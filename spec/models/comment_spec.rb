require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject {
    described_class.new(body: "Anything", commentable: FactoryGirl.create(:project, :with_user))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a body" do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:commentable) }
  end
end
