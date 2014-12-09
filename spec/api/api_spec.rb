require 'spec_helper'

describe FileParserAPI do

  def app
    Rack::Builder.new do
      run FileParserAPI
    end.to_app
  end

  describe "API" do
    describe "GET /records/gender" do
      it "returns records sorted by gender first" do
        get "/records/gender"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)['Records'].length).to be > 1
      end
    end

    describe "GET /records/name" do
      it "returns records sorted by name" do
        get "/records/name"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)['Records'].length).to be > 1
      end
    end

    describe "GET /records/birthdate" do
      it "returns records sorted by birthdate" do
        get "/records/birthdate"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)['Records'].length).to be > 1
      end
    end

    describe "404 on bad resource" do
      it "returns a 404 when user requests non existent resource" do
        get "/records/reverb"
        expect(last_response.status).to eq(404)
      end
    end

    describe "POST /records" do
      it "posts to master records list" do
        post "/records", :data => "Smith|Andrea|Female|Blue|02/25/1983"
        expect(last_response.status).to eq(201)
      end
    end
  end
end