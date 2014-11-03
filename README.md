RoomORama
=========

### Project Environment SetUp
    We need to install following gem before going run rspec test:
    1. gem install rspec
    2. gem install webmock

## Rspec Test Run
   Change to project Directory and then run bellow command:

   rspec spec/

## Getting started
    To check the logic of hash parsing that was given as #1 Task, you need to follow bellow command:

    require "#{Dir.pwd}/room_o_r_ama.rb"

    json_str, mappings, url, header = TestData.dummy
    room = RoomORama::Room.new(json_str, mappings, url, header)
    puts room.reform_hash

    TO send the request to the desired url with the properties that was given in Task #2,

    I provided fetch instance action to call the api where the required(orderly) parameter for creation of class are:

    1. json string
    2. url
    3. mappings as a hash
    4. header as a hash

    For Example:

    require "#{Dir.pwd}/room_o_r_ama.rb"

    json_str = "{\"properties\":[{\"property_adress\":\"72 Central Park W\",\"apartment_no\":\"7\",\"zip_code\":\"8002\",\"town\":\"Zurich\",\"country\":\"Swiss\",\"property_description\":\"fake description of the property\",\"bedrooms_no\":\"1\",\"max_people\":\"2\",\"source_id\":\"68123\"}]}"
    url = 'www.example.com/api/v1'
    mappings = {
            'properties' => 'room', 'property_adress' => 'adress',
            'apartment_no' => 'apartment_number', 'zip_code' => 'postal_code',
            'town' => 'city', 'property_description' => 'description',
            'bedrooms_no' => 'number_of_bedrooms', 'max_people' => 'max_guests',
            'source_id' => 'internal_id'
    }
    header = {'Authorization' => 'secrete1988'}

    room = RoomORama::Room.new(json_str, mappings, url, header)
    puts room.fetch