class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :wikis, dependent: :destroy
end
