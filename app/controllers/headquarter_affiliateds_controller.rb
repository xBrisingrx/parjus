class HeadquarterAffiliatedsController < ApplicationController
  before_action :set_headquarter_affiliated, only: %i[ show edit update destroy ]

  # GET /headquarter_affiliateds or /headquarter_affiliateds.json
  def index
    @headquarter_affiliateds = HeadquarterAffiliated.all
  end

  # GET /headquarter_affiliateds/1 or /headquarter_affiliateds/1.json
  def show
  end

  # GET /headquarter_affiliateds/new
  def new
    @headquarter_affiliated = HeadquarterAffiliated.new
  end

  # GET /headquarter_affiliateds/1/edit
  def edit
  end

  # POST /headquarter_affiliateds or /headquarter_affiliateds.json
  def create
    @headquarter_affiliated = HeadquarterAffiliated.new(headquarter_affiliated_params)

    respond_to do |format|
      if @headquarter_affiliated.save
        format.html { redirect_to headquarter_affiliated_url(@headquarter_affiliated), notice: "Headquarter affiliated was successfully created." }
        format.json { render :show, status: :created, location: @headquarter_affiliated }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @headquarter_affiliated.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /headquarter_affiliateds/1 or /headquarter_affiliateds/1.json
  def update
    respond_to do |format|
      if @headquarter_affiliated.update(headquarter_affiliated_params)
        format.html { redirect_to headquarter_affiliated_url(@headquarter_affiliated), notice: "Headquarter affiliated was successfully updated." }
        format.json { render :show, status: :ok, location: @headquarter_affiliated }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @headquarter_affiliated.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /headquarter_affiliateds/1 or /headquarter_affiliateds/1.json
  def destroy
    @headquarter_affiliated.destroy

    respond_to do |format|
      format.html { redirect_to headquarter_affiliateds_url, notice: "Headquarter affiliated was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_headquarter_affiliated
      @headquarter_affiliated = HeadquarterAffiliated.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def headquarter_affiliated_params
      params.require(:headquarter_affiliated).permit(:headquarter_id, :person_id, :affiliated_rol, :active)
    end
end
