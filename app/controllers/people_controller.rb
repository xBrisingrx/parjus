class PeopleController < ApplicationController
  before_action :authorize!
  before_action :set_person, only: %i[ show edit update destroy ]
  before_action :set_variables_form, only: %i[ new edit ]

  # GET /people or /people.json
  def index
    @people = Person.all.includes(:dni_type,:neighborhood)
  end

  # GET /people/1 or /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
    @neighborhoods = Neighborhood.actives
    @dni_types = DniType.actives
    @title_modal = "Registro de afiliado"
  end

  # GET /people/1/edit
  def edit
    @neighborhoods = Neighborhood.actives
    @dni_types = DniType.actives
    @title_modal = "Editar afiliado #{@person.fullname}"
  end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.json { render json: { status: 'success', msg: 'Afiliado registrado' }, status: :created }
        format.html { redirect_to person_url(@person), notice: "Person was successfully created." }
      else
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.json { render json: { status: 'success', msg: 'Datos actualizados' }, status: :ok}
        format.html { redirect_to person_url(@person), notice: "Person was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url, notice: "Person was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    data = Roo::Spreadsheet.open('public/parjus_people.xlsx') # open spreadsheet
    headers = data.row(1) # get header row
    
    data.each_with_index do |row, idx|
      next if idx == 0

      person_data = Hash[[row].transpose]
      next if person_data.keys[0].split.first == '<html><b>Partido'
      next if person_data.keys[0].split.first == 'Padron'
      next if person_data.keys[0].split.first == '<html><u>Localidad:'
      next if person_data.keys[0].split.first == '<html><b>Fecha'
      next if person_data.keys[0].split.first == '<html><b>Orden</b></html>'

      person_data = person_data.keys.compact
      person = Person.new
      person.name = person_data[0].split(',')[1][1..]
      person.last_name = person_data[0].split(',')[0].split()[1]
      person.genre = person_data[1]
      

      if person_data[2].to_i == 0
        if DniType.find_by_name(person_data[2]).nil?
          DniType.create( name: person_data[2] )
        end
        person.dni_type_id = DniType.find_by_name(person_data[2]).id

        dni_index = 3
        direction_index = 4
      else
        dni_index = 2
        direction_index = 3
      end
      person.dni = person_data[dni_index].to_i
      person.number = person_data[dni_index].to_i

      person.direction = person_data[direction_index]
      neighborhood = person_data[direction_index].split(',')
      neighborhood = neighborhood.select{ |t| t.include? 'B°'}
      if !neighborhood.empty?
        if neighborhood.count == 2
          neighborhood = neighborhood[1]
        else
          neighborhood = neighborhood[0]
        end
        neighborhood = neighborhood.gsub('B°', '').strip
        neighborhood = neighborhood.split('/')[0]

        person.neighborhood = Neighborhood.find_by_name(neighborhood)
      end

      person.save
    end
    
  end

  def import_neighborhood
    excel = Roo::Spreadsheet.open('public/parjus_people.xlsx') # open spreadsheet
    # headers = data.row(1) # get header row
    excel.each_with_index do |row, idx|
      next if idx == 0
      # data = Hash[[headers, row].transpose]
      # neighborhood = data['direction'].split(',')
      data = Hash[[row].transpose]
      next if data.keys[0].split.first == '<html><b>Partido'
      next if data.keys[0].split.first == 'Padron'
      next if data.keys[0].split.first == '<html><u>Localidad:'
      next if data.keys[0].split.first == '<html><b>Fecha'
      next if data.keys[0].split.first == '<html><b>Orden</b></html>'
      data = data.keys.compact

      if data[2].to_i == 0
        direction_index = 4
      else
        direction_index = 3
      end

      neighborhood = data[direction_index].split(',')

      neighborhood = neighborhood.select{ |t| t.include? 'B°'}

      if !neighborhood.empty?
        if neighborhood.count == 2
          neighborhood = neighborhood[1]
        else
          neighborhood = neighborhood[0]
        end
        
        neighborhood = neighborhood.gsub('B°', '').strip
        neighborhood = neighborhood.split('/')[0]

        Neighborhood.create(name: neighborhood, city_id: 1 ) if Neighborhood.find_by_name(neighborhood).nil?
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    def set_variables_form
      @genres = [ {id: :M , value: 'Masculino'}, { id: :F, value: 'Femenino'} ]
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:name, :last_name, :genre, :dni, :number, :direction, :neighborhood_id, :dni_type_id, :active)
    end
end