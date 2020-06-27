# frozen_string_literal: true

class Drink
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.cola
    self.new("コーラ", 120)
  end
end
