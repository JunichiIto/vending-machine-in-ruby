class Suica
  attr_accessor :balance

  def initialize(money)
    @balance = money
  end

  def deposit(money)
    @balance = money >= 100 ? @balance + money : @balance
  end
end
