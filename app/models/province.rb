# == Schema Information
#
# Table name: provinces
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_provinces_on_name  (name) UNIQUE
#
class Province < ApplicationRecord
	has_many :cities
	validates :name, presence: true, 
		uniqueness: { case_sensitive: false, message: "Ya existe una provincia registrada con este nombre" }
	scope :actives, -> { where(active: true) }
end
