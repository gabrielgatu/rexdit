defmodule Rexdit.Mapper do
  alias Rexdit.Post

  @doc """
  Given a data block, result from a httpoison call,
  it parses the content and returns an array contaning
  the posts, on an empty one.
  """
  @spec map_posts(map()) :: [Rexdit.Post.t]
  def map_posts(data) do
    data
    |> Map.get("data")
    |> Map.get("children")
    |> convert_posts_to_struct
  end

  defp convert_posts_to_struct(posts) do
    Enum.map posts, fn post ->
      Map.get(post, "data") |> convert_post_to_struct
    end
  end

  defp convert_post_to_struct(post) do
    fields = ["domain", "subreddit", "author", "thumbnail", "url", "title"]

    Enum.reduce fields, %Post{}, fn(field, acc) ->
      value = Map.get(post, field)
      field = String.to_atom(field)

      Map.put(acc, field , value)
    end
  end
end
