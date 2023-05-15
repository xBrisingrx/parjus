json.data @people do |person|
	json.name person.name
	json.genre person.genre
	json.dni_type person.dni_type.name
	json.number person.number
	json.direction person.direction
	json.neighborhood (person.neighborhood) ? person.neighborhood.name : ''
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_person_path(person), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_person( #{ person.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end
