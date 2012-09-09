require 'json-compare/version'
require 'json-compare/comparer'

module JsonCompare
  def self.get_diff(old, new, exclusion = [])
    comparer = JsonCompare::Comparer.new
    comparer.excluded_keys = exclusion
    comparer.compare_elements(old,new)
  end
end
