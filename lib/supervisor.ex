defmodule DotsAndBoxes.Supervisor do
  use Supervisor

  def start_link(state) do
    Supervisor.start_link(__MODULE__, state)
  end

  def init(state) do
    children = [
      supervisor(DotsAndBoxes.Game.Supervisor, [state])
    ]

    supervise(children, strategy: :one_for_all)
  end

end
