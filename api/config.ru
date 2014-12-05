require 'grape'
require 'rack'
require 'rack/server'
require '../lib/formatter.rb'

class API < Grape::API
  format :json

  resources :records do
    get :gender do
      Formatter.format_for_json("sort_by_gender_then_last_name_asc")
    end

    get :birthdate do
      Formatter.format_for_json("sort_by_date_asc")
    end

    get :name do
      Formatter.format_for_json("sort_by_last_name_desc")
    end
  end
end

run API