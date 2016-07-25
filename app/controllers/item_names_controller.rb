class ItemNamesController < ApplicationController
  before_action :set_item_name, only: [:show, :edit, :update, :destroy]

  # GET /item_names
  # GET /item_names.json
  def index
    @item_names = ItemName.all
  end

  def personal_index
    @item_names = ItemName.where(user: current_user)
  end

  # GET /item_names/1
  # GET /item_names/1.json
  def show
  end

  # GET /item_names/new
  def new
    @item_name = ItemName.new
  end

  # GET /item_names/1/edit
  def edit
  end

  # POST /item_names
  # POST /item_names.json
  def create
    @item_name = ItemName.new(item_name_params)

    respond_to do |format|
      if @item_name.save
        format.html { redirect_to @item_name, notice: 'Item name was successfully created.' }
        format.json { render :show, status: :created, location: @item_name }
      else
        format.html { render :new }
        format.json { render json: @item_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_names/1
  # PATCH/PUT /item_names/1.json
  def update
    respond_to do |format|
      if @item_name.update(item_name_params)
        format.html { redirect_to @item_name, notice: 'Item name was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_name }
      else
        format.html { render :edit }
        format.json { render json: @item_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_names/1
  # DELETE /item_names/1.json
  def destroy
    @item_name.destroy
    respond_to do |format|
      format.html { redirect_to item_names_url, notice: 'Item name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_name
      @item_name = ItemName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_name_params
      params.require(:item_name).permit(:name, :user_id)
    end
end
