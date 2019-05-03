require 'minitest/autorun'
require_relative 'methods.rb'

class TestIsPositiveNumber < Minitest::Test
    def test_nonNumber
        assert_equal false, isPositiveNumber?("string")
    end
end
