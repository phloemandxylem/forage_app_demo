class Location < ActiveRecord::Base
  validates :latitude, :longitude, presence: true
  validates :latitude, :longitude, numericality: true

end
