class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :articles
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:admin, :author, :member]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :member
  end

  #ROLES = %w[admin author member]

  # def role_symbols
  #   [role.to_sym]
  # end
 
  # def is?(role)
  #   roles.include?(role.to_s)
  # end

  # def role?(role)
  #   roles.include?(role.to_s)
  # end

  # def admin?
  #   self.user.role == 'admin'
  # end.
  
end
