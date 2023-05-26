# == Schema Information
#
# Table name: tables_political_parties
#
#  id                 :bigint           not null, primary key
#  active             :boolean          default(TRUE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  political_party_id :bigint
#  table_id           :bigint
#
# Indexes
#
#  index_tables_political_parties_on_political_party_id  (political_party_id)
#  index_tables_political_parties_on_table_id            (table_id)
#
# Foreign Keys
#
#  fk_rails_...  (political_party_id => political_parties.id)
#  fk_rails_...  (table_id => tables.id)
#
class TablesPoliticalParty < ApplicationRecord
  belongs_to :table
  belongs_to :political_party
end
