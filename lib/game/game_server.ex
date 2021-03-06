defmodule DotsAndBoxes.Game.GameServer do
  use GenServer
  alias DotsAndBoxes.Game.Board
  alias DotsAndBoxes.Game.Room

  """
  TODO: Create start game function so that game Server
  supports more than one game at a time
  TODO: Add global ranklist with point per victory
  """

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def join(pid, player) do
    GenServer.call(pid, {:join, player})
  end

  def print_board(pid) do
    GenServer.call(pid, {:print_board})
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
    if(Board.is_turn_possible(board, row, column, :left)) do
      new_board = Board.make_turn(board, row, column, :left)
      has_neighbour = Board.is_position_valid(board.size, row, column-1)
      if(has_neighbour) do
        new_board = Board.make_turn(new_board, row, column-1, :right)
      end
      if(Board.is_square(Board.get_at(new_board.board, row, column)) || (has_neighbour && Board.is_square(Board.get_at(new_board.board, row, column-1)))) do
        new_points = points
        new_points = Keyword.update!(new_points, player, &(&1+1))
        new_state = %Room{ board: new_board, points: new_points, game_name: name, players: players, players_count: players_count}
        if(Board.is_game_over(new_board)) do
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
    if(Board.is_turn_possible(board, row, column, :right)) do
      new_board = Board.make_turn(board, row, column, :right)
      has_neighbour = Board.is_position_valid(board.size, row, column+1)
      if(has_neighbour) do
        new_board = Board.make_turn(new_board, row, column+1, :left)
      end
      if(Board.is_square(Board.get_at(new_board.board, row, column)) || (has_neighbour && Board.is_square(Board.get_at(new_board.board, row, column+1)))) do
        new_points = points
        new_points = Keyword.update!(new_points, player, &(&1+1))
        new_state = %Room{ board: new_board, points: new_points, game_name: name, players: players, players_count: players_count}
        if(Board.is_game_over(new_board)) do
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
    if(Board.is_turn_possible(board, row, column, :up)) do
      new_board = Board.make_turn(board, row, column, :up)
      has_neighbour = Board.is_position_valid(board.size, row-1, column)
      if(has_neighbour) do
        new_board = Board.make_turn(new_board, row-1, column, :down)
      end
      if(Board.is_square(Board.get_at(new_board.board, row, column)) || ( has_neighbour && Board.is_square(Board.get_at(new_board.board, row-1,column)))) do
        new_points = points
        new_points = Keyword.update!(new_points, player, &(&1+1))
        new_state = %Room{ board: new_board, points: new_points, game_name: name, players: players, players_count: players_count}
        if(Board.is_game_over(new_board)) do
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
    if(Board.is_turn_possible(board, row, column, :down)) do
      new_board = Board.make_turn(board, row, column, :down)
      has_neighbour = Board.is_position_valid(board.size, row+1, column)
      if(has_neighbour) do
        new_board = Board.make_turn(new_board, row+1, column, :up)
      end
      if(Board.is_square(Board.get_at(new_board.board, row, column)) || ( has_neighbour && Board.is_square(Board.get_at(new_board.board, row+1, column)))) do
        new_points = points
        new_points = Keyword.update!(new_points, player, &(&1+1))
        new_state = %Room{ board: new_board, points: new_points, game_name: name, players: players, players_count: players_count}
        if(Board.is_game_over(new_board)) do
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

  def handle_call({:print_board}, _from, %{board: board, points: points, game_name: name, players: players, players_count: players_count} = state) do
    {:reply, {:ok, Board.print_board(board, board.size)}, state}
  end
end
