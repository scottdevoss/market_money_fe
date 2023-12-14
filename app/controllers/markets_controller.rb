class MarketsController < ApplicationController
  def index
    response = Faraday.get("http://localhost:3000/api/v0/markets")
    @data = JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry
  end
end