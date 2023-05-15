# == Schema Information
#
# Table name: cities
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  description :text(65535)
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  province_id :bigint
#
# Indexes
#
#  index_cities_on_province_id  (province_id)
#
# Foreign Keys
#
#  fk_rails_...  (province_id => provinces.id)
#
class City < ApplicationRecord
  belongs_to :province

  validates :name, presence: true, 
    uniqueness: { case_sensitive: false, message: "Ya existe una ciudad registrada con este nombre" }
  scope :actives, -> { where(active: true) }
end
