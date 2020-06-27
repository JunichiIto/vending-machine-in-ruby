# frozen_string_literal: true

require './lib/drink'

class VendingMachine
  def initialize
    @stocks = []
    5.times do
      @stocks << Drink.cola
    end
  end

  def current_stocks
    drink = @stocks.first
    [{name: drink.name, price: drink.price, stock: @stocks.size}]
  end
end
