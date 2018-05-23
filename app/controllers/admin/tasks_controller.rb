class Admin::TasksController < ApplicationController
  layout 'admin'

  def index
    @tasks = Task.all
  end

  def new
  end

  def create
  end
end
