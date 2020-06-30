# frozen_string_literal: true

require './lib/drink'

class VendingMachine
  attr_reader :sales_amount

  def initialize
    @sales_amount = 0
    @stocks = {}
    create_stock(Drink.cola, 5)
    create_stock(Drink.redbull, 5)
    create_stock(Drink.water, 5)
  end

  def current_stocks
    @stocks.map do |name, drinks|
      drink = drinks.first
      next if drink.nil?
      {name: drink.name, price: drink.price, stock: drinks.count}
    end.compact
  end

  def stock_available?(name)
    @stocks[name].size > 0
  end

  def buy(name, suica)
    return nil unless stock_available?(name)
    price = @stocks[name][0].price
    return nil if suica.balance < price
    drink = @stocks[name].shift
    @sales_amount += drink.price
    suica.withdraw(drink.price)
    drink
  end

  def stock_available_lists
    @stocks.map  { |name, drink| name }
  end

    def create_stock(drink, stock)
      stock.times do
        unless @stocks[drink.name]
          @stocks[drink.name] = []
        end
        @stocks[drink.name] << drink
      end
    end
end
