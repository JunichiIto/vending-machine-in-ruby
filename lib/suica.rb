class Suica
  attr_accessor :balance, :user_age, :user_sex

  def initialize(money, user_age, user_sex)
    @balance = money >= 100 ? money : nil
    @user_age = user_age
    @user_sex = user_sex # ISO 5218
  end

  def charge(money)
    return nil if money < 100
    @balance += money
  end

  def withdraw(money)
    @balance -= money
  end
end
