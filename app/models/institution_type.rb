# == Schema Information
#
# Table name: institution_types
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  description :text(65535)
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class InstitutionType < ApplicationRecord
	has_many :institutions

	validates :name, presence: true, 
    uniqueness: { case_sensitive: false, message: "Ya existe un tipo de institución registrada con este nombre" }
  scope :actives, -> { where(active: true) }
end
