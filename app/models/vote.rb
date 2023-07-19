# == Schema Information
#
# Table name: votes
#
#  id                 :bigint           not null, primary key
#  category           :integer          default("normal")
#  number             :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  political_party_id :bigint
#  politician_rol_id  :bigint
#  table_id           :bigint
#
# Indexes
#
#  index_votes_on_political_party_id  (political_party_id)
#  index_votes_on_politician_rol_id   (politician_rol_id)
#  index_votes_on_table_id            (table_id)
#
# Foreign Keys
#
#  fk_rails_...  (political_party_id => political_parties.id)
#  fk_rails_...  (politician_rol_id => politician_rols.id)
#  fk_rails_...  (table_id => tables.id)
#
class Vote < ApplicationRecord
  belongs_to :table
  belongs_to :political_party, optional: true
  belongs_to :politician_rol

  validates :number, presence: true, numericality: { only_integer: true }
  validates :category, presence: true

  enum category: {
    normal: 0,
    blanco: 1,
    nulo: 2,
    recorrido: 3
  }

  def self.by_party party_id, rol_id
    votes = Vote.where( political_party_id: party_id, politician_rol_id: rol_id ).sum(:number)
    votes
  end
end
