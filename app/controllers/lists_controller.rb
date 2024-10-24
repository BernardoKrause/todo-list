class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: %i[ show edit update destroy ]
  before_action :correct_user, only: [ :show, :edit, :update, :destroy ]

  # GET /lists or /lists.json
  def index
    @lists = current_user.lists
  end

  # GET /lists/1 or /lists/1.json
  def show
    @list = current_user.lists.find(params[:id])
    @tasks = @list.tasks.order(concluido: :asc, priority: :desc)
  end

  def correct_user
    @list = current_user.lists.find_by(id: params[:id])
    if @list.nil?
      flash[:alert] = "Você não tem permissão para acessar essa lista."
      redirect_to lists_path
    end
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists or /lists.json
  def create
    @list = current_user.lists.build(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to lists_path }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    @list = current_user.lists.find(params[:id])
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to lists_path }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list = current_user.lists.find(params[:id])
    @list.destroy!

    respond_to do |format|
      format.html { redirect_to lists_path, status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:title)
    end
end
