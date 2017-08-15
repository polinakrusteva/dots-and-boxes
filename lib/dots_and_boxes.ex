defmodule DotsAndBoxes do
  use GenServer
  alias Board
  @moduledoc """
  Documentation for DotsAndBoxes.
  """

  @doc """
  Hello world.
  """
  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end
end
