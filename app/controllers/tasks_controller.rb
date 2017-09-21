class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project
  before_action :find_task, :only => [ :show, :edit, :update, :destroy ]

  def index
    @tasks = @project.tasks
  end

  def show
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.build(task_params)

    if @task.save
      redirect_to project_task_path(@project, @task)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :done, :deadline, :priority)
  end

  def find_project
    @project = current_user.projects.find(params[:project_id])
  end

  def find_task
    @task = @project.tasks.find(params[:id])
  end
end
