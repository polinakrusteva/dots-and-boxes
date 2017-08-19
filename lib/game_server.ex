defmodule GameServer do
  use GenServer
  alias DotsAndBoxes.Board
  alias DotsAndBoxes.Room

  """
  TODO: add point scoring and winner logic messages
  """

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def join(pid, player) do
    GenServer.call(pid, {:join, player})
  end

  def move_left(pid, row, column) do
    GenServer.call(pid, {:move_left, row, column})
  end

  def move_right(pid, row, column) do
    GenServer.call(pid, {:move_right, row, column})
  end

  def move_up(pid, row, column) do
    GenServer.call(pid, {:move_up, row, column})
  end

  def move_down(pid, row, column) do
    GenServer.call(pid, {:move_down, row, column})
  end

  #Server callbacks

  def handle_call({:join, player}, _from, %{board: board, game_name: name, players: players, players_count: players_count} = state) do
    new_state = %Room{ board: board, game_name: name, players: players ++ [player], players_count: players_count + 1 }
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call({:move_left, row, column}, _from,  %{board: board, game_name: name, players: players, players_count: players_count}) do
    new_board = DotsAndBoxes.Board.make_turn(board, row, column, :left)
    new_state = %Room{ board: new_board, game_name: name, players: players, players_count: players_count}
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call({:move_right, row, column}, _from,  %{board: board, game_name: name, players: players, players_count: players_count}) do
    new_board = DotsAndBoxes.Board.make_turn(board, row, column, :right)
    new_state = %Room{ board: new_board, game_name: name, players: players, players_count: players_count}
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call({:move_up, row, column}, _from,  %{board: board, game_name: name, players: players, players_count: players_count}) do
    new_board = DotsAndBoxes.Board.make_turn(board, row, column, :up)
    new_state = %Room{ board: new_board, game_name: name, players: players, players_count: players_count}
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call({:move_down, row, column}, _from,  %{board: board, game_name: name, players: players, players_count: players_count}) do
    new_board = DotsAndBoxes.Board.make_turn(board, row, column, :down)
    new_state = %Room{ board: new_board, game_name: name, players: players, players_count: players_count}
    {:reply, {:ok, new_state}, new_state}
  end

end
