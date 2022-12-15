# TO DO
# > Add score over multiple games
# > Add way to exit game in middle of match

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
    while !find_winner()
      @interface.display(@grid, @grid_spaces)
      user_choice = @interface.user_input(@turn) # here user_choice will always be an integer between 1-9

      is_cell_occupied = cell_occupied?(user_choice)
      if !is_cell_occupied[:empty] # cell is not empty
        puts "Cell is occupied, choose another cell"
        next
      else # cell is empty
        update_cell(is_cell_occupied[:cell])
      end

      if @turn == :player1
        @turn = :player2
      else
        @turn = :player1
      end
    end

    @interface.display(@grid, @grid_spaces)
    puts "GAME OVER!"
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
    # create array for each row, column, and diagonal
    # check if all elements in that array is X or O
    # profit
    @grid.each do |row|
      # rows
      if row.all? { |cell| cell.value == "X" }
        return "X"
      elsif row.all? { |cell| cell.value == "O" }
        return "O"
      end
    end

    i = 0
    while i < @grid.length
      # columns
      column = []

      j = 0
      while j < @grid.length
        column.push(@grid[j][i])
        j += 1
      end
      
      return column[0] if column.all? { |cell| cell.value == 'X' } || column.all? { |cell| cell.value == 'O' }
      i += 1
    end

    # diagonals
    diagonal = []
    i = 0
    while i < @grid.length
      diagonal.push(@grid[i][i])
      i += 1
    end
    return diagonal[0] if diagonal.all? { |cell| cell.value == 'X' } || column.all? { |cell| cell.value == 'O' }

    diagonal = []
    i = 0
    j = grid.length - 1
    while i < grid.length
      diagonal.push(@grid[i][j])

      j -= 1
      i += 1
    end
    return diagonal[0] if diagonal.all? { |cell| cell.value == 'X' } || column.all? { |cell| cell.value == 'O' }

    # check if the grid is full, return true if it is full
    rows_full = 0
    @grid.each do |row|
      rows_full += 1 if row.all? { |cell| cell.value != :vacant }
    end
    return true if rows_full == @grid.length

    false
  end

  def cell_occupied?(num)
    row = ((num-1) / 3).floor
    index = @grid_spaces[row].find_index(num)
    #p index

    #puts "thingu: #{@grid[row][index]}"
    if(@grid[row][index].value == :vacant )
      return { :empty => true, :cell => @grid[row][index] }
    else
      return { :empty => false, :cell => @grid[row][index] }
    end
  end
end

class Interface
  def user_input(turn)
    puts "Make your move, #{turn}: (A number between 1-9)"
    input = gets.chomp
    # validate that input is between 1 and 9
    if validate_input?(input)
      return input.to_i
    else
      user_input(turn)
    end
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
    puts "\n"
  end

  private
  def validate_input?(input)
    # returns true if input is between 1-9, false if not
    input = input.to_i
    if input >= 1 && input <= 9 
      return true
    else
      return false
    end
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
