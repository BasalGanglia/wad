class BeerClub < ActiveRecord::Base

 # has_many :ratings, dependent: :destroy
  has_many :users, through: :Membership

end
