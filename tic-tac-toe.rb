class Game
  attr_accessor :grid
  def initialize
    # Create the board
    @grid = create_grid()
    @interface = Interface.new
  end

  public
  def play
    #while !find_winner()
      @interface.display(@grid)
      user_choice = @interface.user_input

    #end
  end

  private
  def create_grid
    grid = Array.new
    3.times do |i|
      grid[i] = Array.new
      3.times do |j|
        grid[i][j] = Cell.new
      end
    end
    return grid
  end

  def update_cell(cell, value)

  end

  def find_winner
    # returns boolean if a winning combination is found on the board
    false
  end
end

class Interface
  def user_input
    puts "Make your move: "
    input = gets.chomp
    if validate_input?(input)
      return input
    else
      user_input()
    end
  end

  def display(grid)
    grid.each do |row|
      row.each { |cell| print "| #{cell.value} " }
      puts "|\n"
    end
  end

  private
  def validate_input?(input)
    # returns true if input is between 1-9, false if not
    input = input.to_i
  end
end

class Cell
  attr_accessor :value
  def initialize(value = :vacant)
    @value = value
  end
end

# Loops the game until the player chooses to leave
def play_game
  game = Game.new
  game.play 
  repeat_game()
end

def repeat_game()
  puts "Would you like to play another game? (y/n)"
  repeat = gets.chomp.downcase
  if(repeat == "y")
    play_game()
  elsif(repeat == "n")
    puts "Thanks for playing! Goodbye"
  end
end

play_game()