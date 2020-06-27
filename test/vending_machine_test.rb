require 'minitest/autorun'
require './lib/vending_machine'

class VendingMachineTest < Minitest::Test
  def test_step_1
    machine = VendingMachine.new
    expected = [
      {
        name: 'コーラ',
        price: 120,
        stock: 5,
      }
    ]
    assert_equal expected, machine.current_stocks
  end
end
