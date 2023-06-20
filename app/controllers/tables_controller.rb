class TablesController < ApplicationController
  before_action :set_table, only: %i[ show edit update destroy ]

  # GET /tables or /tables.json
  def index
    if params[:institution_id]
      @tables = Table.where(institution_id: params[:institution_id])
      @institution = Institution.find(params[:institution_id])
      @title_modal = "Mesas de la institution #{@institution.name}"
    else
      @tables = Table.all
    end
  end

  # GET /tables/1 or /tables/1.json
  def show
  end

  # GET /tables/new
  def new
    @table = Table.new
    @title_modal = 'Registrar mesa'
    @institution_id = params[:institution_id]
    @political_parties = PoliticalParty.all
    @fiscals = User.where(rol: :fiscal).or( User.where(rol: :fiscal_gral)).actives
  end

  # GET /tables/1/edit
  def edit
  end

  # POST /tables or /tables.json
  def create
    @table = Table.new(table_params)
    @table.number = 0
    respond_to do |format|
      if @table.save
        format.json { render json: { status: 'success', msg: 'Mesa registrada' }, status: :created }
        format.html { redirect_to table_url(@table), notice: "Table was successfully created." }
      else
        format.json { render json: @table.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tables/1 or /tables/1.json
  def update
    respond_to do |format|
      if @table.update(table_params)
        format.html { redirect_to table_url(@table), notice: "Table was successfully updated." }
        format.json { render :show, status: :ok, location: @table }
      else
        format.json { render json: { status: 'error', msg: @table.errors }, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1 or /tables/1.json
  def destroy
    @table.destroy

    respond_to do |format|
      format.html { redirect_to tables_url, notice: "Table was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def table_params
      params.require(:table).permit(:name, 
        :number, :vouters, :active, :institution_id, :fiscal_id,
        tables_political_parties_attributes: [ :id, :political_party_id ])
    end
end
