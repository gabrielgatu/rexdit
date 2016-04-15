defmodule Rexdit.Notifier do
  alias Rexdit.Post

  @spec notify(Rexdit.Post.t) :: none()
  def notify(%Post{title: title, author: author, subreddit: subreddit, domain: domain}) do
    subreddit = String.capitalize(subreddit)

    notif_title = title
    notif_content = "|#{subreddit}| By #{author}, on #{domain}"

    show_notification(notif_title, notif_content)
  end

  # Maybe extract a module from this called applex for
  # running applescript from elixir?
  defp show_notification(title, content) do
    command = "osascript"
    arg = '-e display notification "#{content}" with title "#{title}"'

    System.cmd(command, [arg])
  end
end
