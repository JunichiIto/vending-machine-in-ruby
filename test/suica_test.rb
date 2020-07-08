require 'minitest/autorun'
require './lib/suica'

class SuicaTest < Minitest::Test
  def test_step_0_100円以上の任意の金額をチャージできる
    assert_equal 100, Suica.new(100, 18, 2).balance
  end

  def test_step_0_100円未満の金額はチャージできない
    assert_nil Suica.new(99, 18, 2).balance
  end

  def test_step_0_現在のチャージ残高を取得する
    suica = Suica.new(100, 18, 2)
    suica.charge(100)
    assert_equal 200, suica.balance
  end

  def test_step_4_Suicaは利用者の年齢と性別を保存・取得できる
    suica = Suica.new(100, 18, 2)
    assert_equal 100, suica.balance
    assert_equal 18, suica.user_age
    assert_equal 2, suica.user_sex
  end
end
