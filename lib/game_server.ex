defmodule GameServer do
  use GenServer
  alias DotsAndBoxes.Board
  alias DotsAndBoxes.Room

  def start_link(name) do
    state = %Room{game_name: name}
  end

  def start_game() do

  end

  def join_game() do

  end

  def take_turn() do

  end

end
