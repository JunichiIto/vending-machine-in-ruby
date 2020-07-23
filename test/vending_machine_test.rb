require 'minitest/autorun'
require './lib/vending_machine'

class VendingMachineTest < Minitest::Test
  def test_step_1
    machine = VendingMachine.new
    expected = [
      {name: 'コーラ', price: 120, stock: 5},
      {name: 'レッドブル', price: 200, stock: 5},
      {name: '水', price: 100, stock: 5}
    ]
    assert_equal expected, machine.current_stocks
  end

  def test_step_2_在庫があるか確認する
    machine = VendingMachine.new
    assert machine.stock_available?('コーラ')
  end

  def test_step_2_Suicaで購入する
    machine = VendingMachine.new
    suica = Suica.new(18, :female)
    suica.charge(120)
    drink = machine.purchase('コーラ', suica)
    assert_equal 'コーラ', drink.name
    expected = [
      {name: "コーラ", price: 120, stock: 4},
      {name: "レッドブル", price: 200, stock: 5},
      {name: "水", price: 100, stock: 5}
    ]
    assert_equal expected, machine.current_stocks
    assert_equal 120, machine.sales_amount
    assert_equal 0, suica.balance
  end

  def test_step_2_チャージ残高が足りない場合
    machine = VendingMachine.new
    assert machine.stock_available?('コーラ')
    suica = Suica.new(18, :female)
    suica.charge(119)
    drink = machine.purchase('コーラ', suica)
    assert_nil drink
    expected = [
      {name: "コーラ", price: 120, stock: 5},
      {name: "レッドブル", price: 200, stock: 5},
      {name: "水", price: 100, stock: 5}
    ]
    assert_equal expected, machine.current_stocks
    assert_equal 0, machine.sales_amount
    assert_equal 119, suica.balance
  end

  def test_step_2_在庫が足りない場合
    machine = VendingMachine.new
    assert machine.stock_available?('コーラ')
    suica = Suica.new(18, :female)
    suica.charge(10000)
    machine.purchase('コーラ', suica)
    machine.purchase('コーラ', suica)
    machine.purchase('コーラ', suica)
    machine.purchase('コーラ', suica)
    assert machine.stock_available?('コーラ')
    machine.purchase('コーラ', suica)
    refute machine.stock_available?('コーラ')
    assert_nil machine.purchase('コーラ', suica)
    assert_equal 9400, suica.balance
    assert_equal 600, machine.sales_amount
    expected = [
      {name: "レッドブル", price: 200, stock: 5},
      {name: "水", price: 100, stock: 5}
    ]
    assert_equal expected, machine.current_stocks
  end

  def test_step_3_在庫の点で購入可能なドリンクのリストを取得する
    machine = VendingMachine.new
    expected = ['コーラ', 'レッドブル', '水']
    assert_equal expected, machine.stock_available_lists
  end

  def test_step_3_Suicaでレッドブルを購入する
    machine = VendingMachine.new
    suica = Suica.new(18, :female)
    suica.charge(200)
    drink = machine.purchase('レッドブル', suica)
    assert_equal 'レッドブル', drink.name
    expected = [
      {name: "コーラ", price: 120, stock: 5},
      {name: "レッドブル", price: 200, stock: 4},
      {name: "水", price: 100, stock: 5}
    ]
    assert_equal expected, machine.current_stocks
    assert_equal 200, machine.sales_amount
    assert_equal 0, suica.balance
  end

  def test_step_3_Suicaで水を購入する
    machine = VendingMachine.new
    suica = Suica.new(18, :female)
    suica.charge(100)
    drink = machine.purchase('水', suica)
    assert_equal '水', drink.name
    expected = [
      {name: "コーラ", price: 120, stock: 5},
      {name: "レッドブル", price: 200, stock: 5},
      {name: "水", price: 100, stock: 4}
    ]
    assert_equal expected, machine.current_stocks
    assert_equal 100, machine.sales_amount
    assert_equal 0, suica.balance
  end

  def test_step_5_購入時に販売日時、年齢、性別を保存する
    machine = VendingMachine.new
    suica = Suica.new(18, :female)
    suica.charge(100)
    time = Time.now
    machine.purchase('水', suica)
    history = machine.purchase_histories[0]
    assert_equal '水', history[:name]
    assert (time..Time.now).include?(history[:time])
    assert_equal 18, history[:user_age]
    assert_equal :female, history[:user_sex]
  end

  def test_step_5_ジュース名を渡すと販売履歴を取得できる
    machine = VendingMachine.new
    suica1 = Suica.new(18, :female)
    suica1.charge(100)
    suica2 = Suica.new(20, :male)
    suica2.charge(300)
    time0 = Time.now
    machine.purchase('水', suica1)
    time1 = Time.now
    machine.purchase('水', suica2)
    time2 = Time.now
    machine.purchase('レッドブル', suica2)
    # 水の購入履歴[0]
    history0 = machine.find_purchase_histories('水')[0]
    assert_equal '水', history0[:name]
    assert (time0..Time.now).include?(history0[:time])
    assert_equal 18, history0[:user_age]
    assert_equal :female, history0[:user_sex]
    # 水の購入履歴[1]
    history1 = machine.find_purchase_histories('水')[1]
    assert_equal '水', history1[:name]
    assert (time1..Time.now).include?(history1[:time])
    assert_equal 20, history1[:user_age]
    assert_equal :male, history1[:user_sex]
    # レッドブルの購入履歴[0]
    history2 = machine.find_purchase_histories('レッドブル')[0]
    assert_equal 'レッドブル', history2[:name]
    assert (time2..Time.now).include?(history2[:time])
    assert_equal 20, history2[:user_age]
    assert_equal :male, history2[:user_sex]
  end
end
