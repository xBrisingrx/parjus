class HeadquartersController < ApplicationController
  before_action :authorize!
  before_action :set_headquarter, only: %i[ show edit update destroy ]

  # GET /headquarters or /headquarters.json
  def index
    @headquarters = Headquarter.all
  end

  # GET /headquarters/1 or /headquarters/1.json
  def show
  end

  # GET /headquarters/new
  def new
    @headquarter = Headquarter.new
    @neighborhoods = Neighborhood.actives
    @people = Person.actives.pluck(:id, :last_name,:name)
    @affiliated_rol = AffiliatedRol.actives.pluck(:id, :name)
  end

  # GET /headquarters/1/edit
  def edit
  end

  # POST /headquarters or /headquarters.json
  def create
    @headquarter = Headquarter.new(headquarter_params)
    respond_to do |format|
      if @headquarter.save
        format.json { render json: { status: 'success', msg: 'Sede registrada' }, status: :created }
        format.html { redirect_to headquarter_url(@headquarter), notice: "Headquarter was successfully created." }
      else
        format.json { render json: @headquarter.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /headquarters/1 or /headquarters/1.json
  def update
    respond_to do |format|
      if @headquarter.update(headquarter_params)
        format.html { redirect_to headquarter_url(@headquarter), notice: "Headquarter was successfully updated." }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @headquarter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /headquarters/1 or /headquarters/1.json
  def destroy
    @headquarter.destroy

    respond_to do |format|
      format.html { redirect_to headquarters_url, notice: "Headquarter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_headquarter
      @headquarter = Headquarter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def headquarter_params
      params.require(:headquarter)
        .permit(:name, :neighborhood_id, :person_id, :active,
          headquarter_affiliateds_attributes: [ :id, :person_id, :affiliated_rol_id ])
    end
end
