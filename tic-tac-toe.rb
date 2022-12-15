class Game
  attr_accessor :grid
  def initialize
    # Create the board
    @grid = create_grid()
    @interface = Interface.new
    @turn = :player1  # player1: X, player2: O (capital o, not zero)
    @grid_spaces = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  public
  def play
    #while !find_winner()
    9.times do
      @interface.display(@grid, @grid_spaces)
      user_choice = @interface.user_input(false, @turn) # here user_choice will always be an integer between 1-9

      is_cell_occupied = cell_occupied?(user_choice)
      if is_cell_occupied[:empty]
        p "Cell is occupied"
      else
        update_cell(is_cell_occupied[:cell])
        p "Cell is vacant"
      end

      if @turn == :player1
        @turn = :player2
      else
        @turn = :player1
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

  def update_cell(cell)
    if @turn == :player1
      cell.value = 'X'
    else
      cell.value = 'O'
    end
  end

  def find_winner
    # returns boolean if a winning combination is found on the board
    false
  end

  def cell_occupied?(num)
    row = ((num-1) / 3).floor
    index = @grid_spaces[row].find_index(num)
    p index

    puts "thingu: #{@grid[row][index]}"
    if(@grid[row][index].value == :vacant )
      return { :empty => false, :cell => @grid[row][index] }
    else
      return { :empty => true, :cell => @grid[row][index] }
    end
  end
end

class Interface
  def user_input(error, turn)
    puts "Invalid input, " if error
    puts "Make your move, #{turn}: (A number between 1-9)"
    input = gets.chomp
    # validate that input is between 1 and 9
    return input.to_i
  end

  def display(grid, grid_spaces)
    grid.each_with_index do |row, i|
      print "|"
      row.each_with_index do |cell, j|
        if cell.value != :vacant
          print " #{cell.value} |"
        else
          print " #{grid_spaces[i][j]} |"
        end
      end
      puts "\n"
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