# == Schema Information
#
# Table name: tables
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  closed         :boolean          default(FALSE)
#  name           :string(255)      not null
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

  validates :name, presence: true 
  validates :number, presence: true, numericality: { only_integer: true }
  validates :vouters, presence: true

  scope :actives, ->{ where(active:true) }

  after_create :add_political_parties

  def self.porcent_tables_closed
    closeds = Table.where(closed: true).where(active:true).count
    all_tables = Table.where(active:true).count
    porcent = (closeds * 100) / all_tables
    porcent
  end

  private 

  def add_political_parties
    political_parties = PoliticalParty.actives 
    political_parties.each do |party|
      self.tables_political_parties.create( political_party: party )
    end
  end
end
