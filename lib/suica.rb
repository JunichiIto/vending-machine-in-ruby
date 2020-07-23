class Suica
  attr_accessor :balance, :user_age, :user_sex

  def initialize(user_age, user_sex)
    @balance = 0
    @user_age = user_age
    @user_sex = user_sex
  end

  def charge(money)
    raise ArgumentError, "moneyは100円以上の金額を指定してください" unless money >= 100
    @balance += money
  end

  def withdraw(money)
    @balance -= money
  end
end
