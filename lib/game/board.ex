defmodule DotsAndBoxes.Game.Board do
  use Tensor
  @moduledoc """
  Represents the game board. It is a two
  dimensional array
  """


  """
  TODO: fix print method
  """
  defstruct [ size: 0, board: [[]] ]

  def init_board(size) do
    %DotsAndBoxes.Game.Board{size: size, board: Matrix.new(size, size)}
  end

  def is_position_valid(size, i, j) do
    i >= 0 and i < size and j >= 0 and j < size
  end

  def is_turn_possible(board, i, j, :left) do
    has_left(get_at(board.board,i,j)) == false
  end

  def is_turn_possible(board, i, j, :right) do
    has_right(get_at(board.board,i,j)) == false
  end

  def is_turn_possible(board, i, j, :up) do
    has_top(get_at(board.board,i,j)) == false
  end

  def is_turn_possible(board, i, j, :down) do
    has_bottom(get_at(board.board,i,j)) == false
  end

  def make_turn(board, i, j, :left) do
    update_value(board, i, j, round(:math.pow(2,3)))
  end

  def make_turn(board, i, j, :right) do
    update_value(board, i, j, round(:math.pow(2,1)))
  end

  def make_turn(board, i, j, :down) do
    update_value(board, i, j, round(:math.pow(2,2)))
  end

  def make_turn(board, i, j, :up) do
    update_value(board, i, j, round(:math.pow(2,0)))
  end

  def update_value(board, i, j, value) do
    new_value = get_at(board.board, i, j) + value
    new_board = board.board
    new_board = put_in(new_board, [i,j], new_value)
    %DotsAndBoxes.Game.Board{size: board.size, board: new_board}
  end

  def get_at(board,i,j) do
    board |> Enum.at(i) |> Enum.at(j)
  end

  defp integer_to_binary(number) do
    Integer.to_string(number,2)
  end

  def get_binary_value(number) do
    binary_number = integer_to_binary(number)
    zeroes = 8 - Kernel.byte_size(binary_number)
    String.duplicate("0",zeroes) <> binary_number
  end

  def has_left(value) do
    String.to_integer(binary_part(get_binary_value(value), 4, 1)) == 1
  end

  def has_right(value) do
    String.to_integer(binary_part(get_binary_value(value), 6, 1)) == 1
  end

  def has_top(value) do
    String.to_integer(binary_part(get_binary_value(value), 7, 1)) == 1
  end

  def has_bottom(value) do
    String.to_integer(binary_part(get_binary_value(value), 5, 1)) == 1
  end

  def is_square(value) do
    has_left(value) && has_right(value) && has_top(value) && has_bottom(value)
  end

  def is_game_over(board) do
    length(Enum.filter(List.flatten(Matrix.to_list(board.board)), fn(x) -> x != 15 end)) == 0
  end

  def print_board(board, size) do
    for i <- 0..Vector.length(Matrix.row(board.board,0))-1 do
      IO.puts ""
      IO.write "+"
      for j <- 0..Vector.length(Matrix.column(board.board,0))-1 do
        if(has_top(get_at(board.board, i, j))) do
          IO.write "-"
        else
          IO.write " "
        end
        IO.write "+"
      end
      IO.puts ""
      for j <- 0..Vector.length(Matrix.column(board.board,0))-1 do
        if(has_left(get_at(board.board, i,j))) do
          IO.write "|"
        else
          IO.write " "
        end
        IO.write " "
        if(j == size - 1 && has_right(get_at(board.board,i,j))) do
          IO.write "|"
        end
      end
    end
    #IO.write "+"
    IO.puts ""
    for j <- 0..Vector.length(Matrix.column(board.board,0))-1 do
      if(has_bottom(get_at(board.board, j, size-1))) do
        IO.write "_"
      else
        IO.write " "
      end
      IO.write " "
    end
  end

end
