class Suica
  attr_accessor :balance

  def initialize(money)
    @balance = money >= 100 ? money : nil
  end

  def charge(money)
    return nil if money < 100
    @balance += money
  end

  def withdraw(money)
    @balance -= money
  end
end
