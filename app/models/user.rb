# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  email           :string(255)      not null
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  rol             :integer          not null
#  username        :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
class User < ApplicationRecord
	has_secure_password

  has_one :institution

	validates :name, presence: true
	validates :username, presence: true, 
		uniqueness: { case_sensitive: false, message: "Este usuario ya se encuentra registrado" },
    length: { in: 3..15 },
    format: {
      with: /\A[a-z0-9A-Z_]+\z/,
      message: :invalid
    }
	validates :password_digest, presence: true, length: { minimum: 6 }
	validates :email, presence: true, 
		uniqueness: { case_sensitive: false, message: "Este email ya se encuentra en uso" },
    format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }

  before_save :downcase_attributes

  scope :actives, -> { where(active: true) }
  
  enum rol: {
    admin: 1, 
    fiscal_gral: 2,
    fiscal: 3

  }
  def show_pass
    BCrypt.decrypt(self.password)
  end
  
  def rol_name
    rol_name = "Admin" if self.rol == 'admin'
    rol_name = "Fiscal gral" if self.rol == 'fiscal_gral'
    rol_name = "Fiscal" if self.rol == 'fiscal'
    rol_name
  end

  private

  def downcase_attributes
    self.username = username.downcase
    self.email = email.downcase
  end
end
