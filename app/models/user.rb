class User < ActiveRecord::Base

  validates :name, length: { minimum: 3 } , presence: true

  has_many :wikis

  enum role: [:standard, :premium, :admin]
  after_initialize :set_default_role   #, :if => :new_record

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def set_default_role
    self.role ||= :standard
  end
end
