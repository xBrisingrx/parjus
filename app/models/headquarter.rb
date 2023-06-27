# == Schema Information
#
# Table name: headquarters
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  description     :text(65535)
#  name            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  neighborhood_id :bigint
#
# Indexes
#
#  index_headquarters_on_neighborhood_id  (neighborhood_id)
#
# Foreign Keys
#
#  fk_rails_...  (neighborhood_id => neighborhoods.id)
#
class Headquarter < ApplicationRecord
  belongs_to :neighborhood
  has_many :headquarter_affiliateds
  has_many :people, through: :headquarter_affiliateds

  accepts_nested_attributes_for :headquarter_affiliateds
  def in_charge
    people = ''
    self.headquarter_affiliateds.map { |affiliated|
      if affiliated.affiliated_rol.name == 'Referente'
        people += "#{affiliated.person.fullname} "
      end
    }
  people
  end
end
