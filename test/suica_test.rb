require 'minitest/autorun'
require './lib/suica'

class SuicaTest < Minitest::Test
  def test_step_0_100円以上の任意の金額をチャージできる
    assert_equal 100, Suica.new(100).balance
  end

  def test_step_0_100円未満の金額はチャージできない
    assert_nil Suica.new(99).balance
  end



  def test_step_0_現在のチャージ残高を取得する
    suica = Suica.new(100)
    suica.charge(100)
    assert_equal 200, suica.balance
  end

end
