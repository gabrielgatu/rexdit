defmodule Rexdit.Fetcher do
  alias Rexdit.Mapper

  @type error :: 400 | 404

  @doc """
  Given a subreddit it tries to fetch the newest post
  """
  @spec fetch_data(String.t) :: {:ok, [Rexdit.Post.t]} | {:error, error}
  def fetch_data(subreddit) do
    subreddit
    |> build_url
    |> HTTPoison.get
    |> handle_response(subreddit)
  end

  @doc """
  Same as fetch_data, but it returns directly the post
  If an error happens, then it raises an error
  """
  @spec fetch_data(String.t) :: {:ok, [Rexdit.Post.t]}
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
