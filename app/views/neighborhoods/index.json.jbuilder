json.data @neighborhoods do |neighborhood|
	json.name neighborhood.name
	json.people neighborhood.people.count
	json.institutions neighborhood.institutions.count
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_neighborhood_path(neighborhood), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' }"
end
