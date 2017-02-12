class User < ActiveRecord::Base
    include RatingAverage

    has_secure_password
    validates :username, uniqueness: true
    validates :username, length: { minimum: 3,
maximum: 30}
    validates :password, format: {
        with: /.*(?=.{4,10})(?=.*\d)(?=.*[A-Z]).*/,
    }

    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings

    def favorite_beer
        return nil if ratings.empty?
        ratings.order(score: :desc).limit(1).first.beer
    end

end
