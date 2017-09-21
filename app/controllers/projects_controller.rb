class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @projects = Project.all
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      respond_to @project
    else
      respond_to 'new'
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
