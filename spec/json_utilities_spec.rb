require_relative 'spec_helper'
require_relative '../room_o_r_ama'
require_relative '../json_utilities'
require_relative '../test_data'

describe JsonUtilities do
  context '#make_hash' do
    before do
      json_str, mappings, url, header = TestData.dummy
      @room_obj = RoomORama::Room.new(json_str, mappings, url, header)
    end

    it 'should remake hash' do
      reformated_hash = {'room' => [{'adress' => '72 Central Park W', 'apartment_number' => '7', 'postal_code' => '8002',
                                     'city' => 'Zurich', 'country' => 'Swiss', 'description' => 'fake description of the property',
                                     'number_of_bedrooms' => '1', 'max_guests' => '2', 'internal_id' => '68123'
                                    }]
      }
      @room_obj.make_hash == reformated_hash
    end
  end

  context '#make_hash' do
    before do
      json_str, mappings, url, header = TestData.dummy
      @room_obj = RoomORama::Room.new(json_str, {}, url, header)
    end

    it 'should return original hash for empty mappings hash' do
      @room_obj.make_hash.should eq(@room_obj.properties)
    end
  end

  context '#process_array' do
    before do
      json_str, mappings, url, header = TestData.dummy
      @room_obj = RoomORama::Room.new(json_str, mappings, url, header)
    end

    it 'should return original array of hash for mappings hash' do
      mappings = {'property_adress' => 'adress', 'apartment_no' => 'apartment_number', 'zip_code' => 'postal_code'}
      original_ary = [{'property_adress' => '72 Central Park W', 'apartment_no' => '7', 'zip_code' => '8002', 'city' => 'Zurich', 'country' => 'Swiss'}]
      @room_obj.process_array(original_ary, mappings).should eq([{'adress' => '72 Central Park W', 'apartment_number' => '7', 'postal_code' => '8002', 'city' => 'Zurich', 'country' => 'Swiss'}])
    end

    it 'should return empty array for mappings hash' do
      mappings = {'property_adress' => 'adress', 'apartment_no' => 'apartment_number', 'zip_code' => 'postal_code'}
      original_ary = []
      @room_obj.process_array(original_ary, mappings).should eq([])
    end

    it 'should return original array of hash  for empty mappings hash' do
      mappings = {}
      original_ary = [{'property_adress' => '72 Central Park W', 'apartment_no' => '7', 'zip_code' => '8002', 'city' => 'Zurich', 'country' => 'Swiss'}]
      @room_obj.process_array(original_ary, mappings).should eq(original_ary)
    end
  end

  context '#map_key' do
    before do
      json_str, mappings, url, header = TestData.dummy
      @room_obj = RoomORama::Room.new(json_str, mappings, url, header)
      @mapping_hash = {'test' => 'one'}
    end

    it 'should return original hash key for mappings hash' do
      key = 'live'
      @room_obj.map_key(key, @mapping_hash).should eq(key)
    end

    it 'should return modified hash key for mappings hash key map' do
      key = 'one'
      @room_obj.map_key(key, @mapping_hash).should eq(key)
    end
  end

  context '#rename_hash_key' do
    before do
      json_str, mappings, url, header = TestData.dummy
      @room_obj = RoomORama::Room.new(json_str, mappings, url, header)
      @mapping_hash = {'test' => 'one'}
    end

    it 'should return renamed key hash for mappings hash' do
      original_hash = {'test' => 'two'}
      resultant_hash = {'one' => 'two'}
      @room_obj.rename_hash_key(original_hash, @mapping_hash).should eq(resultant_hash)
    end

    it 'should return original hash for mappings hash' do
      original_hash = {'one' => 'two'}
      @room_obj.rename_hash_key(original_hash, @mapping_hash).should eq(original_hash)
    end
  end
end