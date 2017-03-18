require "Nupack/version"

  class CostEstimation
  attr_accessor :base_price, :person, :material
  attr_reader :price
  Flat_Markup_Rate = 0.05
  Person_Markup_Rate = 0.012
  Material_Markup_Rate = {
      "drugs" => 0.075,
      "food" => 0.13,
      "electronics" => 0.02,
  }

  def initialize(base_price, person, material)
    @base_price = get_base_price(base_price)
    @person = get_person(person)
    @material = material
    output_price(final_price)
  end

  private

  # Collect base price from input string
  def get_base_price(base_price)
    value = base_price.gsub('$', '').gsub('.', '').gsub(',', '')
    price_nil?(value)
    non_digits_price?(value)
    base_price.gsub('$', '').gsub(',', '').to_f

  end

  # Check if price is given as input or not?
  def price_nil?(value)
    raise "Input Invalid. Please check the format!" if value.match(/\d/).nil?
  end

  # Check for the alphabets in base price input
  def non_digits_price?(value)
    raise "Input Invalid. Please check the format!" if !value.match(/\D/).nil?
  end

  # Collect number of persons from input string
  def get_person(person)
    person_match = person.match(/^\d+/)
    raise "Invalid person input!" if person_match.nil?
    person_match[0].to_f
  end

  # Base markup price for person and materials
  def base_markup_price
    @base_price + (@base_price * Flat_Markup_Rate)
  end

  # Markup price for person
  def add_markup_person
    base_markup_price * @person * Person_Markup_Rate
  end

  # Markup price for Materials
  def add_markup_materials
    if Material_Markup_Rate["#{@material}"]
      markup = Material_Markup_Rate["#{@material}"]
    else
      markup= 0.00
    end
    base_markup_price * markup
  end

  # Addition of markup price of person and other markup material with base markup price
  def final_price
    base_markup_price + add_markup_person + add_markup_materials
  end

  # Output price in format with upto 2 decimal points
  def output_price(final_price)
    price = '%.2f' % final_price
    formatted_price= price.to_s.reverse.scan(/(?:\d*\.)?\d{1,3}-?/).join(',').reverse
    @price = "$#{formatted_price}"
  end
  end

