# == Schema Information
#
# Table name: politicians_parties
#
#  id                 :bigint           not null, primary key
#  active             :boolean          default(TRUE)
#  politician         :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  political_party_id :bigint
#  politician_rol_id  :bigint
#
# Indexes
#
#  index_politicians_parties_on_political_party_id  (political_party_id)
#  index_politicians_parties_on_politician_rol_id   (politician_rol_id)
#
# Foreign Keys
#
#  fk_rails_...  (political_party_id => political_parties.id)
#  fk_rails_...  (politician_rol_id => politician_rols.id)
#
class PoliticiansParty < ApplicationRecord
  belongs_to :political_party
  belongs_to :politician_rol
end
