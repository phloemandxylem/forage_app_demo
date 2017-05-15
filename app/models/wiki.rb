class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, length: { minimum: 5 } , presence: true
  validates :body,  length: { minimum: 20 }, presence: true

  #Will_paginate records per page
  #self.per_page = 2

  scope :public_wikis, -> {where(private: false)}
  # scope :private_wikis, -> {where(user_id: current_user.id)}
  scope :ordered, -> {order("created_at DESC")}
  scope :visible_to, -> (user) { user.admin? ? all : where("user_id = ? OR private = ?", user.id, false) }
  # def self.visible_to(user)
  #   user.admin? ? all : (public_wikis + user.wikis).uniq
  # end

end
