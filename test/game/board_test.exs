defmodule DotsAndBoxes.Game.BoardTest do
  use ExUnit.Case
  use Tensor
  alias DotsAndBoxes.Game.Board
  doctest DotsAndBoxes

  setup do
    {:ok, board: Board.init_board(3)}
  end

  test "board size properly initialized", state do
    row_size = Vector.length(Matrix.row(state[:board].board,0))
    col_size = Vector.length(Matrix.column(state[:board].board,0))
    assert row_size == 3 and col_size == 3 and state[:board].size == 3
  end

  test "binary transformation" do
    assert Board.get_binary_value(8) == "00001000"
  end

  test "is square completed" do
    assert Board.is_square(15) == true
  end

  test "is square not completed" do
    assert Board.is_square(1) == false
  end

  test "is turn possible on unavailable spot", state do
    moved_left_board = Board.make_turn(state[:board],0,0,:left)
    assert Board.is_turn_possible(moved_left_board, 0, 0, :left) == false
  end

  test "cell has bottom line" do
    assert Board.has_bottom(4) == true
  end

  test "cell does not have bottom line" do
    assert Board.has_bottom(1) == false
  end

  test "cell has right line" do
    assert Board.has_bottom(13) == true
  end

  test "cell has no right line" do
    assert Board.has_bottom(3) == false
  end

  test "cell has left line" do
    assert Board.has_left(14) == true
  end

  test "cell has no left line" do
    assert Board.has_left(7) == false
  end

  test "cell has top line" do
    assert Board.has_top(13) == true
  end

  test "cell has no top line" do
    assert Board.has_top(14) == false
   end

  test "get element at row and column", state do
    new_board = put_in(state[:board].board, [0, 1], 7)
    assert Board.get_at(new_board,0,1) == 7
  end

  test "properly update cell after move", state do

  end

end
