require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before do
    user = FactoryGirl.create(:user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #show" do
    before do
      @task = FactoryGirl.create(:task)
    end

    it "assigns the requested task to @task" do
      get :show, params: { id: @task, project_id: @task.project}
      expect(assigns(:task)).to eq(@task)
    end

    it "renders the #show view" do
      get :show, params: { id: @task, project_id: @task.project }
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @task_attr = FactoryGirl.build(:task).attributes
      end

      it "creates a new task" do
        expect{
          post :create, params: { project_id: Project.first, task: @task_attr }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the new task" do
        post :create, params: { project_id: Project.first, task: @task_attr }
        expect(response).to redirect_to([Project.first, Task.last])
      end
    end

    context "with invalid attributes" do
      before do
        @task_attr = FactoryGirl.build(:task, :invalid_task).attributes
      end

      it "does not save the new task" do
        expect{
          post :create, params: { project_id: Project.first, task: @task_attr }
        }.to_not change(Task, :count)
      end

      it "re-renders the new method" do
        post :create, params: { project_id: Project.first, task: @task_attr }
        expect(response).to render_template(:new)
      end
    end
  end
end
