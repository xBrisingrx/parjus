class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]
  before_action :set_variables_form, only: %i[ new edit ]

  # GET /people or /people.json
  def index
    @people = Person.all
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
    data = Roo::Spreadsheet.open('public/data_1_50.xlsx') # open spreadsheet
    headers = data.row(1) # get header row
    coso = ''
    data.each_with_index do |row, idx|
      next if idx == 0 # skip header
      # create hash from headers and cells
      ActiveRecord::Base.transaction do
        person_data = Hash[[headers, row].transpose]
        person = Person.new
        person_name = person_data['name'].split(',')[1][1..]

        person.name = person_data['name'].split(',')[1][1..]
        person.last_name = person_data['name'].split(',')[0].split()[1]
        person.genre = person_data['genre']
        person.dni = person_data['dni'].to_i
        person.number = person_data['dni'].to_i

        if DniType.find_by_name(person_data['dni_type']).nil?
          DniType.create(name: person_data['dni_type'])
        end

        person.dni_type_id = DniType.find_by_name(person_data['dni_type']).id
        person.direction = person_data['direction']

        neighborhood = person_data['direction'].split(',')
        neighborhood = neighborhood.select{ |t| t.include? 'B°'}
        if !neighborhood.empty?
          neighborhood = neighborhood[0]
          neighborhood = neighborhood.gsub('B°', '').strip
          neighborhood = neighborhood.split('/')[0]
          person.neighborhood = Neighborhood.find_by_name(neighborhood)
        end
        if !person.save!
          puts "#{person.errors} \n\n"
          coso = person
        end
      end
      
      # coso = person if idx == 7
      # if User.exists?(email: user_data['email'])
      #   puts "User with email '#{user_data['email']}' already exists"
      #   next
      # end
      # user = User.new(user_data)
      
      # user.save!
    end
    rescue => e
        response = e.message.split(':')
        render json: { response[0] => response[1] }, status: 402
    # render json: { status: 'success', msg: 'importado' } 

  end

  def import_neighborhood
    data = Roo::Spreadsheet.open('public/data_1_50.xlsx') # open spreadsheet
    headers = data.row(1) # get header row
    data.each_with_index do |row, idx|
      next if idx == 0
      data = Hash[[headers, row].transpose]
      neighborhood = data['direction'].split(',')
      neighborhood = neighborhood.select{ |t| t.include? 'B°'}
      if !neighborhood.empty?
        neighborhood = neighborhood[0]
        neighborhood = neighborhood.gsub('B°', '').strip
        neighborhood = neighborhood.split('/')[0]
        puts "#{neighborhood}\n"
        
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
