# == Schema Information
#
# Table name: headquarter_affiliateds
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  affiliated_rol_id :bigint
#  headquarter_id    :bigint
#  person_id         :bigint
#
# Indexes
#
#  index_headquarter_affiliateds_on_affiliated_rol_id  (affiliated_rol_id)
#  index_headquarter_affiliateds_on_headquarter_id     (headquarter_id)
#  index_headquarter_affiliateds_on_person_id          (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (affiliated_rol_id => affiliated_rols.id)
#  fk_rails_...  (headquarter_id => headquarters.id)
#  fk_rails_...  (person_id => people.id)
#
class HeadquarterAffiliated < ApplicationRecord
  belongs_to :headquarter
  belongs_to :person
  belongs_to :affiliated_rol

  scope :actives, -> { where(active:true) }
end
