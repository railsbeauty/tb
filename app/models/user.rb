class User < ActiveRecord::Base
attr_accessor :login
def self.find_first_by_auth_conditions(warden_conditions)
   conditions = warden_conditions.dup
    if login = conditions.delete(:login)
       where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
       where(conditions).first
    end
  end
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :login, :username, :password, :password_confirmation, :remember_me, :fname, :lname
  # attr_accessible :title, :body
end
