class ReportsController < ApplicationController
  def people_list
		@people = Person.actives.includes(:dni_type).includes(:neighborhood)
		respond_to do |format|
			format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="afiliados.xlsx"'
      }
		end
	end
end
