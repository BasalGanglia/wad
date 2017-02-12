require 'rails_helper'


include Helpers

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
 # let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
 # let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end


  it "create new beer" do
    visit new_beer_path
  #  select('iso 3', from:'rating[beer_id]')
    fill_in('Name', with:'test_beer')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "create invalid beer" do
      visit new_beer_path
      fill_in('Name', with:'')
          click_button "Create Beer"
            
    expect(page).to have_content 'be blank'
end
end