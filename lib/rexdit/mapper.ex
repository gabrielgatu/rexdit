defmodule Rexdit.Mapper do
  alias Rexdit.Post

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
