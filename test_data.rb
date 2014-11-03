class TestData
  def self.dummy
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
    return json_str, mappings,  url, header
  end
end