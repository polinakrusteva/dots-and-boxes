defmodule DotsAndBoxes.Room do
  alias DotsAndBoxes.Board

  defstruct [ :board, :points, game_name: "default_name", players: [], players_count: 0 ]

  def init_room(name, creator, board) do
    points = [{creator, 0}]
    %DotsAndBoxes.Room{board: board, points: points, game_name: name, players: [creator], players_count: 1}
  end

end
