require "rails_helper"

RSpec.describe "Vendors Show Page" do
  describe "When I visit 'vendors/:id'" do
    # As a visitor
    # When I visit a vendor's show page 'vendors/:id'
    # I see that vendor's name, contact information, whether they accept credit, and a description of what they sell

    it "show the vendors name, contact info, whether they accept credit, and a description of what they sell" do
      json_response = File.read("spec/fixtures/vendors/14&U_vendors.json")

      stub_request(:get, "http://localhost:3000/api/v0/vendors/55823").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.12'
           }).
         to_return(status: 200, body: json_response, headers: {})

         visit "/vendors/55823"

         expect(page).to have_content("The Charcuterie Corner")
         expect(page).to have_content("Contact Name: Claudie Langworth III")
         expect(page).to have_content("Contact Phone: 1-147-179-9747")
         expect(page).to have_content("Credit Accepted: false")
         expect(page).to have_content("Description: Vendor selling a variety of artisanal cured meats and sausages.")
    end
  end
end