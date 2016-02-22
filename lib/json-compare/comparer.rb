module JsonCompare
  class Comparer

    attr_accessor :excluded_keys, :matching_key

    def is_boolean(obj)
      !!obj == obj
    end

    def compare_elements(old, new)
      diff = {}
      if old.kind_of? Hash
        if new.kind_of? Array
          diff_hash = compare_hash_array(old, new)
        else
          diff_hash = compare_hashes(old, new)
        end
        diff = diff_hash if diff_hash.count > 0
      elsif (!is_boolean(old) || !is_boolean(new)) && old.class != new.class
        diff = new
      elsif old.kind_of? Array
        diff_arr = compare_arrays(old, new)
        diff = diff_arr if diff_arr.count > 0
      else
        string_diff = compare_strings(old, new)
        diff = string_diff unless string_diff.nil?
      end
      diff
    end

    def compare_hashes(old_hash, new_hash)
      old_hash = old_hash == nil ? {} : old_hash
      new_hash = new_hash == nil ? {} : new_hash
      keys = (old_hash.keys + new_hash.keys).uniq
      result = get_diffs_struct
      keys.each do |k|
        if !old_hash.has_key? k
          result[:append][k] = new_hash[k]
        elsif !new_hash.has_key? k
          result[:remove][k] = old_hash[k]
        else
          diff = compare_elements(old_hash[k], new_hash[k])
          if diff.respond_to? "empty?"
            result[:update][k] = diff unless diff.empty?
          else
            result[:update][k] = diff # some classes have no empty? method
          end
        end
      end
      filter_results(result)
    end

    def compare_arrays(old_array, new_array)
      has_comparing_way = !matching_key.nil?
      result = get_diffs_struct
      new_array_index = 0
      new_array_length = new_array.count

      old_array.each_with_index do |elem, index|
        number = (new_array_index...new_array_length).detect do |n|
          !(
            has_comparing_way &&
            elem.kind_of?(Hash) && elem.has_key?(matching_key) &&
            new_array[n].kind_of?(Hash) && new_array[n].has_key?(matching_key)
          ) || new_array[n][matching_key] == elem[matching_key]
        end

        if number
          res = compare_elements(elem, new_array[number])
          result[:update][index] = res unless (res.nil? || (res.respond_to?(:empty?) && res.empty?))
          (new_array_index...number).each do |n|
            result[:append][n] = new_array[n]
          end
          new_array_index = number + 1
        else
          result[:remove][index] = elem
        end
      end

      (new_array_index...new_array_length).each do |n|
        result[:append][n] = new_array[n]
      end

      filter_results(result)
    end

    def compare_hash_array(old_hash, new_array)
      result = get_diffs_struct

      (0...new_array.count).map do |n|
        next if new_array[n].nil?
        if n == 0
          res = compare_elements(old_hash, new_array[0])
          result[:update][n] = res unless res.empty?
        else
          result[:append][n] = new_array[n]
        end
      end

      filter_results(result)
    end

    def compare_strings(old_string, new_string)
      (old_string != new_string) ? new_string.to_s : ""
    end

    # Returns diffs-hash with bare structure
    def get_diffs_struct
      {:append => {}, :remove => {},:update => {}}
    end

    def filter_results(result)
      return {} if result.nil?
      out_result = {}
      result.each_key do |change_type|
        next if result[change_type].nil?
        temp_hash = {}
        result[change_type].each_key do |key|
          next if result[change_type][key].nil?
          next if @excluded_keys.include? key
          temp_hash[key] = result[change_type][key]
        end
        out_result[change_type] = temp_hash if temp_hash.count > 0
      end
      out_result
    end
  end
end
