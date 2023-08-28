# frozen_string_literal: true

# ConnectFour Class
class ConnectFour
  attr_accessor :board

  def create_board
    Array.new(6) { Array.new(7, ' ') }
  end

  def out_bounds_message
    puts 'You are out of bounds'
  end

  def initialize
    @board = create_board
  end

  def show_board
    for row in board 
      for column in row
        print " #{column} " 
      end
      print "\n"
    end
    puts ' 0  1  2  3  4  5  6 ' # The footer of the game
  end

  def add_full(column)
    row = 5
    square = board[row][column]
    until square == ' '
      row -= 1
      break out_bounds_message if row == -1

      square = board[row][column]
    end
    board[row][column] = '♦'
  end

  def add_empty(column)
    row = 5
    square = board[row][column]
    until square == ' '
      row -= 1
      break out_bounds_message if row == -1

      square = board[row][column]
    end
    board[row][column] = '♢'
  end

  def check_horizontal_streak(row, column, symbol, prev_column = nil)
    square = board[row][column]
    # Base Case
    return 0 if square != symbol

    left = column != 0 && prev_column != column - 1 ? check_horizontal_streak(row, column - 1, symbol, column) : 0
    right = column != 6 && prev_column != column + 1 ? check_horizontal_streak(row, column + 1, symbol, column) : 0

    total_streak = left + right + 1

    total_streak
  end
end
