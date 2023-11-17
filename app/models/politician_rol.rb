# == Schema Information
#
# Table name: politician_rols
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  votation_id :bigint
#
# Indexes
#
#  index_politician_rols_on_votation_id  (votation_id)
#
# Foreign Keys
#
#  fk_rails_...  (votation_id => votations.id)
#
class PoliticianRol < ApplicationRecord
  has_many :politicians_parties

	validates :name, presence: true, 
    uniqueness: { case_sensitive: false, message: "Ya existe un cargo con este nombre" }
  scope :actives, -> { where(active: true) }

  def self.votations(votation_id = nil)
    if votation_id == nil
      votation_id = Votation.last.id 
    end
    PoliticianRol.joins(politicians_parties: :political_party)
      .where(political_parties: {votation_id: votation_id })
      .group('politician_rols.id')
      .select("politician_rols.id, politician_rols.name")
  end
end
