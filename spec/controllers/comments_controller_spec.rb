require 'rails_helper'

RSpec.describe Projects::CommentsController, type: :controller do
  before do
    user = FactoryGirl.create(:user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST #create" do
    context "for project" do
      before do
        @comment_attr = FactoryGirl.build(:comment, :for_project).attributes
      end

      it "creates a new comment" do
        expect{
          post :create, params: { project_id: Project.first, comment: @comment_attr }
        }.to change(Comment, :count).by(1)
      end

      it "redirects back" do
        post :create, params: { project_id: Project.first, comment: @comment_attr }
        expect(response).to redirect_to(authenticated_root_path)
      end
    end

    context "for task" do
      before do
        @comment_attr = FactoryGirl.build(:comment, :for_task).attributes
      end

      it "creates a new comment" do
        expect{
          post :create, params: { project_id: Project.first, task_id: Task.first, comment: @comment_attr }
        }.to change(Comment, :count).by(1)
      end

      it "redirects back" do
        post :create, params: { project_id: Project.first, task_id: Task.first, comment: @comment_attr }
        expect(response).to redirect_to(authenticated_root_path)
      end
    end
  end
end
