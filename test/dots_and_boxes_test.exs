defmodule DotsAndBoxesTest do
  use ExUnit.Case
  doctest DotsAndBoxes

  test "application start" do
    response = Application.start(:dots_and_boxes)
    assert response == {:error, {:already_started, :dots_and_boxes}}
  end
end
