json.data @politician_rols do |politician_rol|
	json.name politician_rol.name
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, 
										edit_politician_rol_path(politician_rol), 
										remote: :true, 
										class: 'btn btn-sm u-btn-primary text-white', 
										title: 'Editar' }"
end
