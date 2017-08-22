defmodule DotsAndBoxes do
  use Application
  alias DotsAndBoxes.Game.GameServer
  alias DotsAndBoxes.Game.Room

  @game_name Application.get_env(:dots_and_boxes, :game_name)
  @creator Application.get_env(:dots_and_boxes, :creator)
  @board_size Application.get_env(:dots_and_boxes, :board_size)

  def start(_type, _args) do
    DotsAndBoxes.Supervisor.start_link(Room.init_room(@game_name, @creator, @board_size))
  end

  def join(player) do
    GenServer.call(GameServer, {:join, player})
  end

  def move_left(row, column, player) do
    GenServer.call(GameServer, {:move_left, row, column, player})
  end

  def move_right(row, column, player) do
    GenServer.call(GameServer, {:move_right, row, column, player})
  end

  def move_up(row, column, player) do
    GenServer.call(GameServer, {:move_up, row, column, player})
  end

  def move_down(row, column, player) do
    GenServer.call(GameServer, {:move_down, row, column, player})
  end

  def get_winner() do
    GenServer.call(GameServer, {:get_winner})
  end


end
