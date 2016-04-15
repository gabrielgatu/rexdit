defmodule Rexdit.Fetcher do
  alias Rexdit.Mapper

  def fetch_data(subreddit) do
    subreddit
    |> build_url
    |> HTTPoison.get
    |> handle_response(subreddit)
  end

  def fetch_data!(subreddit) do
    {:ok, posts} = fetch_data(subreddit)
    posts
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
    {:error, 400}
  end

  defp handle_decode(%{"error" => 404}, _subreddit) do
    {:error, 404}
  end

  defp handle_decode(data, _subreddit) do
    {:ok, Mapper.map_posts(data)}
  end
end
