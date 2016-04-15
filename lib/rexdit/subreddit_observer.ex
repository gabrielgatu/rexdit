defmodule Rexdit.SubredditObserver do

  @time_to_sleep 5_000

  def observe(subreddit) do
    spawn fn -> init(subreddit) end
  end

  defp init(subreddit) do
    subreddit
    |> Rexdit.Fetcher.fetch_data
    |> Rexdit.Storage.store_in(subreddit)

    run(subreddit)
  end

  defp run(subreddit) do
    subreddit
    |> Rexdit.Fetcher.fetch_data
    |> get_only_new_posts(subreddit)
    |> case do
      [] -> nil
      [post | _] = posts ->
        Rexdit.Storage.store_in(posts, subreddit)
        Rexdit.Notifier.notify(post)
    end

    :timer.sleep @time_to_sleep
    run(subreddit)
  end

  defp get_only_new_posts(posts, subreddit) do
    posts_stored = Rexdit.Storage.get_for(subreddit)

    Enum.reduce posts, [], fn(post, acc) ->
      case post in posts_stored do
        true -> acc
        false -> [post | acc]
      end
    end
  end
end
