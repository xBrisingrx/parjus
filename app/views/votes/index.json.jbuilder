json.data @institutions do |institution|
	json.name institution.name
	json.tables "#{ institution.tables_closed } de #{ institution.tables.actives.count }"
	json.institutions institution.institutions.count
	json.actions ""
end
