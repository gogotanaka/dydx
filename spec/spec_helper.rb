$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dydx'
require 'pry'

include Dydx

def assert_equal(output, input)
  eval "it { expect(#{input}).to eq(#{output}) }"
end
