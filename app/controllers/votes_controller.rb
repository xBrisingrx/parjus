class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]

  # GET /votes or /votes.json
  def index
    redirect_to institucion_votes_path if Current.user.fiscal_gral?
    redirect_to mesa_votes_path if Current.user.fiscal?

    if Current.user.admin?
      @cols = [ 'Institucion', 'Mesas cerradas', 'Referente' ,'Partidos' ]
      @cols_parties = [ 'Partido' ]
      @politician_rols = PoliticianRol.actives
      @political_parties = PoliticalParty.actives
      @count_political_parties = @political_parties.count
      @politician_rols.each do |rol|
        @cols << rol.name 
        @cols_parties << rol.name
      end
      @institutions = Institution.actives
      @porcent_tables_closed = Table.porcent_tables_closed
    end
  end

  def by_table # vista de fiscal de mesa
    @table = Table.find_by_fiscal_id(current_user.id)
    @votes = @table.votes
    @votes = @votes.group(:political_party_id).sum(:number)
    @parties = @table.political_parties.order('political_parties.name')
    @title = "de la mesa #{@table.number}"
    @data = []
    @parties.each do |p|
      @data << { 'party'=> p.name, 'votes' => @votes[p.id] }
    end
  end

  def by_institution # vista de fiscal general
    @institution = Institution.find_by_fiscal_id(current_user.id)
    @tables = @institution.tables
    @total_tables = @tables.count 
    @closed_tables = @institution.tables.where(closed: true).count
    @politician_rols = PoliticianRol.actives
    @political_parties = PoliticalParty.actives
    @count_political_parties = @political_parties.count
    @votos_por_mesa = []
    @tables.each do |table|
      @votos_por_mesa << table.votes.group(:political_party_id).sum(:number)
    end

    @cols = [ 'Mesa', 'Partidos']
    @politician_rols.each do |rol|
      @cols << rol.name 
    end

    @cols << 'Acciones'

    @parties = PoliticalParty.all
    @title = "de la institution #{@institution.name}"
    @data = []
    @tables.each do |table|
      votes = table.votes
      votes = votes.group(:political_party_id).sum(:number)
      @parties.each do |p|
        hash_data = { 'table' => "Mesa #{table.number}" }
        hash_data['party'] = p.name 
        hash_data['votes'] = votes[p.id]
        hash_data['table_id'] = table.id
        @data << hash_data
      end
    end
  end

  def show_by_table
    @table = Table.find params[:id]
    @parties = PoliticalParty.all
    @politician_roles = PoliticianRol.actives
    @votes_categories = [
      { name: 'Votos nulos:', value: 'nulo' },
      { name: 'Votos recorridos:', value: 'recorrido' },
      { name: 'Votos en blanco:', value: 'blanco' }
    ]
    @title_modal = "Votos ingresados en la mesa ##{@table.number}"
  end

  def grafic_data
    @politician_rols = PoliticianRol.actives
    rol_id = params[:rol_id]
    @political_parties = PoliticalParty.actives
    @chart_data = []
    @chart_cols = []
    # @politician_rols.each do |rol|
      @political_parties.each do |party|
        @chart_cols << "#{party.name}"
        @chart_data << Vote.by_party( party.id, rol_id )
      end
    # end
    render json: { 'chart_cols': @chart_cols, 'chart_data': @chart_data }
  end

  # GET /votes/1 or /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @title_modal = "Registrar voto"
    @politician_roles = PoliticianRol.actives
    @vote = Vote.new

    @other_votes = Array.new 
    @other_votes << { type: :nulo, title: 'Votos nulos', color: 'blue' }
    @other_votes << { type: :recorrido, title: 'Votos recorridos', color: 'indigo' }
    @other_votes << { type: :blanco, title: 'Votos en blanco', color: 'pink' }

    if current_user.fiscal_gral?
      @tables = Institution.find_by_fiscal_id(current_user.id).tables.where('tables.closed = false').order( number: :asc)
      @parties = PoliticalParty.all
      @form = 'form'
    else
      # fiscal de mesa
      @table = Table.find_by_fiscal_id(current_user.id)
      @parties = @table.political_parties
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
          vote = Vote.new( table_id: params[:table_id],
            number: params["number_#{i}".to_sym],
            category: params["category_#{i}".to_sym],
          )

          if params["category_#{i}".to_sym] == 'normal'
            vote.political_party_id = params["political_party_id_#{i}".to_sym]
          end
          vote.save
        end
      end
      respond_to do |format|
        format.html { redirect_to votes_url, notice: "Vote was successfully created." }
        format.json { render json: { status: 'success', msg: 'Votos registrados', url: votes_path }, status: :created }
      end
    elsif Current.user.fiscal_gral?
      ActiveRecord::Base.transaction do 
        for i in 1..params[:vote][:entry_votes].to_i do 
          vote = Vote.new(
            number: params[:vote][:number][i.to_s],
            politician_rol_id: params[:vote][:politician_rol_id][i.to_s],
            category: params[:vote][:category][i.to_s],
            table_id: params[:vote][:table_id],
          )

          if params[:vote][:category][i.to_s] == 'normal'
            vote.political_party_id = params[:vote][:political_party_id][i.to_s]
          end
          vote.save!
          # Vote.create(table_id: params[:vote][:table_id],
          #   political_party_id: params[:vote][:political_party_id][i.to_s],
          #   number: params[:vote][:number][i.to_s],
          #   politician_rol_id: params[:vote][:politician_rol_id][i.to_s])
        end

        table = Table.find(params[:vote][:table_id])
        table.update(closed: true)
      end
      respond_to do |format|
        format.json { render json: { status: 'success', msg: 'Votos registrados', url: votes_path }, status: :created }
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
      params.require(:vote).permit(:table_id, :political_party_id, :number, :category)
    end
end
