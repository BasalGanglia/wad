require 'rails_helper'


include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end


  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)  
  end

  it "check ratings page rocks" do
      FactoryGirl.create(:rating)
      FactoryGirl.create(:rating)
      FactoryGirl.create(:rating)
      visit ratings_path
     expect(page).to have_content 'Number of ratings 3'
     end

      it "sees only their own ratings" do

         FactoryGirl.create(:rating) # create random rating for shit and giggle, for sturdy nipples
         visit user_path(user)
         expect(page).to have_content 'beer has not yet been rated'
         # rate as this user ?

          visit new_rating_path
         select('Karhu', from:'rating[beer_id]')
           fill_in('rating[score]', with:'23')
           click_button "Create Rating"
          visit user_path(user)

            expect(page).to have_content 'Karhu 23'
    end

    it "deletion of ratings work" do

        visit new_rating_path
         select('Karhu', from:'rating[beer_id]')
           fill_in('rating[score]', with:'23')
           click_button "Create Rating"
 visit new_rating_path
            select('iso 3', from:'rating[beer_id]')
           fill_in('rating[score]', with:'15')
           click_button "Create Rating"
    
           
        visit user_path(user)
#save_and_open_page

    end
end