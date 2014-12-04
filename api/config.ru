require 'grape'
require 'rack'
require 'rack/server'
require '../lib/formatter.rb'

class API < Grape::API
  format :json
  default_format :json

  resources :records do
    get :gender do
      Formatter.to_json
    end

    get :birthdate do
      Formatter.to_json
    end

    get :name do
      Formatter.to_json
    end
  end
end


run API