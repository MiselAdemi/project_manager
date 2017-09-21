require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  before do
    user = FactoryGirl.create(:user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    before do
      @projects = FactoryGirl.create_list(:project, 3)
    end

    it "returns list of user projects" do
      get :index
      expect(assigns(:projects)).to eq(@projects)
    end

    it "renders the #index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    before do
      @project = FactoryGirl.create_list(:project, 3)
    end

    it "assigns the requested project to @project" do
      get :show, params: { id: @project }
      expect(assigns(:project)).to eq(@project)
    end

    it "renders the #show view" do
      get :show, params: { id: @project }
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @project_attr = FactoryGirl.attributes_for(:project)
      end

      it "creates a new project" do
        expect{
          post :create, params: { project: @project_attr }
        }.to change(Project, :count).by(1)
      end

      it "redirects to the new contact" do
        post :create, params: { project: @project_attr }
        expect(response).to redirect_to(Project.last)
      end
    end

    context "with invalid attributes" do
      before do
        @project = FactoryGirl.attributes_for(:invalid_project)
      end

      it "does not save the new project" do
        expect{
          post :create, params: { project: @project }
        }.to_not change(Project, :count)
      end

      it "re-renders the new method" do
        post :create, params: { project: @project }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @project = FactoryGirl.create(:project)
    end

    context "valid attributes" do
      it "finds the requested @project" do
        put :update, params: { id: @project, project: FactoryGirl.attributes_for(:project) }
        expect(assigns(:project)).to eq(@project)
      end

      it "changes @projects's attributes" do
        put :update, params: { id: @project, project: FactoryGirl.attributes_for(:project, name: "Project name updated") }
        @project.reload
        expect(@project.name).to eq("Project name updated")
      end

      it "redirects to the updated project" do
        put :update, params: { id: @project, project: FactoryGirl.attributes_for(:project) }
        expect(response).to redirect_to(@project)
      end
    end

    context "invalid attributes" do
      it "finds the requested @project" do
        put :update, params: { id: @project, project: FactoryGirl.attributes_for(:invalid_project) }
        expect(assigns(:project)).to eq(@project)
      end

      it "does not change @projects's attributes" do
        put :update, params: { id: @project, project: FactoryGirl.attributes_for(:project, name: "Project 1", description: nil) }
        @project.reload
        expect(@project.name).to_not eq("Project 1")
      end

      it "re-renders the edit method" do
        put :update, params: { id: @project, project: FactoryGirl.attributes_for(:invalid_project) }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @project = FactoryGirl.create(:project)
    end

    it "deletes the project" do
      expect{
        delete :destroy, params: { id: @project }
      }.to change(Project, :count).by(-1)
    end

    it "redirects to projects#index" do
      delete :destroy, params: { id: @project }
      expect(response).to redirect_to(projects_url)
    end
  end
end
