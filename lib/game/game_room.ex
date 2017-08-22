defmodule DotsAndBoxes.Game.Room do
  alias DotsAndBoxes.Game.Board

  defstruct [ :board, :points, game_name: "default_name", players: [], players_count: 0 ]

  def init_room(name, creator, board_size) do
    board = Board.init_board(board_size)
    points = [{creator, 0}]
    %DotsAndBoxes.Game.Room{board: board, points: points, game_name: name, players: [creator], players_count: 1}
  end

end
