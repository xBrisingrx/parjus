# == Schema Information
#
# Table name: people
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  direction       :string(255)
#  dni             :bigint
#  genre           :integer          not null
#  last_name       :string(255)      not null
#  name            :string(255)      not null
#  number          :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  dni_type_id     :bigint
#  neighborhood_id :bigint
#
# Indexes
#
#  index_people_on_dni_type_id      (dni_type_id)
#  index_people_on_neighborhood_id  (neighborhood_id)
#
# Foreign Keys
#
#  fk_rails_...  (dni_type_id => dni_types.id)
#  fk_rails_...  (neighborhood_id => neighborhoods.id)
#
class Person < ApplicationRecord
  belongs_to :neighborhood, optional: true
  belongs_to :dni_type, optional: true

  validates :name, :last_name, :number, presence: true
  validates :number, 
    uniqueness: { message: "Esta matrícula ya se encuentra registrada" },
    format: {
        with: /\A[0-9]+\z/,
        message: "Solo puede ingresar números"
      }

  validates :dni, 
    uniqueness: { message: "Esta dni ya se encuentra en uso" },
    format: {
        with: /\A[0-9]+\z/,
        message: "Solo puede ingresar números"
      }
  
  scope :actives, -> { where(active: true) }

  enum genre: [:X,:M, :F]

  def fullname
    "#{self.last_name} #{self.name}"
  end

  def fix_names
    names = ''
    last_names = ''
    self.name.split .each do |name|
      names += "#{name.capitalize} "
    end

    self.last_name.split.each do |last_name|
      last_names += "#{last_name.capitalize} "
    end

    self.update(name: names, last_name: last_names)
  end

  def age
    case self.dni 
      when 4000000..5000000
        80
      when 5000001..10000000
        75
      when 10000001..15000000
        70
      when 15000001..20000000
        65
      when 20000001..25000000
        60
      when 25000001..30000000
        40
      when 30000001..35000000
        34
      when 35000001..40000000
        27
      when 40000001..45000000
        24
      else
        20 
    end
  end
end
