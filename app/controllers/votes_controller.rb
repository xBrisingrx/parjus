class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]

  # GET /votes or /votes.json
  def index
    redirect_to institucion_votes_path if Custom.fiscal_gral?
    redirect_to mesa_votes_path if Custom.fiscal?

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

  # GET /votes/1 or /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @title_modal = "Registrar voto"
    @vote = Vote.new
    if current_user.fiscal_gral?
      @tables = Institution.find_by_fiscal_id(current_user.id).tables.order( name: :asc)
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
    # @vote = Vote.new(vote_params)
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
      @vote = Vote.new(vote_params)
      respond_to do |format|
        if @vote.save
          format.json { render json: { status: 'success', msg: 'Votos registrados' }, status: :created }
          format.html { redirect_to votes_url, notice: "Vote was successfully created." }
        else
          format.json { render json: @vote.errors, status: :unprocessable_entity }
        end
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
