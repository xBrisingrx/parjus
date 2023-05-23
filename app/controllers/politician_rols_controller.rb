class PoliticianRolsController < ApplicationController
  before_action :set_politician_rol, only: %i[ show edit update destroy ]

  # GET /politician_rols or /politician_rols.json
  def index
    @politician_rols = PoliticianRol.all
    @title_modal = 'Cargos registrados'
  end

  # GET /politician_rols/1 or /politician_rols/1.json
  def show
  end

  # GET /politician_rols/new
  def new
    @title_modal = 'Registrar cargo'
    @politician_rol = PoliticianRol.new
  end

  # GET /politician_rols/1/edit
  def edit
  end

  # POST /politician_rols or /politician_rols.json
  def create
    @politician_rol = PoliticianRol.new(politician_rol_params)

    respond_to do |format|
      if @politician_rol.save
        format.json { render json: { status: 'success', msg: 'Cargo registrado'}, status: :created }
        format.html { redirect_to politician_rol_url(@politician_rol), notice: "Politician rol was successfully created." }
      else
        format.json { render json: @politician_rol.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /politician_rols/1 or /politician_rols/1.json
  def update
    respond_to do |format|
      if @politician_rol.update(politician_rol_params)
        format.json { render json: { status: 'success', msg: 'Cargo actualizado'}, status: :ok }
        format.html { redirect_to politician_rol_url(@politician_rol), notice: "Politician rol was successfully updated." }
      else
        format.json { render json: @politician_rol.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /politician_rols/1 or /politician_rols/1.json
  def destroy
    @politician_rol.destroy

    respond_to do |format|
      format.html { redirect_to politician_rols_url, notice: "Politician rol was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_politician_rol
      @politician_rol = PoliticianRol.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def politician_rol_params
      params.require(:politician_rol).permit(:name, :active)
    end
end
