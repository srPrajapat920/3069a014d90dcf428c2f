require_relative 'board'
require_relative 'toy_robot'
class Simulater
  def initialize
    @board = Board.new 5,5
    @robat = ToyRobot.new @board
  end
  def execute(command)
    begin
      return @robat.eval(command)
    rescue Exception => e
      e.message
    end
  end
end