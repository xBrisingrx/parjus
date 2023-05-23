json.data @headquarters do |headquarter|
	json.name headquarter.name 
	json.neighborhood headquarter.neighborhood.name
	json.in_charge headquarter.in_charge
	json.actions ''
end