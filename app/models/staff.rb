class Staff < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :issues
  attr_accessor :login
  validates :username,
            presence: true,
            uniqueness:  {
              case_sensitive: false
            }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(['username = :val OR lower(email) = lower(:val)',
                               { val: login }]).first
    else
      where(conditions).first
    end
  end
end
