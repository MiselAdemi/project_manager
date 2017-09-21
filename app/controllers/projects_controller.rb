class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @projects = Project.all
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
