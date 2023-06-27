class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]

  # GET /votes or /votes.json
  def index
    redirect_to institucion_votes_path if Current.user.fiscal_gral?
    redirect_to mesa_votes_path if Current.user.fiscal?

    if Current.user.admin?
      @cols = [ 'Institucion', 'Mesas cerradas', 'Referente' ,'Partidos' ]
      @cols_parties = [ 'Partido' ]
      @politician_rols = PoliticianRol.actives.order(:name)
      @political_parties = PoliticalParty.actives
      @count_political_parties = @political_parties.count
      @politician_rols.each do |rol|
        @cols << rol.name 
        @cols_parties << rol.name
      end
      @institutions = Institution.actives
    end
  end

  def by_table # vista de fiscal de mesa
    @table = Table.find_by_fiscal_id(current_user.id)
    @votes = @table.votes
    @votes = @votes.group(:political_party_id).sum(:number)
    @parties = @table.political_parties.order('political_parties.name')
    @title = "de la mesa #{@table.name}"
    @data = []
    @parties.each do |p|
      @data << { 'party'=> p.name, 'votes' => @votes[p.id] }
    end
  end

  def by_institution # vista de fiscal general
    @institution = Institution.find_by_fiscal_id(current_user.id)
    @tables = @institution.tables
    @votos_por_mesa = []
    @tables.each do |table|
      @votos_por_mesa << table.votes.group(:political_party_id).sum(:number)
    end

    @parties = PoliticalParty.all.order(:name)
    @title = "de la institution #{@institution.name}"
    @data = []
    @tables.each do |table|
      votes = table.votes
      votes = votes.group(:political_party_id).sum(:number)
      @parties.each do |p|
        hash_data = { 'table' => "Mesa #{table.name}" }
        hash_data['party'] = p.name 
        hash_data['votes'] = votes[p.id]
        @data << hash_data
      end
    end
  end

  def grafic_data
    @politician_rols = PoliticianRol.actives.order(:name)
    @political_parties = PoliticalParty.actives
    @chart_data = []
    @chart_cols = []
    @politician_rols.each do |rol|
      @political_parties.each do |party|
        @chart_cols << "#{party.name} #{rol.name}"
        @chart_data << Vote.by_party( party.id, rol.id )
      end
    end
    render json: { 'chart_cols': @chart_cols, 'chart_data': @chart_data }
  end

  # GET /votes/1 or /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @title_modal = "Registrar voto"
    @politician_roles = PoliticianRol.actives.order(name: :asc)
    @vote = Vote.new

    if current_user.fiscal_gral?
      @tables = Institution.find_by_fiscal_id(current_user.id).tables.where('tables.closed = false').order( name: :asc)
      @parties = PoliticalParty.all.order(name: :asc)
      @form = 'form'
    else
      # fiscal de mesa
      @table = Table.find_by_fiscal_id(current_user.id)
      @parties = @table.political_parties.order(name: :asc)
      @form = 'form_by_table'
    end
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes or /votes.json
  def create
    if Current.user.fiscal?
      ActiveRecord::Base.transaction do 
        for i in 1..params[:cant].to_i do 
          Vote.create( table_id: params[:table_id],
            political_party_id: params["political_party_id_#{i}".to_sym],
            number: params["number_#{i}".to_sym] )
        end
      end
      respond_to do |format|
        format.json { render json: { status: 'success', msg: 'Votos registrados' }, status: :created }
        format.html { redirect_to votes_url, notice: "Vote was successfully created." }
      end
    elsif Current.user.fiscal_gral?
      ActiveRecord::Base.transaction do 
        for i in 1..params[:vote][:entry_votes].to_i do 
          Vote.create(table_id: params[:vote][:table_id],
            political_party_id: params[:vote][:political_party_id][i.to_s],
            number: params[:vote][:number][i.to_s],
            politician_rol_id: params[:vote][:politician_rol_id][i.to_s])
        end

        table = Table.find(params[:vote][:table_id])
        table.update(closed: true)
      end
      respond_to do |format|
        format.json { render json: { status: 'success', msg: 'Votos registrados' }, status: :created }
        format.html { redirect_to votes_url, notice: "Vote was successfully created." }
      end
    end

    rescue ActiveRecord::RecordInvalid
        render json: { status: 'error', msg: 'No se pudo realizar el registro' }, status: :unprocessable_entity
  end

  # PATCH/PUT /votes/1 or /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to vote_url(@vote), notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1 or /votes/1.json
  def destroy
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url, notice: "Vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:table_id, :political_party_id, :number)
    end
end