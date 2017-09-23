require 'rails_helper'

RSpec.describe Tasks::CommentsController, type: :controller do
  before do
    user = FactoryGirl.create(:user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST #create" do
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

  describe "DELETE #destroy" do
    before do
      @comment = FactoryGirl.create(:comment, :for_task)
    end

    it "deletes the comment" do
      expect{
        delete :destroy, params: { project_id: Project.first, task_id: Task.first, id: @comment }
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to root" do
      delete :destroy, params: { project_id: Project.first, task_id: Task.first, id: @comment }
      expect(response).to redirect_to(authenticated_root_path)
    end
  end
end
