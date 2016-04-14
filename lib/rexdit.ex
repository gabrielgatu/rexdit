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
    Rexdit.SubredditObserver.observe("all")
    Rexdit.SubredditObserver.observe("funny")
    Rexdit.SubredditObserver.observe("news")
  end
end
