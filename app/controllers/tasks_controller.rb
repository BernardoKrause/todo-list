class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [ :edit, :update, :destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @list.tasks.new
  end

  # GET /tasks/1/edit
  def edit
    @task = @list.tasks.find(params[:id])
  end

  # POST /tasks or /tasks.json
  def create
    @task = @list.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to list_path(@list) }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to list_path(@list) }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # UPDATE STATUS
  def update_status
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])  # Encontra a tarefa pelo ID

    if @task.update(concluido: params[:task][:concluido])  # Atualiza apenas o campo concluido
      render json: { status: "success" }  # Retorna sucesso se a atualização for bem-sucedida
    else
      render json: { status: "error", message: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])

    @task.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = List.find(params[:list_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:description, :deadline, :concluido)
  end
end
