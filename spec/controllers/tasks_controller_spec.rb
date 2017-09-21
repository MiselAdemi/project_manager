require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before do
    user = FactoryGirl.create(:user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    before do
      @tasks = FactoryGirl.create_list(:task, 3, :with_same_project)
    end

    it "returns list of tasks" do
      get :index, params: { project_id: @tasks.first.project }
      expect(assigns(:tasks)).to eq(@tasks)
    end

    it "renders the #index view" do
      get :index, params: { project_id: @tasks.first.project }
      expect(response).to render_template(:index)
    end
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

  describe "PUT #update" do
    before :each do
      @task = FactoryGirl.create(:task)
    end

    context "valid attributes" do
      it "finds the requested @task" do
        put :update, params: { project_id: @task.project, id: @task, task: FactoryGirl.build(:task).attributes }
        expect(assigns(:task)).to eq(@task)
      end

      it "changes @projects's attributes" do
        put :update, params: { project_id: @task.project, id: @task, task: FactoryGirl.build(:task, name: "New name").attributes }
        @task.reload
        expect(@task.name).to eq("New name")
      end

      it "redirects to the updated project" do
        put :update, params: { project_id: @task.project, id: @task, task: FactoryGirl.build(:task).attributes }
        expect(response).to redirect_to([@task.project, @task])
      end
    end

    context "invalid attributes" do
      it "finds the requested @task" do
        put :update, params: { project_id: @task.project, id: @task, task: FactoryGirl.build(:task, :invalid_task).attributes }
        expect(assigns(:task)).to eq(@task)
      end

      it "does not change @task's attributes" do
        put :update, params: { project_id: @task.project, id: @task, task: FactoryGirl.build(:task, name: "New name", description: nil).attributes }
        @task.reload
        expect(@task.name).to_not eq("New name")
      end

      it "re-renders the edit method" do
        put :update, params: { project_id: @task.project, id: @task, task: FactoryGirl.build(:task, :invalid_task).attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @task = FactoryGirl.create(:task)
    end

    it "deletes the task" do
      expect{
        delete :destroy, params: { project_id: @task.project, id: @task }
      }.to change(Task, :count).by(-1)
    end

    it "redirects to tasks#index" do
      delete :destroy, params: { project_id: @task.project, id: @task }
      expect(response).to redirect_to(project_tasks_url(@task.project))
    end
  end
end
