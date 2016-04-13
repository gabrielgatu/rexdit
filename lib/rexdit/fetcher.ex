defmodule Rexdit.Fetcher do
  alias Rexdit.Mapper

  def fetch_data do
    HTTPoison.get("https://www.reddit.com/r/elixir/new.json?sort=new&limit=1")
    |> response_received
  end

  defp response_received({:ok, %HTTPoison.Response{body: body}}) do
    body
    |> Poison.decode!
    |> Mapper.map_posts
  end

  defp response_received({:error, reason}) do
    IO.inspect reason
  end
end
