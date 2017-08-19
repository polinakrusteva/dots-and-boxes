defmodule DotsAndBoxes.Room do
  alias DotsAndBoxes.Board

  defstruct [ :board, game_name: "default_name", players: [], players_count: 0 ]

end
