class AffiliatedRolsController < ApplicationController
  before_action :set_affiliated_rol, only: %i[ show edit update destroy ]

  # GET /affiliated_rols or /affiliated_rols.json
  def index
    @affiliated_rols = AffiliatedRol.all
  end

  # GET /affiliated_rols/1 or /affiliated_rols/1.json
  def show
  end

  # GET /affiliated_rols/new
  def new
    @affiliated_rol = AffiliatedRol.new
  end

  # GET /affiliated_rols/1/edit
  def edit
  end

  # POST /affiliated_rols or /affiliated_rols.json
  def create
    @affiliated_rol = AffiliatedRol.new(affiliated_rol_params)

    respond_to do |format|
      if @affiliated_rol.save
        format.html { redirect_to affiliated_rol_url(@affiliated_rol), notice: "Affiliated rol was successfully created." }
        format.json { render :show, status: :created, location: @affiliated_rol }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @affiliated_rol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /affiliated_rols/1 or /affiliated_rols/1.json
  def update
    respond_to do |format|
      if @affiliated_rol.update(affiliated_rol_params)
        format.html { redirect_to affiliated_rol_url(@affiliated_rol), notice: "Affiliated rol was successfully updated." }
        format.json { render :show, status: :ok, location: @affiliated_rol }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @affiliated_rol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /affiliated_rols/1 or /affiliated_rols/1.json
  def destroy
    @affiliated_rol.destroy

    respond_to do |format|
      format.html { redirect_to affiliated_rols_url, notice: "Affiliated rol was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_affiliated_rol
      @affiliated_rol = AffiliatedRol.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def affiliated_rol_params
      params.require(:affiliated_rol).permit(:name, :active)
    end
end
