require 'minitest/autorun'
require_relative 'app.rb'

class TestIsPositiveNumber < Minitest::Test
    def test_nonNumber
        assert_equal false, isPositiveNumber?("string")
    end
end
