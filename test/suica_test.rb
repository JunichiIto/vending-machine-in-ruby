require 'minitest/autorun'
require './lib/suica'

class SuicaTest < Minitest::Test
  def setup
    @suica = Suica.new
  end

  def test_step_0_100円以上の任意の金額をチャージできる
    assert_equal 100, @suica.deposit(100)
  end

  def test_step_0_100円未満の金額はチャージできない
    assert_equal 0, @suica.deposit(99)
  end

  def test_step_0_現在のチャージ残高を取得する
    suica = Suica.new
    suica.deposit(200)
    assert_equal 200, suica.balance
  end

end
