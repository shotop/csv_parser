# CLI Usage
ruby csv_parser.rb file_1 file_2 file_3

# API
cd csv_parser/api
rackup

# Examples
## Example data files located in /data

ruby csv_parser.rb data/CommaExampleData data/SpaceExampleData data/PipeExampleData

## Example post to Grape API

"curl -d '{"data": "Smith|Andrea|Female|Blue|02/25/1983"}' 'http://localhost:9292/records' -H Content-Type:application/json -v"