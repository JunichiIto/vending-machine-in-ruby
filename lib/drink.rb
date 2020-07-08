# frozen_string_literal: true

class Drink
  attr_accessor :name, :price

  def self.cola
    self.new("コーラ", 120)
  end

  def self.redbull
    self.new("レッドブル", 200)
  end

  def self.water
    self.new("水", 100)
  end

  def initialize(name, price)
    @name = name
    @price = price
  end
end
