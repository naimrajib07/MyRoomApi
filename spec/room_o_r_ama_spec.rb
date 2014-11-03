require_relative 'spec_helper'
require_relative '../room_o_r_ama'
require_relative '../test_data'

describe RoomORama::Room do
  before do
    json_str, mappings, url, header = TestData.dummy
    @room_obj = RoomORama::Room.new(json_str, mappings, url, header)
  end

  describe '#fetch' do
    context 'with url' do
      it 'request to api should success' do
        stub_request(:post, @room_obj.url).
            with(:headers => {'Authorization' => @room_obj.header['Authorization']}).to_return(:body => 'Success')

        @room_obj.fetch == 'Success'
      end
    end
  end

  describe '#reform_hash' do
    context 'mapping hash' do
      it 'reform the hash' do
        reformated_hash = {"room"=>[{"adress"=>"72 Central Park W", "apartment_number"=>"7", "postal_code"=>"8002", "city"=>"Zurich", "country"=>"Swiss", "description"=>"fake description of the property", "number_of_bedrooms"=>"1", "max_guests"=>"2", "internal_id"=>"68123"}]}
        @room_obj.reform_hash == reformated_hash
      end
    end
  end
end