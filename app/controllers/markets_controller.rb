class MarketsController < ApplicationController
  def index
    response = Faraday.get("http://localhost:3000/api/v0/markets")
    @data = JSON.parse(response.body, symbolize_names: true)
  end

  def show
    market_id = params[:id]
    
    response = Faraday.get("http://localhost:3000/api/v0/markets/#{market_id}")
    @data = JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry
    vendor_response = Faraday.get("http://localhost:3000/api/v0/markets/#{market_id}/vendors")
    @vendor_data = JSON.parse(vendor_response.body, symbolize_names: true)
  end
end