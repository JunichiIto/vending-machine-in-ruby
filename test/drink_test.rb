# frozen_string_literal: true

require 'minitest/autorun'
require './lib/drink'

class DrinkTest < Minitest::Test
  def test_step_1_コーラの情報を取得する
    drink = Drink.cola
    assert_equal 'コーラ', drink.name
    assert_equal 120, drink.price
  end

  def test_step_3_レッドブルの情報を取得する
    drink = Drink.redbull
    assert_equal 'レッドブル', drink.name
    assert_equal 200, drink.price
  end

  def test_step_3_水の情報を取得する
    drink = Drink.water
    assert_equal '水', drink.name
    assert_equal 100, drink.price
  end
end
