module JsonUtilities
  def rename_hash_key(main_hash, mappings)
    Hash[main_hash.map {|k, v| [mappings[k]||k , v] }]
  end

  def map_key(key, mappings)
    mappings[key] || key
  end

  def process_array(ary, mappings)
    ary.collect do |element|
      element.kind_of?(Array) ? process_array(ary, mappings): rename_hash_key(element, mappings)
    end
  end

  def make_hash
    result = {}
    self.properties.each do |key, elem|
      renamed_key = map_key(key, self.mapping_hash)
      if elem.kind_of?(Hash)
        result.store(renamed_key, rename_hash_key(elem, self.mapping_hash))
      elsif elem.kind_of?(Array)
        result.store(renamed_key, process_array(elem, self.mapping_hash))
      end
    end
    result
  end
end