defmodule GameServer do
  use GenServer
  alias DotsAndBoxes.Board
  alias DotsAndBoxes.Room

  """
  TODO: Create start game function so that game Server
  supports more than one game at a time
  TODO: Add global ranklist with point per victory
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

  def move_left(pid, row, column, player) do
    GenServer.call(pid, {:move_left, row, column, player})
  end

  def move_right(pid, row, column, player) do
    GenServer.call(pid, {:move_right, row, column, player})
  end

  def move_up(pid, row, column, player) do
    GenServer.call(pid, {:move_up, row, column, player})
  end

  def move_down(pid, row, column, player) do
    GenServer.call(pid, {:move_down, row, column, player})
  end

  def get_winner(pid) do
    GenServer.call(pid, {:get_winner})
  end

  #Server callbacks

  def handle_call({:join, player}, _from, %{board: board, points: points, game_name: name, players: players, players_count: players_count} = state) when players_count < 2 do
    new_state = %Room{ board: board, points: points ++ [{player, 0}], game_name: name, players: players ++ [player], players_count: players_count + 1 }
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call({:join, player}, _from, %{board: board, game_name: name, players: players, players_count: players_count} = state) when players_count == 2 do
    {:reply, {:error, :game_room_already_full}, state}
  end

  def handle_call({:move_left, row, column, player}, _from,  %{board: board, points: points, game_name: name, players: players, players_count: players_count} = state) do
    if(DotsAndBoxes.Board.is_turn_possible(board, row, column, :left)) do
      new_board = DotsAndBoxes.Board.make_turn(board, row, column, :left)
      if(DotsAndBoxes.Board.is_square(new_board.board, DotsAndBoxes.Board.get_at(new_board.board, row, column))) do
        new_points = points
        new_points = Keyword.update!(new_points, player, &(&1+1))
        new_state = %Room{ board: new_board, points: new_points, game_name: name, players: players, players_count: players_count}
        if(DotsAndBoxes.Board.is_game_over(new_board)) do
          {:reply, {:game_over, new_points}, new_state}
        else
          {:reply, {:square_created, new_state}, new_state}
        end
      else
        new_state = %Room{ board: new_board, points: points, game_name: name, players: players, players_count: players_count}
        {:reply, {:ok, new_state}, new_state}
      end
    else
      {:reply, {:error, :location_not_available }, state}
    end
  end

  def handle_call({:move_right, row, column, player}, _from,  %{board: board, points: points, game_name: name, players: players, players_count: players_count} = state) do
    if(DotsAndBoxes.Board.is_turn_possible(board, row, column, :right)) do
      new_board = DotsAndBoxes.Board.make_turn(board, row, column, :right)
      if(DotsAndBoxes.Board.is_square(new_board.board, DotsAndBoxes.Board.get_at(new_board.board, row, column))) do
        new_points = points
        new_points = Keyword.update!(new_points, player, &(&1+1))
        new_state = %Room{ board: new_board, points: new_points, game_name: name, players: players, players_count: players_count}
        if(DotsAndBoxes.Board.is_game_over(new_board)) do
          {:reply, {:game_over, new_points}, new_state}
        else
          {:reply, {:square_created, new_state}, new_state}
        end
      else
        new_state = %Room{ board: new_board, points: points, game_name: name, players: players, players_count: players_count}
        {:reply, {:ok, new_state}, new_state}
      end
    else
      {:reply, {:error, :location_not_available }, state}
    end
  end

  def handle_call({:move_up, row, column, player}, _from,  %{board: board, points: points, game_name: name, players: players, players_count: players_count} = state) do
    if(DotsAndBoxes.Board.is_turn_possible(board, row, column, :up)) do
      new_board = DotsAndBoxes.Board.make_turn(board, row, column, :up)
      if(DotsAndBoxes.Board.is_square(new_board.board, DotsAndBoxes.Board.get_at(new_board.board, row, column))) do
        new_points = points
        new_points = Keyword.update!(new_points, player, &(&1+1))
        new_state = %Room{ board: new_board, points: new_points, game_name: name, players: players, players_count: players_count}
        if(DotsAndBoxes.Board.is_game_over(new_board)) do
          {:reply, {:game_over, new_points}, new_state}
        else
          {:reply, {:square_created, new_state}, new_state}
        end
      else
        new_state = %Room{ board: new_board, points: points, game_name: name, players: players, players_count: players_count}
        {:reply, {:ok, new_state}, new_state}
      end
    else
      {:reply, {:error, :location_not_available }, state}
    end
  end

  def handle_call({:move_down, row, column, player}, _from,  %{board: board, points: points, game_name: name, players: players, players_count: players_count} = state) do
    if(DotsAndBoxes.Board.is_turn_possible(board, row, column, :down)) do
      new_board = DotsAndBoxes.Board.make_turn(board, row, column, :down)
      if(DotsAndBoxes.Board.is_square(new_board.board, DotsAndBoxes.Board.get_at(new_board.board, row, column))) do
        new_points = points
        new_points = Keyword.update!(new_points, player, &(&1+1))
        new_state = %Room{ board: new_board, points: new_points, game_name: name, players: players, players_count: players_count}
        if(DotsAndBoxes.Board.is_game_over(new_board)) do
          {:reply, {:game_over, new_points}, new_state}
        else
          {:reply, {:square_created, new_state}, new_state}
        end
      else
        new_state = %Room{ board: new_board, points: points, game_name: name, players: players, players_count: players_count}
        {:reply, {:ok, new_state}, new_state}
      end
    else
      {:reply, {:error, :location_not_available }, state}
    end
  end

  def handle_call({:get_winner}, _from, %{board: board, points: points, game_name: name, players: players, players_count: players_count} = state) do
    winner = points |> Enum.max_by(&(elem(&1,1)))
    {:reply, {:ok, winner}, state}
  end

end
