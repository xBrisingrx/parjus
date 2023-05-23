# == Schema Information
#
# Table name: affiliated_rols
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AffiliatedRol < ApplicationRecord
	scope :actives, -> { where(active: true) }
end
