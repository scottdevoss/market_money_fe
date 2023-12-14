require "rails_helper"

RSpec.describe "Markets Index" do
  describe "When I visit /markets" do
    # As a visitor,
    # When I visit '/markets'
    # I see all markets listed with their name, city and state
    # When I click a button to see more info on that market
    # I'm taken to that market's show page '/markets/:id'
    it "shows all markets listed with their name, city and state. When I click more info, I am taken to the markets show page /markets/:id" do
      
      json_response = File.read("spec/fixtures/markets/markets.json")
      
      stub_request(:get, "http://localhost:3000/api/v0/markets").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.12'
           }).
         to_return(status: 200, body: json_response, headers: {})
      
      
      visit "/markets"

      expect(page).to have_content("Markets")
      expect(page).to have_content("Name")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("14&U Farmers' Market")
      expect(page).to have_content("Washington")
      expect(page).to have_content("District of Columbia")

      expect(page).to have_content("2nd Street Farmers' Market")
      expect(page).to have_content("Amherst")
      expect(page).to have_content("Virginia")
    end 

    xit "has a button to go to the markets show page" do
      visit "/markets"

      within('#market-1') do
        expect(page).to have_button("More Info")
      end

      within('#market-2') do
        expect(page).to have_button("More Info")

        click_button 'More Info'

        expect(current_path).to eq("/markets/#{params[:id]}")
      end 
    end
  end
end