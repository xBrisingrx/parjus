json.data @neighborhoods do |neighborhood|
	json.name neighborhood.name
	json.people neighborhood.people.count
	json.institutions neighborhood.institutions.count
	json.actions ""
end
