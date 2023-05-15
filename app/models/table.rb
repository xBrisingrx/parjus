# == Schema Information
#
# Table name: tables
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  name           :string(255)      not null
#  number         :integer          not null
#  vouters        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  institution_id :bigint
#
# Indexes
#
#  index_tables_on_institution_id  (institution_id)
#
# Foreign Keys
#
#  fk_rails_...  (institution_id => institutions.id)
#
class Table < ApplicationRecord
  belongs_to :institution
end
