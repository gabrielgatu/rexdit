defmodule Rexdit.SubredditObserver do

  # Checks for new posts every 5 minutes
  @time_to_sleep 5 * 60 * 1_000

  @doc """
  Starts observing a subreddit for new posts
  """
  def observe(subreddit) do
    pid = spawn fn -> init(subreddit) end
  end

  defp init(subreddit) do
    subreddit
    |> Rexdit.Fetcher.fetch_data
    |> halt_if_errors(subreddit)
    |> Rexdit.Storage.store_in(subreddit)

    run(subreddit)
  end

  defp run(subreddit) do
    subreddit
    |> Rexdit.Fetcher.fetch_data!
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

  defp halt_if_errors({:error, 400}, subreddit) do
    IO.puts "Error: bad request for subreddit <#{subreddit}>! Process cancelled."
    Process.exit(self(), :exit)
  end

  defp halt_if_errors({:error, 404}, subreddit) do
    IO.puts "Error: subreddit <#{subreddit}> not found! Process cancelled."
    Process.exit(self(), :exit)
  end

  defp halt_if_errors({:ok, posts}, _subreddit) do
    posts
  end
end
