require 'spec_helper'

describe "API" do
  include Rack::Test::Methods

  def app
    FileParser::API
  end

  describe "API" do
    describe "GET /records/gender" do
      it "returns records sorted by gender first" do
        get "/records/gender"
        expect(last_response.status).to eq(200)
      end
    end
  end
end