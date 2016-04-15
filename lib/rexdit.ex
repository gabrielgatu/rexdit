defmodule Rexdit do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Rexdit.Storage, [])
    ]
    opts = [strategy: :one_for_one, name: __MODULE__]

    resp = Supervisor.start_link(children, opts)
    run()
    resp
  end

  def run do
    System.get_env("REXDIT")
    |> extract_subreddits
    |> Enum.each(&Rexdit.SubredditObserver.observe/1)
  end

  defp extract_subreddits(nil) do
    ["elixir"]
  end

  defp extract_subreddits(subreddits_string) do
    subreddits_string
    |> String.split("|")
  end
end
