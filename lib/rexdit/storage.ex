defmodule Rexdit.Storage do
  use GenServer

  @name Rexdit.Storage

  # Client API

  def start_link do
    GenServer.start_link __MODULE__, :ok, name: @name
  end

  def get_for(subreddit) do
    GenServer.call(@name, {:get, subreddit})
  end

  def store_in(posts, subreddit) do
    GenServer.cast(@name, {:store, posts, subreddit})
  end

  # Server API

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:get, subreddit}, _from, state) do
    {:reply, Map.get(state, subreddit, []), state}
  end

  def handle_cast({:store, posts, subreddit}, state) do
    {:noreply, Map.put(state, subreddit, posts)}
  end
end
