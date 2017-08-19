defmodule DotsAndBoxes.Board do
  use Tensor
  @moduledoc """
  Represents the game board. It is a two
  dimensional array
  """

  defstruct [ size: 0, board: [[]] ]

  def init_board(size) do
    %DotsAndBoxes.Board{size: size, board: Matrix.new(size, size)}
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

  """
  TODO: add validation is_turn_possible
  and update when square is created
  """
  def make_turn(board, i, j, :left) do
    update_value(board, i, j, :math.pow(2,3))
  end

  def make_turn(board, i, j, :right) do
    update_value(board, i, j, :math.pow(2,1))
  end

  def make_turn(board, i, j, :down) do
    update_value(board, i, j, :math.pow(2,2))
  end

  def make_turn(board, i, j, :up) do
    update_value(board, i, j, :math.pow(2,0))
  end

  defp update_value(board, i, j, value) do
    new_value = get_at(board.board, i, j) + value
    new_board = board.board
    new_board = put_in(new_board, [i,j], new_value)
    %DotsAndBoxes.Board{size: board.size, board: new_board}
  end

  defp get_at(board,i,j) do
    board |> Enum.at(i) |> Enum.at(j)
  end

  defp get_binary_value(number) do
    Integer.to_string(number,2)
  end

  """
    TODO: Add logic if it has 5 bits(square completed)
  """
  defp has_left(board, value)  do
    binary_part(get_binary_value(value), 0, 1) == 1
  end

  defp has_right(board, value)  do
    binary_part(get_binary_value(value), 2, 1) == 1
  end

  defp has_top(board, value)  do
    binary_part(get_binary_value(value), 3, 1) == 1
  end

  defp has_bottom(board, value)  do
    binary_part(get_binary_value(value), 1, 1) == 1
  end

  def is_square(board, value) do
    has_left(board, value) && has_right(board, value) && has_top(board, value) && has_bottom(board, value)
  end

end
