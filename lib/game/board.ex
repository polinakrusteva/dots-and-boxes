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

  def is_turn_possible(board, i, j, :left) do
    has_left(board,get_at(board.board,i,j)) == false
  end

  def is_turn_possible(board, i, j, :right) do
    has_right(board,get_at(board.board,i,j)) == false
  end

  def is_turn_possible(board, i, j, :up) do
    has_top(board,get_at(board.board,i,j)) == false
  end

  def is_turn_possible(board, i, j, :down) do
    has_bottom(board,get_at(board.board,i,j)) == false
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

  defp update_value(board, i, j, value) do
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

  defp has_left(board, value) do
    String.to_integer(binary_part(get_binary_value(value), 4, 1)) == 1
  end

  defp has_right(board, value) do
    String.to_integer(binary_part(get_binary_value(value), 6, 1)) == 1
  end

  defp has_top(board, value) do
    String.to_integer(binary_part(get_binary_value(value), 7, 1)) == 1
  end

  defp has_bottom(board, value) do
    String.to_integer(binary_part(get_binary_value(value), 5, 1)) == 1
  end

  def is_square(board, value) do
    has_left(board, value) && has_right(board, value) && has_top(board, value) && has_bottom(board, value)
  end

  def print_board(board) do
    for i <- board.board do
      for j <- i do
        cond do
          has_top(board.board, j) && has_left(board.board, j) == false -> IO.puts "-"
          has_top(board.board, j) && has_left(board.board, j) -> IO.puts "|-"
          has_bottom(board.board, j) && has_right(board.board, j) == false -> IO.puts "_"
          has_bottom(board.board, j) && has_right(board.board, j) -> IO.puts "_|"
          true -> IO.puts "."
        end
      end
    end
  end

  def is_game_over(board) do
    length(Enum.filter(List.flatten(Matrix.to_list(board.board)), fn(x) -> x != 15 end)) == 0
  end

end
