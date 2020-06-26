class Suica
  attr_accessor :balance

  def initialize
    @balance = 0
  end

  def deposit(money)
    @balance = money >= 100 ? @balance + money : @balance
  end
end
