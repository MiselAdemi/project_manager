class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_project, :only => [ :show, :edit, :update, :destroy ]

  def index
    @projects = current_user.projects
  end

  def show
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy

  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def find_project
    @project = current_user.projects.find(params[:id])
  end
end
