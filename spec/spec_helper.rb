$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/..')
$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'rspec'
require 'yajl'
require 'json-compare'
