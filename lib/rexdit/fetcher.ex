defmodule Rexdit.Fetcher do
  alias Rexdit.Mapper

  def fetch_data(subreddit) do
    subreddit
    |> build_url
    |> HTTPoison.get
    |> handle_response(subreddit)
  end

  defp build_url(subreddit) do
    "https://www.reddit.com/r/#{subreddit}/new.json?sort=new&limit=1"
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body}}, subreddit) do
    body
    |> Poison.decode!
    |> handle_decode(subreddit)
  end

  defp handle_response({:error, reason}, _subreddit) do
    IO.inspect reason
  end

  defp handle_decode(%{"error" => 404}, subreddit) do
    IO.puts "Error: subreddit <#{subreddit}> not found!"
  end

  defp handle_decode(data, _subreddit) do
    Mapper.map_posts(data)
  end
end
