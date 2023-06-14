# == Schema Information
#
# Table name: politician_rols
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PoliticianRol < ApplicationRecord
	validates :name, presence: true, 
    uniqueness: { case_sensitive: false, message: "Ya existe un cargo con este nombre" }
  scope :actives, -> { where(active: true) }
end
