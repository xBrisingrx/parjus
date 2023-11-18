json.data @political_parties do |political_party|
	json.name political_party.name
	
	json.description political_party.description
	politicians = '<ul>'
	political_party.politicians_parties.map { |politician|
		politicians += "<li> <b>#{politician.politician_rol.name} :</b> #{politician.politician}</li>"
	}
	politicians += '</ul>'

	json.politicians politicians

	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, "#", 
		disable:true, remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' }"
end
