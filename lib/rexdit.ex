defmodule Rexdit do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = []
    opts = [strategy: :one_for_one, name: __MODULE__]

    run()

    Supervisor.start_link(children, opts)
  end

  # Need to automatize this procedure and then,
  # when the data is back, control if there's any new post,
  # if yes show to the user the nofitication, otherwise
  # sleep for some minutes and repeat the procedure.
  def run do
    Rexdit.Fetcher.fetch_data
    |> Enum.fetch!(0)
    |> IO.inspect
    |> Rexdit.Notifier.message
  end
end
