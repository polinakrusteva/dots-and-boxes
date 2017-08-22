defmodule DotsAndBoxes.Game.Supervisor do
  use Supervisor
  alias DotsAndBoxes.Game.GameServer

  def start_link(state) do
    Supervisor.start_link(__MODULE__, state)
  end

  def init(state) do
    children = [
      worker(GameServer, [state])
    ]

    supervise(children, strategy: :one_for_one)
  end

end
