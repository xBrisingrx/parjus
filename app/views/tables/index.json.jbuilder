json.data @tables do |table|
	json.name table.name 
	json.vouters table.vouters
	json.fiscal table.fiscal.name
	lists = '<ul>'
	table.political_parties.map { |party|
		lists += "<li> <b>#{party.name} </li>"
	}
	lists += '</ul>'

	json.lists lists
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_table_path(table), 
										remote: :true, 
										class: 'btn btn-sm u-btn-primary text-white', 
										title: 'Editar' } "
end