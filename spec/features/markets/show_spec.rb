require "rails_helper"

RSpec.describe "Markets Show Page" do
  describe "When I visit 'markets/:id'" do
    # As a visitor,
    # When I visit a market's show page 'markets/:id'
    # I see that market's name and readable address
    # And I also see a list of all the Vendors that are at that market
    # Each vendor name is a link to that vendor's show page

    it "shows the markets name and address" do
      json_response = File.read("spec/fixtures/markets/markets.json")
      
      stub_request(:get, "http://localhost:3000/api/v0/markets").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.12'
           }).
         to_return(status: 200, body: json_response, headers: {})

      json_response2 = File.read("spec/fixtures/markets/14&U_market.json")

      stub_request(:get, "http://localhost:3000/api/v0/markets/322458").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.12'
           }).
         to_return(status: 200, body: json_response2, headers: {})

      visit "/markets/322458"

      expect(page).to have_content("14&U Farmers' Market")
      expect(page).to have_content("1400 U Street NW ")
      expect(page).to have_content("Washington")
      expect(page).to have_content("District of Columbia")
      expect(page).to have_content("20009")
      # save_and_open_page
    end

    it "I also see a list of all the vendors that are at that market and they link to their showpage" do
      json_response = File.read("spec/fixtures/markets/markets.json")
      
      stub_request(:get, "http://localhost:3000/api/v0/markets").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.12'
           }).
         to_return(status: 200, body: json_response, headers: {})

      json_response2 = File.read("spec/fixtures/markets/14&U_market.json")

      stub_request(:get, "http://localhost:3000/api/v0/markets/322458").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.12'
           }).
         to_return(status: 200, body: json_response2, headers: {})

      json_response3 = File.read("spec/fixtures/vendors/14&U_vendors.json")

      stub_request(:get, "http://localhost:3000/api/v0/markets/322458/vendors").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.12'
           }).
         to_return(status: 200, body: json_response3, headers: {})

      visit "/markets/322458"
            
      expect(page).to have_link("The Charcuterie Corner")
      click_link("The Charcuterie Corner")

      expect(current_path).to eq("/vendors/55823")
    end
  end
end