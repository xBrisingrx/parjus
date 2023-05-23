class TablesPoliticalPartiesController < ApplicationController
  before_action :set_tables_political_party, only: %i[ show edit update destroy ]

  # GET /tables_political_parties or /tables_political_parties.json
  def index
    @tables_political_parties = TablesPoliticalParty.all
  end

  # GET /tables_political_parties/1 or /tables_political_parties/1.json
  def show
  end

  # GET /tables_political_parties/new
  def new
    @tables_political_party = TablesPoliticalParty.new
  end

  # GET /tables_political_parties/1/edit
  def edit
  end

  # POST /tables_political_parties or /tables_political_parties.json
  def create
    @tables_political_party = TablesPoliticalParty.new(tables_political_party_params)

    respond_to do |format|
      if @tables_political_party.save
        format.html { redirect_to tables_political_party_url(@tables_political_party), notice: "Tables political party was successfully created." }
        format.json { render :show, status: :created, location: @tables_political_party }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tables_political_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tables_political_parties/1 or /tables_political_parties/1.json
  def update
    respond_to do |format|
      if @tables_political_party.update(tables_political_party_params)
        format.html { redirect_to tables_political_party_url(@tables_political_party), notice: "Tables political party was successfully updated." }
        format.json { render :show, status: :ok, location: @tables_political_party }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tables_political_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables_political_parties/1 or /tables_political_parties/1.json
  def destroy
    @tables_political_party.destroy

    respond_to do |format|
      format.html { redirect_to tables_political_parties_url, notice: "Tables political party was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tables_political_party
      @tables_political_party = TablesPoliticalParty.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tables_political_party_params
      params.require(:tables_political_party).permit(:table_id, :politic_party_id, :active)
    end
end
