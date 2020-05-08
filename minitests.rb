require 'simplecov'
require 'minitest/autorun'
require 'pg'
require_relative 'app/methods.rb'

$db = PG.connect(dbname: 'taxitestdb');

# testing the isPositiveNumber method
class TestIsPositiveNumber < Minitest::Test
    def test_string
        assert_equal false, isPositiveNumber?('string')
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
        assert_equal true, isPositiveNumber?('329929299100000494994949402929')
    end

    def test_smallNumber
        assert_equal false, isPositiveNumber?('-329929299100000494994949402929')
    end

    def test_smallDecimal
        assert_equal true, isPositiveNumber?('0.00000000000000000000000000009')
    end

    def test_nil
        assert_equal false, isPositiveNumber?(nil)
    end

    def test_emojis
        assert_equal false, isPositiveNumber?('😀')
    end

    def test_programCode
        assert_equal false, isPositiveNumber?('return true')
    end
end

# testing the add_feedback method
class TestAddFeedback < Minitest::Test
    def test_Valid
        j_id = 1
        u_id = 1
        fdbk = 'Testing valid feedback - minitests'
        rat = '4'
        assert_equal true, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_NilJID
        j_id = nil
        u_id = 1
        fdbk = 'Testing valid feedback - minitests'
        rat = '4'
        assert_equal true, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_NilUID
        j_id = 1
        u_id = nil
        fdbk = 'Testing valid feedback - minitests'
        rat = '4'
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_NilFdbk
        j_id = 1
        u_id = 1
        fdbk = nil
        rat = '4'
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_NilRat
        j_id = 1
        u_id = 1
        fdbk = 'Testing valid feedback - minitests'
        rat = nil
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_JIDnonPositiveNumber
        j_id = -1
        u_id = 1
        fdbk = 'Testing valid feedback - minitests'
        rat = '3'
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_ratInteger
        j_id = 1
        u_id = 1
        fdbk = 'Testing valid feedback - minitests'
        rat = 3
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_ratInvalid
        j_id = 1
        u_id = 1
        fdbk = 'Testing valid feedback - minitests'
        rat = '7'
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end

    def test_code
        j_id = 1
        u_id = 1
        fdbk = 'return true'
        rat = '7'
        assert_equal false, add_feedback(j_id, u_id, fdbk, rat)
    end
end

# testing the get_total_rides method
class TestGetTotalRides < Minitest::Test
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
        u_id = 'return 1'
        assert_equal 0, get_total_rides(u_id)
    end
end


# testing the get_entry method
class TestGetEntry < Minitest::Test
    def test_users
        user = ['1092444312430919681', 'ise19team29', '2019/03/13 10:54', 1, 100000]
        table = 'users'
        id = '1092444312430919681'
        assert_equal user, get_entry(id, table)
    end

    def test_taxis
        taxi = [0, 'IO17 MFE', '07500090833', 'S', 'SHEFFIELD', 0]
        table = 'taxis'
        id = 0
        assert_equal taxi, get_entry(id, table)
    end

    def test_feedback
        feedback = [0, nil, '1105505463234379778', '2019/03/29 17:11', 'This is one of the greatest taxi services that I have ever used. Would higly recommend the L type taxi. It is the best when compared to other services.', 5]
        table = 'feedback'
        id = 0
        assert_equal feedback, get_entry(id, table)
    end

    def test_journeys
        journey = [0, 0, '1105505463234379778', 'TomTonner3', '2019/03/08 12:34', 'Endcliffe', 'Diamond', 0, 0, 5, 'https://twitter.com/testinglinks']
        table = 'journeys'
        id = 0
        assert_equal journey, get_entry(id, table)
    end

    def test_invalid_table
        user = ['1092444312430919681', 'ise19team29', '2019/03/13 10:54', 1, 100000]
        table = 'user'
        id = '1092444312430919681'
        assert_nil nil, get_entry(id, table)
    end

    def test_invalid_id
        user = ['1092444312430919681', 'ise19team29', '2019/03/13 10:54', 1, 100000]
        table = 'users'
        id = '0'
        assert_nil nil, get_entry(id, table)
    end
end


# testing the get_data method
class TestGetData < Minitest::Test
    def test_users_13_03_2019
        answer = Hash.new()
        date = Array.new()

        answer['2019/03/13'] = 2

        table = 'users'
        column = 'signup_date'
        date.push('2019/03/13')

        assert_equal answer,  get_data(table, column, date)
    end

    def test_journeys_26_03_2019
        answer = Hash.new()
        date = Array.new()
        answer['2019/03/26'] = 2

        table = 'journeys'
        column = 'date_time'
        date.push('2019/03/26')

        assert_equal answer,  get_data(table, column, date)
    end

    def test_feedback_22_04_2019
        answer = Hash.new()
        date = Array.new()
        answer['2019/04/22'] = 7

        table = 'feedback'
        column = 'date_time'
        date.push('2019/04/22')

        assert_equal answer,  get_data(table, column, date)
    end

    def test_invalid_date
        answer = Hash.new()
        date = Array.new()
        answer['04/2019'] = 0

        table = 'users'
        column = 'signup_date'
        date.push('04/2019')

        assert_equal answer,  get_data(table, column, date)
    end

    def test_invalid_table
        answer = Hash.new()
        date = Array.new()

        answer['2019/03/13'] = 0

        table = 'user'
        column = 'signup_date'
        date.push('2019/03/13')

        assert_equal answer,  get_data(table, column, date)
    end

    def test_invalid_column
        answer = Hash.new()
        date = Array.new()

        answer['2019/03/13'] = 0

        table = 'users'
        column = 'test'
        date.push('2019/03/13')

        assert_equal answer,  get_data(table, column, date)
    end

    def test_code
        answer = Hash.new()
        date = Array.new()

        answer['2019/03/13'] = 0

        table = 'return 0'
        column = 'signup_date'
        date.push('2019/03/13')

        assert_equal answer,  get_data(table, column, date)
    end
end

# testing the get_data method
class TestGatherTaxis < Minitest::Test
    def test_valid_sheffield
        taxi0 = [0, 'IO17 MFE', '07500090833', 'S', 'SHEFFIELD', 0]
        taxi3 = [3, 'YO08 PDR', '07441369588', 'L', 'SHEFFIELD', 1]
        taxi4 = [4, 'MN16 TKS', '07125654899', 'M', 'SHEFFIELD', 1]
        taxi5 = [5, 'AL57 WVH', '07125936955', 'L', 'SHEFFIELD', 1]
        taxi6 = [6, 'SH55 PSP', '07122458711', 'S', 'SHEFFIELD', 1]
        taxi7 = [7, 'HT18 TLE', '07458695823', 'S', 'SHEFFIELD', 1]

        answerAvaliable = [taxi3, taxi4, taxi5, taxi6, taxi7]
        answerUnavaliable = [taxi0]

        returnTaxis = answerAvaliable, answerUnavaliable

        city = 'SHEFFIELD'

        assert_equal returnTaxis, gather_taxis(city)
    end

    def test_valid_manchester
        taxi1 = [1, 'NG07 EDF', '07254123699', 'M', 'MANCHESTER', 0]
        taxi2 = [2, 'T58 THY', '07258152966', 'L', 'MANCHESTER', 1]
        taxi8 = [8, 'AQ12 TMT', '07458714652', 'L', 'MANCHESTER', 1]
        taxi9 = [9, 'NG09 REW', '07896235411', 'S', 'MANCHESTER', 1]
        taxi10 = [10, 'HT14 FDL', '07895463589', 'S', 'MANCHESTER', 1]

        answerAvaliable = [taxi2, taxi8, taxi9, taxi10]
        answerUnavaliable = [taxi1]

        returnTaxis = answerAvaliable, answerUnavaliable

        city = 'MANCHESTER'

        assert_equal returnTaxis, gather_taxis(city)
    end

    def test_invalid_city
        city = 'shef'
        assert_nil nil, gather_taxis(city)
    end
end
