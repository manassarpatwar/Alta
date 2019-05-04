require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'sqlite3'
require_relative 'methods.rb'

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
    $db = SQLite3::Database.new 'taxi_test_db.sqlite'

    def test_Valid
        j_id = 1
        u_id = 1
        fdbk = "Testing valid feedback - minitests"
        rat = "4"
        assert_equal true, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_NilJID
        j_id = nil
        u_id = 1
        fdbk = "Testing valid feedback - minitests"
        rat = "4"
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_NilUID
        j_id = 1
        u_id = nil
        fdbk = "Testing valid feedback - minitests"
        rat = "4"
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_NilFdbk
        j_id = 1
        u_id = 1
        fdbk = nil
        rat = "4"
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_NilRat
        j_id = 1
        u_id = 1
        fdbk = "Testing valid feedback - minitests"
        rat = nil
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_JIDnonPositiveNumber
        j_id = -1
        u_id = 1
        fdbk = "Testing valid feedback - minitests"
        rat = "3"
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_ratInteger
        j_id = 1
        u_id = 1
        fdbk = "Testing valid feedback - minitests"
        rat = 3
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_ratInvalid
        j_id = 1
        u_id = 1
        fdbk = "Testing valid feedback - minitests"
        rat = "7"
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_code
        j_id = 1
        u_id = 1
        fdbk = "return true"
        rat = "7"
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end
end

class TestGetTotalRides < Minitest::Test
    $db = SQLite3::Database.new 'taxi_db.sqlite'

    def test_noJourneys
        u_id = 1
        assert_equal 0, get_total_rides(u_id)
    end

    def test_1Journey
        u_id = 3301792117
        assert_equal 1, get_total_rides(u_id)
    end

    def test_2Journeys
        u_id = 1109074554515873792
        assert_equal 2, get_total_rides(u_id)
    end

    def test_nil
        u_id = nil
        assert_equal 0, get_total_rides(u_id)
    end

    def test_code
        u_id = "return 1"
        assert_equal 0, get_total_rides(u_id)
    end
end
