class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.search(params[:task]).page(params[:page]).per(30)
    @q = params[:task].present? ? Task.new(task_params) : Task.new

    if params[:sort].present?
      if params[:sort][:created_at].present?
        sort = sort_str(params[:sort][:created_at])
        @tasks = @tasks.order("created_at #{sort}")
        @sort_by_created_at = sort_str(sort, toggle: true)
      elsif params[:sort][:expired_on].present?
        sort = sort_str(params[:sort][:expired_on])
        @tasks = @tasks.order("expired_on #{sort}")
        @sort_by_expired_on = sort_str(sort, toggle: true)
      elsif params[:sort][:priority].present?
        sort = sort_str(params[:sort][:priority])
        @tasks = @tasks.order("priority #{sort}")
        @sort_by_priority = sort_str(sort, toggle: true)
      end
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, flash: { info: "タスクを作成しました。" }
    else
      flash[:error] = "作成に失敗しました。"
      render :new
    end
  end

  def edit
    @task.labels_text = @task.labels.pluck(:name).uniq.join(", ")
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, flash: { info: "タスクを更新しました。" }
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
    params.require(:task).permit(:name, :description, :priority, :expired_on, :status, :status_for_search, :labels_text).tap do |prm|
      prm[:status] = prm[:status].to_i if prm[:status].present?
      prm[:priority] = prm[:priority].to_i if prm[:priority].present?
    end
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def sort_str(order, toggle: false)
    if toggle
      order == "asc" ? "desc" : "asc"
    else
      order == "asc" ? "asc" : "desc"
    end
  end
end
