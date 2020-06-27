# frozen_string_literal: true

require 'minitest/autorun'
require './lib/drink'

class DrinkTest < Minitest::Test
  def test_step_1_コーラの情報を取得する
    drink = Drink.cola
    assert_equal 'コーラ', drink.name
    assert_equal 120, drink.price
  end
end
