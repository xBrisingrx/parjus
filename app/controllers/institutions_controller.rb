class InstitutionsController < ApplicationController
  before_action :set_institution, only: %i[ show edit update destroy ]
  before_action :set_variables, only: %i[ new edit ]

  def index
    @institutions = Institution.all
  end

  def show
  end

  def new
    @institution = Institution.new
  end

  def edit
  end

  def create
    @institution = Institution.new(institution_params)

    respond_to do |format|
      if @institution.save
        format.json { render json: { status: 'success', msg: 'Institución creada' }, status: :created}
        format.html { redirect_to institution_url(@institution), notice: "Institution was successfully created." }
      else
        format.json { render json: { status: 'error', msg: @institution.errors }, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @institution.update(institution_params)
        format.json { render json: { status: 'success', msg: 'Datos actualizados' }, status: :ok}
        format.html { redirect_to institution_url(@institution), notice: "Institution was successfully updated." }
      else
        format.json { render json: @institution.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @institution.destroy

    respond_to do |format|
      format.html { redirect_to institutions_url, notice: "Institution was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_institution
      @institution = Institution.find(params[:id])
    end

    def set_variables
      @institution_types = InstitutionType.actives
      @neighborhoods = Neighborhood.actives
    end

    def institution_params
      params.require(:institution).permit(:name, :description, :d_type, :active, 
        :direction, :institution_type_id, :neighborhood_id)
    end
end
