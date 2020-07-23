require 'minitest/autorun'
require './lib/suica'

class SuicaTest < Minitest::Test
  def test_step_0_100円以上の任意の金額をチャージできる
    suica = Suica.new(18, :female)
    assert_equal 100, suica.charge(100)
  end

  def test_step_0_100円未満の金額はチャージできない
    suica = Suica.new(18, :female)
    e = assert_raises ArgumentError do
      suica.charge(99)
    end

    assert_equal "moneyは100円以上の金額を指定してください", e.message
  end

  def test_step_0_現在のチャージ残高を取得する
    suica = Suica.new(18, :female)
    suica.charge(200)
    assert_equal 200, suica.balance
  end

  def test_step_4_Suicaは利用者の年齢と性別を保存・取得できる
    suica = Suica.new(18, :female)
    assert_equal 0, suica.balance
    assert_equal 18, suica.user_age
    assert_equal :female, suica.user_sex
  end
end
