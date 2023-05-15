# == Schema Information
#
# Table name: neighborhoods
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  description :text(65535)
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :bigint
#
# Indexes
#
#  index_neighborhoods_on_city_id  (city_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#
class Neighborhood < ApplicationRecord
  belongs_to :city

  validates :name, presence: true, 
    uniqueness: { case_sensitive: false, message: "Ya existe un barrio registrada con este nombre" }
  scope :actives, -> { where(active: true) }
end
