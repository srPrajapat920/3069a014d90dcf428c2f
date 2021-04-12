class ToyRobot
  attr_reader :position, :direction,:board
  Directions = ['north','east','south','west']

  def initialize(board)
    raise TypeError,'invalid board' if board.nil?
    @board = board
  end
  def value_position?(x,y)
    (x>=0 && x<= self.board.columns && y>= 0 && y<= self.board.rows)
  end
  def place x,y,direction
    raise TypeError,'invalid coordinates' unless (x.is_a? Integer) && (y.is_a? Integer)
    raise TypeError,'invalid direction' unless (Directions.include?(direction))
    if value_position?(x,y)
      @position = {x: x, y: y}
      @direction = direction
      true
    else
      false
    end
  end
  def move
    return false if @position.nil?
    position = @position
    movment = nil
    case @direction
    when :north
      movment = {x: 0, y: 1}
    when :east
      movment = {x: 1, y: 0}
    when :south
      movment = {x: 0, y: -1}
    when :west
       movment = {x: -1, y: 0}
    end
    moved = true
    if valid_position?(position[:x]+movment[:x],position[:y]+movment[:y])
      @position = {x: position[:x]+movment[:x],y: position[:y]+movment[:y]}
      return  { location: [@position.x,@position.y,@direction] }
    else
      moved = false
    end
    moved
  end
  def rotate_left
    return false if @direction.nil?
    index = Directions.index(@direction)
    @direction = Directions.rotate(-1)[index]
    true
  end
  def rotate_right
    return false if @direction.nil?
    index = Directions.index(@direction)
    @direction = Directions.rotate()[index]
    true
  end
  def report
    return "not on board" if @position.nil? || @direction.nil?
    "#{@position[:x]},#{@position[:y]},#{@direction.to_s.upcase}"
  end
  def eval(input)
    return if input.strip.empty?
    args = input.first.split(" ")
    @command = args.first.downcase.to_sym
    arguments = args-[args[0]]
    @tockens = arguments[0].split(",")
    raise ArgumentError, 'invalid command ' unless Commands.include?(@command)
    if command_it(@command)
      input.last.split(",").each do |d|
        command_it(d.downcase.to_sym)
      end
    end

  end

  def command_it(command)

    case command
    when :place
      raise ArgumentError,"invalid command" if arguments.nil?
      tockens = arguments
      raise ArgumentError,"invalid command" unless @tockens.count > 2
      x =  @tockens[0].to_i
      y =  @tockens[1].to_1
      direction = @tockens[2].downcase.to_sym
      place(x,y,direction)
    when :move
      move
    when :left
      rotate_left
    when :right
      rotate_right
    when :report
      report
    else
      raise ArgumentError,'invalid command'
    end

  end
end