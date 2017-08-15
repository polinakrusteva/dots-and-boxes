defmodule Board do

  @moduledoc """
  Represents the game board. It is a two
  dimensional array
  """

  defstruct [ size: 0, content: [[]] ]

  def init_board(size) do

  end

  def get_at(board,i,j) do
    board |> Enum.at(i) |> Enum.at(j)
  end

  def get_binary_value(number) do
    Integer.to_string(number,2)
  end

  """
    Add logic if it has 5 bits
  """
  def has_left(value)  do
    binary_part(get_binary_value(value), 0, 1) == 1
  end

  def has_right(value)  do
    binary_part(get_binary_value(value), 2, 1) == 1
  end

  def has_top(value)  do
    binary_part(get_binary_value(value), 3, 1) == 1
  end

  def has_bottom(value)  do
    binary_part(get_binary_value(value), 1, 1) == 1
  end

  def is_square(value) do
    has_left(value) && has_right(value) && has_top(value) && has_bottom(value)
  end

end
