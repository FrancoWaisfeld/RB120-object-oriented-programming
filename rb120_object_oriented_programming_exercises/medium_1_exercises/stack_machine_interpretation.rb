class MiniLangError < StandardError; end
class BadTokenError < MiniLangError; end
class EmptyStackError < MiniLangError; end

class Minilang
  ACTIONS = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(string)
    @program = string
    @register = 0
    @stack = []
  end

  def eval(elements=nil)
    format(@program, elements).split.each { |value| eval_action(value) }
  rescue MiniLangError => e
    puts e
  end

  def eval_action(value)
    if ACTIONS.include?(value)
      send(value.downcase)\
    elsif value =~ /\A[-+]?\d+\z/
      @register = value.to_i
    else
      raise BadTokenError, "Invalid token: #{value}"
    end
  end

  def push
    @stack << @register
  end

  def add
    @register += pop
  end

  def sub
    @register -= pop
  end

  def mult
    @register *= pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def pop
    raise EmptyStackError if @stack.empty?
    @register = @stack.pop
  end

  def print
    puts @register
  end
end

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'

FAHRENHEIT_TO_CENTIGRADE =
  '9 PUSH 5 PUSH 32 PUSH %<degrees_f>d SUB MULT DIV PRINT'

AREA_RECTANGLE = '%<num1>d PUSH %<num2>d MULT PRINT'

convert_to_celsius = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)

convert_to_celsius.eval(degrees_c: 100)
# 212

convert_to_celsius.eval(degrees_c: 0)
# 32

convert_to_celsius.eval(degrees_c: -40)
# -40

convert_to_fahrenheit = Minilang.new(FAHRENHEIT_TO_CENTIGRADE)

convert_to_fahrenheit.eval(degrees_f: 212)
# 100

convert_to_fahrenheit.eval(degrees_f: -40)
# -40

area_of_recetangle = Minilang.new(AREA_RECTANGLE)

area_of_recetangle.eval({ num1: 10, num2: 5 })
# 50
