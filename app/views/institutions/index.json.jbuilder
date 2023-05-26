json.data @institutions do |institution|
	json.name institution.name
	json.type institution.institution_type.name
	json.city institution.city.name
	json.neighborhood institution.neighborhood.name
	json.direction institution.direction
	json.tables institution.tables.count
	json.fiscal ( institution.fiscal.nil? ) ? '' : institution.fiscal.name
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_institution_path(institution), 
										remote: :true, 
										class: 'btn btn-sm u-btn-primary text-white', 
										title: 'Editar' } 
								#{ link_to '<i class="fa fa-table"></i>'.html_safe, tables_path(institution_id: institution.id), 
										remote: :true, 
										class: 'btn btn-sm u-btn-primary text-white', 
										title: 'Ver mesas' } 
								 "
end
