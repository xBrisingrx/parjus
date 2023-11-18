# == Schema Information
#
# Table name: institutions
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(TRUE)
#  description         :text(65535)
#  direction           :string(255)      not null
#  name                :string(255)      not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  fiscal_id           :bigint
#  institution_type_id :bigint
#  neighborhood_id     :bigint
#
# Indexes
#
#  index_institutions_on_fiscal_id            (fiscal_id)
#  index_institutions_on_institution_type_id  (institution_type_id)
#  index_institutions_on_neighborhood_id      (neighborhood_id)
#
# Foreign Keys
#
#  fk_rails_...  (fiscal_id => users.id)
#  fk_rails_...  (institution_type_id => institution_types.id)
#  fk_rails_...  (neighborhood_id => neighborhoods.id)
#
class Institution < ApplicationRecord
  belongs_to :institution_type
  belongs_to :neighborhood
  has_one :city, through: :neighborhood
  has_many :tables

  accepts_nested_attributes_for :tables

  belongs_to :fiscal, class_name: 'User', optional: true

  validates :name, presence: true, 
    uniqueness: { case_sensitive: false, message: "Ya existe una institución registrada con este nombre" }
  scope :actives, -> { where(active: true) }

  def tables_closed(votation_id = nil)
    # count_closed = 0
    # self.tables.each do |table|
    #   count_closed+=1 if table.is_closed?(votation_id)
    # end
    # count_closed
    if votation_id == nil
      votation_id = Votation.last.id
    end
    self.tables.joins(:votes).where(votes: {votation_id: votation_id}).group(:table_id).count.count
  end

  def count_votes political_party_id, politician_rol_id
    tables = self.tables.actives 
    votes = self.tables.joins(:votes)
    data = votes.select('votes.id, votes.number').where("votes.political_party_id = #{political_party_id}").where("votes.politician_rol_id = #{politician_rol_id}")
    if data.blank?
      return 0 
    else
      sum_votes = 0
      data.each do |d|
        sum_votes += d.number
      end
      return sum_votes
    end
  end
end
