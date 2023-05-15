class DniTypesController < ApplicationController
  before_action :set_dni_type, only: %i[ show edit update destroy ]

  # GET /dni_types or /dni_types.json
  def index
    @dni_types = DniType.all
  end

  # GET /dni_types/1 or /dni_types/1.json
  def show
  end

  # GET /dni_types/new
  def new
    @dni_type = DniType.new
  end

  # GET /dni_types/1/edit
  def edit
  end

  # POST /dni_types or /dni_types.json
  def create
    @dni_type = DniType.new(dni_type_params)

    respond_to do |format|
      if @dni_type.save
        format.html { redirect_to dni_type_url(@dni_type), notice: "Dni type was successfully created." }
        format.json { render :show, status: :created, location: @dni_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dni_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dni_types/1 or /dni_types/1.json
  def update
    respond_to do |format|
      if @dni_type.update(dni_type_params)
        format.html { redirect_to dni_type_url(@dni_type), notice: "Dni type was successfully updated." }
        format.json { render :show, status: :ok, location: @dni_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dni_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dni_types/1 or /dni_types/1.json
  def destroy
    @dni_type.destroy

    respond_to do |format|
      format.html { redirect_to dni_types_url, notice: "Dni type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dni_type
      @dni_type = DniType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dni_type_params
      params.require(:dni_type).permit(:name, :description, :active)
    end
end
