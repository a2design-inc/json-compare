require 'json-compare/version'
require 'json-compare/comparer'

module JsonCompare
  def self.get_diff(old, new, options = {})
    if options.kind_of?(Array)
      options = {:excluded_keys => options}
    end
    comparer = JsonCompare::Comparer.new
    comparer.excluded_keys = options.delete(:excluded_keys) || []
    comparer.matching_key = options.delete(:matching_key)
    comparer.compare_elements(old,new)
  end
end
