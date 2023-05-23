json.data @institution_types do |institution_type|
	json.name institution_type.name
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, 
										edit_institution_type_path(institution_type), 
										remote: :true, 
										class: 'btn btn-sm u-btn-primary text-white', 
										title: 'Editar' }"
end
