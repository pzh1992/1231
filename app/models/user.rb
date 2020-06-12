class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessor :password, :password_confirmation, :token
  
  CELLPHONE_RE = /\A(\+86|86)?1\d{10}\z/

  has_many :coupons
  belongs_to :role
end
