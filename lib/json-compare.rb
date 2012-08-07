require 'json-compare/version'
require 'json-compare/comparer'

module JsonCompare
  def self.get_diff(old, new)
    comparer = JsonCompare::Comparer.new
    comparer.compare_elements(old,new)
  end
end
