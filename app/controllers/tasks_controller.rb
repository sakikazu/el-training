class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, flash: { error: "タスクを作成しました。" }
    else
      flash[:error] = "作成に失敗しました。"
      render :new
    end
  end

  def edit

  end

  def update
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, flash: { error: "タスクを更新しました。" }
    else
      flash[:error] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, flash: { info: "タスクを削除しました。" }
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :priority, :expired_on, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
