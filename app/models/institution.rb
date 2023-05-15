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
#  institution_type_id :bigint
#  neighborhood_id     :bigint
#
# Indexes
#
#  index_institutions_on_institution_type_id  (institution_type_id)
#  index_institutions_on_neighborhood_id      (neighborhood_id)
#
# Foreign Keys
#
#  fk_rails_...  (institution_type_id => institution_types.id)
#  fk_rails_...  (neighborhood_id => neighborhoods.id)
#
class Institution < ApplicationRecord
  belongs_to :institution_type
  belongs_to :neighborhood
  has_one :city, through: :neighborhood

  validates :name, presence: true, 
    uniqueness: { case_sensitive: false, message: "Ya existe una institución registrada con este nombre" }
  scope :actives, -> { where(active: true) }
end
