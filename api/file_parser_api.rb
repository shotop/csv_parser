require 'grape'
require_relative '../lib/formatter.rb'
require_relative '../lib/csv_preprocessor.rb'
require_relative '../lib/csv_combiner.rb'


class FileParserAPI < Grape::API
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

  post :records do
    CSVCombiner.new.add_row_to_master(params[:data])
  end
end
