json.data @tables do |table|
	json.number table.number 
	# json.vouters table.vouters
	# json.fiscal table.fiscal.&name
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_table_path(table), 
										remote: :true, 
										class: 'btn btn-sm u-btn-primary text-white', 
										title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_table( #{ table.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end