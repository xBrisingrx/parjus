class NeighborhoodsController < ApplicationController
  before_action :authorize!
  before_action :set_neighborhood, only: %i[ show edit update destroy ]

  # GET /neighborhoods or /neighborhoods.json
  def index
    @neighborhoods = Neighborhood.actives
  end

  # GET /neighborhoods/1 or /neighborhoods/1.json
  def show
  end

  # GET /neighborhoods/new
  def new
    @neighborhood = Neighborhood.new
  end

  # GET /neighborhoods/1/edit
  def edit
  end

  # POST /neighborhoods or /neighborhoods.json
  def create
    @neighborhood = Neighborhood.new(neighborhood_params)
    @neighborhood.city_id = 1
    respond_to do |format|
      if @neighborhood.save
        format.json { render json: {status: 'success', msg: 'Barrio registrado'}, status: :created }
      else
        byebug
        format.json { render json: @neighborhood.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /neighborhoods/1 or /neighborhoods/1.json
  def update
    respond_to do |format|
      if @neighborhood.update(neighborhood_params)
        format.json { render json: {status: 'success', msg: 'Datos actualizados'}, status: :ok, location: @neighborhood }
        format.html { redirect_to neighborhood_url(@neighborhood), notice: "Neighborhood was successfully updated." }
      else
        format.json { render json: @neighborhood.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /neighborhoods/1 or /neighborhoods/1.json
  def destroy
    @neighborhood.destroy

    respond_to do |format|
      format.html { redirect_to neighborhoods_url, notice: "Neighborhood was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def fix_neighborhood
    name = params[:neighborhood_name]
    id = params[:neighborhood_id].to_i
    neightborhoods = Neighborhood.where("name LIKE ?", "%#{name}%" ).where.not(id: id)
    
    # puts "\n cantidad de personas afectadas => #{neightborhoods.joins(:people).count} \n"
    # byebug
    ids = neightborhoods.pluck(:id)
    people = Person.where(neighborhood_id: ids)

    people.each do |person|
      person.update(neighborhood_id: id)
    end
    neightborhoods.each do |neightborhood|
      neightborhood.destroy if neightborhood.people.count == 0
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_neighborhood
      @neighborhood = Neighborhood.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def neighborhood_params
      params.require(:neighborhood).permit(:name, :description, :active, :city_id)
    end
end
