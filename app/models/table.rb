# == Schema Information
#
# Table name: tables
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  closed         :boolean          default(FALSE)
#  number         :integer          not null
#  vouters        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  fiscal_id      :bigint
#  institution_id :bigint
#
# Indexes
#
#  index_tables_on_fiscal_id       (fiscal_id)
#  index_tables_on_institution_id  (institution_id)
#
# Foreign Keys
#
#  fk_rails_...  (fiscal_id => users.id)
#  fk_rails_...  (institution_id => institutions.id)
#
class Table < ApplicationRecord
  belongs_to :institution
  has_many :tables_political_parties, dependent: :destroy
  has_many :political_parties, through: :tables_political_parties
  has_many :votes
  belongs_to :fiscal, class_name: 'User', optional: true

  accepts_nested_attributes_for :tables_political_parties
  
  validates :number, presence: true, numericality: { only_integer: true }, uniqueness: true
  # validates :vouters, presence: true
  scope :actives, ->{ where(active:true) }

  after_create :add_political_parties

  def self.porcent_tables_closed(votation_id = nil)
    if votation_id == nil
      votation_id = Votation.last.id
    end
    closeds = Vote.where(votation_id: votation_id).group(:table_id).count.count
    all_tables = Table.where(active:true).count
    porcent = (closeds * 100) / all_tables
    porcent
  end

  def count_votes political_party_id, politician_rol_id
    data = self.votes.select('votes.id, votes.number').where("votes.political_party_id = #{political_party_id}").where("votes.politician_rol_id = #{politician_rol_id}")
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

  def is_closed?(votation_id = nil)
    if votation_id == nil
      votation_id = Votation.last.id
    end
    self.votes.where(votation_id: votation_id).count > 0
  end

  def self.tables_closed(votation_id = nil)
    if votation_id == nil
      votation_id = Votation.last.id
    end
    Vote.where(votation_id: votation_id).group(:table_id).count.count
  end

  private 

  def add_political_parties
    political_parties = PoliticalParty.actives 
    political_parties.each do |party|
      self.tables_political_parties.create( political_party: party )
    end
  end
end
