require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    user = FactoryGirl.create(:user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @project = FactoryGirl.create(:project)
        @comment_attr = FactoryGirl.build(:comment).attributes
      end

      it "creates a new comment" do
        expect{
          post :create, params: { project_id: @project, comment: @comment_attr }
        }.to change(Comment, :count).by(1)
      end

      it "redirects back" do
        post :create, params: { project_id: Project.first, task: @task_attr }
        expect(response).to redirect_to([Project.first, Task.last])
      end
    end
  end
end
