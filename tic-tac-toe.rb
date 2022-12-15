class Game
  attr_accessor :grid
  def initialize
    # Create the board
    @grid = create_grid()
    @interface = Interface.new
    @turn = :player1  # player1: X, player2: O (capital o, not zero)
    @grid_spaces = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    #@grid[1][1].value = "X"
  end

  public
  def play
    #while !find_winner()
    9.times do
      @interface.display(@grid)
      user_choice = @interface.user_input(false) # here user_choice will always be an integer between 1-9
      if cell_occupied?(user_choice)
        p "Cell is occupied"
      else
        p "Cell is vacant"
      end
    #end
    end
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

  def cell_occupied?(num)
    row = ((num-1) / 3).floor
    index = @grid_spaces[row].find_index(num)
    p index

    if(@grid[row][index].value == :vacant )
      return false
    else
      return true
    end
  end
end

class Interface
  def user_input(error)
    puts "Invalid input, " if error
    puts "Make your move: (A number between 1-9)"
    input = gets.chomp
    # validate that input is between 1 and 9
    return input.to_i
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
    #input = input.to_i
    #if input >= 1 && input <= 9
      # check if the cell is occupied as well
    #  return true
    #else
    #  user_input(true)
    #end
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