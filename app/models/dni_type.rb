# == Schema Information
#
# Table name: dni_types
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  description :text(65535)
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_dni_types_on_name  (name) UNIQUE
#
class DniType < ApplicationRecord
	has_many :poeple

  validates :name, presence: true, 
    uniqueness: { case_sensitive: false, message: "Ya existe un tipo de dni con este nombre" }
  scope :actives, -> { where(active: true) }
end
