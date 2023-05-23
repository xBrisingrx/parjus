# == Schema Information
#
# Table name: political_parties
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  description :text(65535)
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class PoliticalParty < ApplicationRecord
	has_many :politicians_parties
	accepts_nested_attributes_for :politicians_parties

	def show_politicians
		politicians = ''
		self.politicians_parties.map { |politician|
			politicians += "#{politician.politician} "
		}
		" => #{politicians} "
	end
end
