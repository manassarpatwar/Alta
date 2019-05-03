require 'minitest/autorun'
require 'sqlite3'
require_relative 'methods.rb'

$db = SQLite3::Database.new 'taxi_db.sqlite'

class TestIsPositiveNumber < Minitest::Test
    def test_string
        assert_equal false, isPositiveNumber?("string")
    end

    def test_integerPos
        assert_equal true, isPositiveNumber?(1)
    end

    def test_integerNeg
        assert_equal false, isPositiveNumber?(-1)
    end

    def test_boolean
        assert_equal false, isPositiveNumber?(true)
    end

    def test_double
        assert_equal true, isPositiveNumber?(2.2)
    end

    def test_largeNumber
        assert_equal true, isPositiveNumber?("329929299100000494994949402929")
    end

    def test_smallNumber
        assert_equal false, isPositiveNumber?("-329929299100000494994949402929")
    end

    def test_smallDecimal
        assert_equal true, isPositiveNumber?("0.00000000000000000000000000009")
    end

    def test_nil
        assert_equal false, isPositiveNumber?(nil)
    end

    def test_emojis
        assert_equal false, isPositiveNumber?("😀")
    end

    def test_programCode
        assert_equal false, isPositiveNumber?("return true")
    end
end

class TestAddFeedback < Minitest::Test
    def test_Valid
        j_id = 1
        u_id = 1
        fdbk = "Testing valid feedback - minitests"
        rat = "4"
        assert_equal true, add_feedback(j_id, u_id, fdbk, rat)
    end
end
