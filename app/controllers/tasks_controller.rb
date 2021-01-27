class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.order(:id)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = current_user.find(params[:id])
  end

  def update
    task = current_user.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def create
    # NOTE: 関連を利用した記述
    @task = current_user.tasks.new(task_params)
    # @task = Task.new(task_params.merge(user_id: current_user.id))

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  private

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name, :description)
  end
end
