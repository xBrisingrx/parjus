json.data @tables do |table|
	json.name table.name 
	json.vouters table.vouters
	# json.fiscal table.fiscal.&name
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_table_path(table), 
										remote: :true, 
										class: 'btn btn-sm u-btn-primary text-white', 
										title: 'Editar' } "
end