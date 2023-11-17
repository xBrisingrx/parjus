# == Schema Information
#
# Table name: votations
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  date       :date
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Votation < ApplicationRecord
	has_many :votes
	has_many :political_parties
end
