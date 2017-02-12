require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){FactoryGirl.create(:user)}

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
      end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
      end
    end

  # describe "with a proper password" do
  #   let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }

  #   it "is saved" do
  #     expect(user).to be_valid
  #     expect(User.count).to eq(1)
  #   end

  #   it "and with two ratings, has the correct average rating" do
  #     rating = Rating.new score:10
  #     rating2 = Rating.new score:20

  #     user.ratings << rating
  #     user.ratings << rating2

  #     expect(user.ratings.count).to eq(2)
  #     expect(user.average_rating).to eq(15.0)
  #   end
  # end

  describe "with a improper password" do
    let(:user){User.create username:"Pekka", password:"sec", password_confirmation:"sec"}

    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0) 
    end  
  end

    describe "with a password containing only letters" do
    let(:user){User.create username:"Pekka", password:"secsec", password_confirmation:"secsec"}

    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0) 
    end  
  end

  describe "favorite beer" do 
    let(:user){FactoryGirl.create(:user)}

      it "has method for determining the favorite_beer" do
        expect(user).to respond_to(:favorite_beer)
        end

      it "without ratings does not have a favorite beer" do
        expect(user.favorite_beer).to eq(nil)
        end

        it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      end

      it "is the only rated if only one rating" do
        beer = FactoryGirl.create(:beer)
        rating = FactoryGirl.create(:rating, beer:beer, user:user)

        expect(user.favorite_beer).to eq(beer)
        end

    # it "is the one with highest rating if several rated" do
    #   beer1 = FactoryGirl.create(:beer)
    #   beer2 = FactoryGirl.create(:beer)
    #   beer3 = FactoryGirl.create(:beer)
    #   rating1 = FactoryGirl.create(:rating, beer:beer1, user:user)
    #   rating2 = FactoryGirl.create(:rating, score:25,  beer:beer2, user:user)
    #   rating3 = FactoryGirl.create(:rating, score:9, beer:beer3, user:user)

    #   expect(user.favorite_beer).to eq(beer2)
    # end

        it "is the one with highest rating if several rated" do
      create_beer_with_rating(user, 10)
      best = create_beer_with_rating(user, 25)
      create_beer_with_rating(user, 7)

      expect(user.favorite_beer).to eq(best)
    end


    end
end

def create_beer_with_rating(user,score)
   beer = FactoryGirl.create(:beer)
   FactoryGirl.create(:rating, score:score, beer:beer, user:user)
   beer
   end

   def create_beers_with_ratings(user, *scores)
  scores.each do |score|
    create_beer_with_rating(user, score)
  end
end