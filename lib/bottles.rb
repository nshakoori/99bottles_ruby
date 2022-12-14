class Bottles
  def song
    verses(99,0)
  end

  def verses(upper, lower)
    upper.downto(lower).collect {|i| verse(i)}.join("\n")
  end

  def verse(number)
    BottleVerse.new(number).lyrics
  end
end

class BottleVerse
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def lyrics
    bottle_number      = BottleNumber.for(number)

    "#{bottle_number} of beer on the wall, ".capitalize +
    "#{bottle_number} of beer.\n" +
    "#{bottle_number.action}, " +
    "#{bottle_number.successor} of beer on the wall.\n"
  end
end

class BottleNumber
  def self.for(number) 
    registry.find {|candidate| candidate.handles?(number)}.new(number)
  end

  def self.registry()
    @registry ||= [BottleNumber]
  end

  def self.register(candidate)
    registry.prepend(candidate)
    puts "register =#{registry}"
  end

  def self.inherited(candidate)
    register(candidate)
  end
  
  def self.handles?(number)
    true
  end

  attr_reader :number
  def initialize(number)
    @number = number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def quantity
    number.to_s
  end

  def container
    "bottles"
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def pronoun
    if number == 1
      "it"
    else
      "one"
    end
  end

  def successor
    BottleNumber.for(number - 1)
  end
end

class BottleNumber0 < BottleNumber
  def self.handles?(number)
    number == 0
  end

  def quantity
    "no more"
  end

  def action
    "Go to the store and buy some more"
  end

  def successor
    BottleNumber.for(99)
  end
end

class BottleNumber1 < BottleNumber
  def self.handles?(number)
    number == 1
  end

  def container
    "bottle"
  end
end

class BottleNumber6 < BottleNumber
  def self.handles?(number)
    number == 6
  end

  def quantity
    "1"
  end

  def container
    "six-pack"
  end
end