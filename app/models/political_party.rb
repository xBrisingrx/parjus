# == Schema Information
#
# Table name: political_parties
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  color       :string(255)      default("#aae0fa")
#  description :text(65535)
#  list        :integer
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  votation_id :bigint
#
# Indexes
#
#  index_political_parties_on_votation_id  (votation_id)
#
# Foreign Keys
#
#  fk_rails_...  (votation_id => votations.id)
#
class PoliticalParty < ApplicationRecord
	has_many :politicians_parties
	accepts_nested_attributes_for :politicians_parties
	scope :actives, -> { where(active:true) }

	def show_politicians
		politicians = ''
		self.politicians_parties.map { |politician|
			politicians += "#{politician.politician} "
		}
		" => #{politicians} "
	end

	def has_rol rol_id
		!self.politicians_parties.where( politician_rol_id: rol_id ).blank?
	end

	def self.last_votations
		votation = Votation.last.id
		self.where(votation_id: votation)
	end

end
