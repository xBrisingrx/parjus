class PoliticiansPartiesController < ApplicationController
  before_action :set_politicians_party, only: %i[ show edit update destroy ]

  #politicos que estan en los partidos

  # GET /politicians_parties or /politicians_parties.json
  def index
    @politicians_parties = PoliticiansParty.all
  end

  # GET /politicians_parties/1 or /politicians_parties/1.json
  def show
  end

  # GET /politicians_parties/new
  def new
    @politicians_party = PoliticiansParty.new
  end

  # GET /politicians_parties/1/edit
  def edit
  end

  # POST /politicians_parties or /politicians_parties.json
  def create
    @politicians_party = PoliticiansParty.new(politicians_party_params)

    respond_to do |format|
      if @politicians_party.save
        format.html { redirect_to politicians_party_url(@politicians_party), notice: "Politicians party was successfully created." }
        format.json { render :show, status: :created, location: @politicians_party }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @politicians_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /politicians_parties/1 or /politicians_parties/1.json
  def update
    respond_to do |format|
      if @politicians_party.update(politicians_party_params)
        format.html { redirect_to politicians_party_url(@politicians_party), notice: "Politicians party was successfully updated." }
        format.json { render :show, status: :ok, location: @politicians_party }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @politicians_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /politicians_parties/1 or /politicians_parties/1.json
  def destroy
    @politicians_party.destroy

    respond_to do |format|
      format.html { redirect_to politicians_parties_url, notice: "Politicians party was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_politicians_party
      @politicians_party = PoliticiansParty.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def politicians_party_params
      params.require(:politicians_party).permit(:political_party_id, :politician_rol_id, :active)
    end
end
